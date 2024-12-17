# uloop 

### C与C++函数签名不同造成的编译连接问题  

```
obj-app = dmo_test
obj-dep = $(OBJS) 

CFLAGS  =  -I$(MYSRC)/include -I$(XAU_INCLUDE)
CFLAGS  +=  -I$(DSPUBLIC_INCLUDE) -I$(GOS_INCLUDE) -I$(TX_INCLUDE)
LDLIBS +=  -L$(XAU_LIBDIR) -L$(GOS_LIBDIR)
LDFLAGS += -Wall -lgos -lubox

MYSRC    = ${shell pwd}

BIN_SRC=$(shell echo $(MYSRC)/*.cpp)


OBJS=$(patsubst %.cpp,%.o, $(BIN_SRC))

build: $(obj-app)

$(obj-app):$(obj-dep)
	@echo "BUILD         $(obj-app)  "
	$(CXX) $(LDFLAGS) $(LDLIBS) -o $@ $^
	#@$(CXX) $(CFLAGS) $(LDFLAGS) $(LDLIBS) $(MYLDLIBS) -o $(obj-app) $(obj-dep) $(LDLIBS)

%.o: %.cpp
	$(CXX) $(CFLAGS) -c -o $@ $^

install:
	@echo "INSTALL       $(obj-app)"
	#$(INSTALL_BIN) $(obj-app) $(LTEBIN_SBIN)/
	#$(INSTALL_BIN) $(obj-app) $(TARGET_DIR)/sbin/
```
Makefile如上所示 指定连接libubox库且路径正确但是编译时报连接错误：`dmo_main.cpp:(.text+0x90): undefined reference to `uloop_init()'`  
原因是uloop是C库，在CPP中链接时必须使用  ```extern "C" ```声明函数为C函数，防止链接时名称不一致导致链接错误，修复措施如下：

```
#ifndef _DMO_PUBLIC_H_
#define _DMO_PUBLIC_H_

#ifdef __cplusplus
extern "C" {
#endif

#include    <libubox/uloop.h> /// uloop 是C库连接时需要声明为C函数 否则会有编译错误


#ifdef __cplusplus
}
#endif

#endif 
```
在内部头文件中使用extern"C"将uloop.h包起来,注意其他位置不要再包含`#include    <libubox/uloop.h>`否则会有声明冲突的问题。   

### uloop的实现  
uloop不是多线程实现，在`version:2015-11-08`中uloop_run()函数实现如下：  
```
void uloop_run(void)
{
	static int recursive_calls = 0;
	struct timeval tv;

	/*
	 * Handlers are only updated for the first call to uloop_run() (and restored
	 * when this call is done).
	 */
	if (!recursive_calls++)
		uloop_setup_signals(true);

	uloop_cancelled = false;
	while(!uloop_cancelled)
	{
		uloop_gettime(&tv);
		uloop_process_timeouts(&tv);

		if (do_sigchld)
			uloop_handle_processes();

		if (uloop_cancelled)
			break;

		uloop_gettime(&tv);
		uloop_run_events(uloop_get_next_timeout(&tv));
	}

	if (!--recursive_calls)
		uloop_setup_signals(false);
}
```
可以看到在调用uloop_run 时是一个事件循环,循环监测超时定时器以及进程监控，uloop_run_events 是事件循环的核心部分，它会调用 poll 或 epoll 来等待文件描述符上的事件。uloop_run_events 检测到事件后，会调用相应的回调函数： 
```
static void uloop_run_events(int timeout)
{
	struct uloop_fd_event *cur;
	struct uloop_fd *fd;

	if (!cur_nfds) {
		cur_fd = 0;
		cur_nfds = uloop_fetch_events(timeout); /// epool_wait 等待触发
		if (cur_nfds < 0)
			cur_nfds = 0;
	}

	while (cur_nfds > 0) {
		struct uloop_fd_stack stack_cur;
		unsigned int events;

		cur = &cur_fds[cur_fd++];
		cur_nfds--;

		fd = cur->fd;
		events = cur->events;
		if (!fd)
			continue;

		if (!fd->cb)
			continue;

		if (uloop_fd_stack_event(fd, cur->events))
			continue;

		stack_cur.next = fd_stack;
		stack_cur.fd = fd;
		fd_stack = &stack_cur;
		do {
			stack_cur.events = 0;
			fd->cb(fd, events);
			events = stack_cur.events & ULOOP_EVENT_MASK;
		} while (stack_cur.fd && events);
		fd_stack = stack_cur.next;

		return;
	}
}
```

