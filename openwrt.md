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


