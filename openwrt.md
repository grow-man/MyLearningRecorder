# uloop 编译问题 

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