### 使用uloop时定时器必须声明为全局变量

原因：作用域问题，当你使用uloop_timeout_set()函数添加一个定时器时，uloop并没有拷贝对应的副本，而是将传入参数的指针指向本地定时器链表。  
```
int uloop_timeout_add(struct uloop_timeout *timeout)
{
	struct uloop_timeout *tmp;
	struct list_head *h = &timeouts;

	if (timeout->pending)
		return -1;

	list_for_each_entry(tmp, &timeouts, list) {
		if (tv_diff(&tmp->time, &timeout->time) > 0) {  ///找到链表中第一个超时时间比当前timeout对象的时间晚的节点位置。确保新的超时事件按时间顺序插入链表中，保持链表按超时时间排序
			h = &tmp->list;
			break;
		}
	}

	list_add_tail(&timeout->list, h); /// 此处将传入参数(当前timeout对象)加入定时器链表，注意并未产生拷贝。所以当程序中定时器变量是局部变量时由于作用域的关系该链表中的定时器对象失效,所以不允许将定时器变量设为局部变量
	timeout->pending = true;

	return 0;
}
```


关于这个问题有一个新的疑问：如下代码在调用uloop_timeout_set将定时器加入到超时链表后立即调用uloop_run阻塞，局部定时器地址仍然有效为何程序崩溃？    
```
/// 定时器不能是局部变量
/// struct uloop_timeout stTimeoutGetDMOWorkStatus;

struct uloop_fd stUloopUartFd;
struct uloop_fd stUloopAPPUdpFd;

int main(int argc, char **argv)
{

    struct uloop_timeout stTimeoutGetDMOWorkStatus;
    stTimeoutGetDMOWorkStatus.cb = DMOQueryVersion_cb;

    uloop_init();

    uloop_timeout_set(&stTimeoutGetDMOWorkStatus, 1); /// 设置定时器

    uloop_run(); /// 阻塞 等待回调触发

    uloop_timeout_cancel(&stTimeoutGetDMOWorkStatus); /// 释放定时器资源

    uloop_fd_delete(&stUloopUartFd); /// 释放文件监听资源
    uloop_fd_delete(&stUloopAPPUdpFd);

    uloop_done();
    return 0;
}

```

