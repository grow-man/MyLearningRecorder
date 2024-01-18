## 查询规则命中  

`iptables -t nat -vS` ,如下所示：  
```
root@TA30-71:~# iptables -t nat -vS
-P PREROUTING ACCEPT -c 6112 999492
-P INPUT ACCEPT -c 941 56452
-P OUTPUT ACCEPT -c 2346 145581
-P POSTROUTING ACCEPT -c 2506 172490
```
命令中的 `-t`表示需要展示的table, `-v`表示显示每个规则的详细信息包括每条规则的匹配数据包与字节数, `-S`表示以规则列表的形式显示table中的规则。  
输出结果中的`-P`表示匹配的规则链.`-c`表示匹配到的数据包以及字节数，其中前一个数字表示匹配到的数据包个数，后一个数字表示字节数。  

## 查询本机所有的iptables规则  

`iptables -t nat -nvL`
