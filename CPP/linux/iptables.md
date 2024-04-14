# 四表
    1、fliter
    2、nat
    3、mangle
    4、raw

# 五链
    1、INPUT：当接收到防火墙本机地址的数据包（入站）时，应用此链中的规则。
    2、OUTPUT：当防火墙本机向外发送数据包（出战）时，应用此链中的规则。
    3、PREROUTING：在对数据包作路由选择之前，应用此链中的规则。
    4、POSTROUTING：在对数据包作路由选择之后，应用此链中的规则。
    5、FORWARD：当接收到需要通过防火墙发送给其他地址的数据包（转发）时，应用此链中的规则。

# 实践  
## 需求：下挂设备与地面控制中心互通
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/d53f5356-9405-4821-bece-9f262c7c5c40)  
如图所示：车载台设备有4部分组成，分别是：  
1.车载台主机：用于与车载操作终端、车载广播设备以及信道机进行数据交互、转发。  
2.车载操作终端：安卓设备，主要的集群调度功能承载，例如：组呼、点呼、显示控制中心调度命令等，辅助驾驶员与控制中心进行联络。  
3.信道机：信道机的主要作用是驱动5G模块完成驻网、对模块运行状态进行监控、配置NAT规则使地面控制中心能够与下挂设备互通。  
4.5G模块:车载台入网设备，5G无线通信业务承载。 

为实现地面控制中心与车载下挂设备的互通需要在信道机设备上做NAT配置完成数据转发，具体配置脚本如下：  
```
#!/bin/sh /etc/rc.common

START=114

start() {

	tcID=`uci get ta30.config.cfg_tc_id`

	if [ $tcID = "1" ];then
		control_board="192.168.19.1"
		main_board_addr="192.168.19.2"
		android_addr="192.168.19.3"
	else
		control_board="192.168.19.101"
		main_board_addr="192.168.19.102"
		android_addr="192.168.19.103"
	fi
	
	sa_dis_port="64003"

	ftp_port="21"
	tftp_port="69"
	telnet_port="23"
	http_port="80"
	ftps_port="21000"
	
	cb_ftps_port="21001"
	cb_ftp_port="61821"
	cb_tftp_port="61869"
	cb_telnet_port="61823"
	cb_http_port="61880"

	adb_port="5566"
	app_dis_port="64101"

	snmp_port1="161"
	snmp_port2="162"

    # Flush existing rules
    iptables -t nat -F

    # Enable IP forwarding
    sysctl -w net.ipv4.ip_forward=1

    # Enable masquerading for outgoing traffic on the U SB0 interface
    iptables -t nat -A POSTROUTING -o usb0 -j MASQUERADE 

    # DNAT rules
    iptables -t nat -A PREROUTING -i usb0 -p udp --dport $sa_dis_port -j DNAT --to-destination $main_board_addr:$sa_dis_port
    iptables -t nat -A PREROUTING -i usb0 -p udp --dport $snmp_port1 -j DNAT --to-destination $main_board_addr:$snmp_port1
    iptables -t nat -A PREROUTING -i usb0 -p udp --dport $ftps_port -j DNAT --to-destination $main_board_addr:$ftps_port
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport $ftp_port -j DNAT --to-destination $main_board_addr:$ftp_port
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport $tftp_port -j DNAT --to-destination $main_board_addr:$tftp_port
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport $telnet_port -j DNAT --to-destination $main_board_addr:$telnet_port
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport $http_port -j DNAT --to-destination $main_board_addr:$http_port
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport $adb_port -j DNAT --to-destination $android_addr:$adb_port
    iptables -t nat -A PREROUTING -i usb0 -p udp --dport $app_dis_port -j DNAT --to-destination $android_addr:$app_dis_port
    iptables -t nat -A PREROUTING -i usb0 -p udp --dport $cb_ftps_port -j DNAT --to-destination $control_board:$ftps_port
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport $cb_ftp_port -j DNAT --to-destination $control_board:$ftp_port
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport $cb_tftp_port -j DNAT --to-destination $control_board:$tftp_port
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport $cb_telnet_port -j DNAT --to-destination $control_board:$telnet_port
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport $cb_http_port -j DNAT --to-destination $control_board:$http_port

    #B-TrunC
    iptables -t nat -A PREROUTING -i usb0 -p udp --dport 22000:40000 -j DNAT --to-destination $android_addr
    iptables -t nat -A PREROUTING -i usb0 -p tcp --dport 22000:40000 -j DNAT --to-destination $android_addr

```
此处将所有出口数据源IP地址伪装为Wan口(即5G模块驻网后获取到的公网IP)地址,所有从Wan口进入的数据都会根据目的端口转发到不同的下挂设备。  

## 匹配顺序   
iptables 的匹配顺序为：当数据进入系统后会从上至下一次匹配每一条规则，当它匹配到对应的规则后执行 `-J` 后面对应的动作，通常该动作可以是`ACCEPT`、`DROP` 或者`DNAT`。  
现场需要对一些端口做限制访问，例如针对3306端口我们的策略如下：  

```
#允许服务器、网管互访（包括心跳地址、业务地址、未安装的4台调度台）
-A INPUT -s 172.16.120.0/24 -j ACCEPT
-A INPUT -s 172.16.121.0/24 -j ACCEPT

-A INPUT -p tcp -m tcp --dport 3306 -j DROP  #由于我们部署的网元IP在前两个规则放开的网段中所以不会被丢弃，当其他未知设备想要访问3306时会被丢弃
```