答案是回调函数，由于定时器在回调执行一次后即失效需要重新设置，此时如果是局部变量则引发未定义行为(在另一个函数中操作main中的局部地址)导致程序崩溃     
```
VOID DMOQueryWorkStatus_cb(struct uloop_timeout *pstTimeOut)
{
    if (!pstTimeOut)
    {
        return ;
    }

    uloop_timeout_set(pstTimeOut, 5000); /// 设置定时器 每5秒查询一次  此处重新设置定时器，如果是局部变量会导致UB，表现为程序崩溃

    DMOQueryWorkStatusReq();
}
``` 

 # 使用ethtool查看网口协商

 ![image](https://github.com/user-attachments/assets/e2b1d77f-35d2-4e74-86fd-a1a846d0b443)  

 ### 相关参数解释如下：

 ```
`ethtool` 是一个用于查询和修改网络接口设备参数的命令工具。你提供的输出信息显示了网络接口 `eth0` 的当前配置和支持的功能。下面是对这些信息的解释：

### 1. `Supported ports: [ TP MII ]`
- **TP (Twisted Pair)**: 代表网络接口支持使用双绞线（通常是以太网电缆）作为物理连接介质。
- **MII (Media Independent Interface)**: 表示该设备支持使用 MII（介质独立接口），这是用来在 MAC 控制器和 PHY 之间传输数据的一种接口。

### 2. `Supported link modes`
- **10baseT/Half, 10baseT/Full**: 表示该接口支持 10 Mbps 的半双工和全双工模式。
- **100baseT/Half, 100baseT/Full**: 表示该接口支持 100 Mbps 的半双工和全双工模式。
- **1000baseT/Full**: 表示该接口支持 1000 Mbps（即 1 Gbps）的全双工模式。注意，这里不包括半双工模式。

### 3. `Supported pause frame use: No`
- 该接口不支持使用暂停帧（pause frames）来控制流量。这意味着它无法通过发送和接收暂停帧来进行流量控制，防止在高负载情况下的丢包。

### 4. `Supports auto-negotiation: Yes`
- 表示该接口支持自动协商（Auto-Negotiation）功能。自动协商是一种协议，它允许以太网设备协商速度和双工模式。

### 5. `Advertised link modes`
- **Advertised link modes** 是该接口通过自动协商向其他设备宣布它能够支持的链路模式。你可以看到，接口声明它支持 10 Mbps、100 Mbps、1000 Mbps 的各种模式。

### 6. `Advertised pause frame use: No`
- 该接口没有宣布支持暂停帧。

### 7. `Advertised auto-negotiation: Yes`
- 接口宣布它支持自动协商功能。

### 8. `Speed: 100Mb/s`
- 当前接口的连接速度为 100 Mbps。

### 9. `Duplex: Full`
- 当前接口的双工模式为全双工（Full-Duplex），表示它可以同时发送和接收数据。

### 10. `Port: MII`
- 该接口使用 MII 接口连接到外部 PHY（物理层芯片）。

### 11. `PHYAD: 0`
- 表示该接口的 PHY 地址为 0。PHY 地址是用来在 MII 或 RMII 总线上标识不同的 PHY 设备。

### 12. `Transceiver: external`
- 该接口使用外部的收发器（transceiver）。

### 13. `Auto-negotiation: on`
- 自动协商功能已开启，这意味着该接口会自动与连接的对端协商最佳的链路速度和双工模式。

### 14. `Current message level: 0x000000ff (255)`
- 这是内核驱动程序调试消息的级别。当前设置为 `255`，这意味着所有类型的消息都会被记录。

### 15. `Link detected: no`
- 该接口未检测到物理链路。这可能意味着电缆没有插入，或连接的对端设备没有启用/配置正确。
 ```

# 磁盘空间耗尽后变为只读挂载  

现象：
1、df-h能看到emmc设备空间耗尽   

2、mount能看到emmc设备正确挂载但是挂载模式从RW->RO   

3、ls -al看不到挂载目录下的文件   

原因：
1、文件系统变成只读 (RO)： 当 eMMC 空间被完全占满后，Linux 文件系统可能会自动将挂载点设置为只读状态，以防止数据损坏。通常情况下，这是由系统检测到文件系统的某种异常或错误引发的。这种行为也可能与文件系统类型（如 ext4、FAT 等）有关。 使用命令dmesg查看异常出现的时间及相关信息，例如：
```
[138819.160000] EXT4-fs error (device sda1) in ext4_da_write_begin:2432: IO failure  
[138819.170000] EXT4-fs (sda1): previous I/O error to superblock detected  
[138819.170000] EXT4-fs error (device sda1): ext4_journal_start_sb:327: Detected aborted journal  
[138819.180000] EXT4-fs (sda1): Remounting filesystem read-only  
```
2、无法显示文件 (ls -al 无法列出目录内容）： 当文件系统空间耗尽时，这可能是因为目录的元数据无法更新或读取失败。  

3、df -h 可以看到空间被占满： 即使文件系统变为只读，df -h 依然可以正常显示文件系统的使用情况。这是因为 df -h 只是读取挂载点的元数据，而不需要对文件系统进行写入操作。  

一般重启设备后可以恢复：1、重启设备时会通过fsck修复磁盘此时会释放部分空间以及重启时会重新将设备挂载为RW。重启后进入系统后需要及时查看哪些文件占用大量空间，及时备份删除恢复磁盘。  


