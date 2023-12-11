- [1. 工作相关QA](#1-工作相关qa)
  - [1.1. 问：如何在markdown文档中插入目录](#11-问如何在markdown文档中插入目录)
  - [1.2. 问: 如何使用 python 读取 excel 文件](#12-问-如何使用-python-读取-excel-文件)
  - [1.3. 问: python 转换 word 到 md 文件](#13-问-python-转换-word-到-md-文件)
  - [1.4. 问: VSCode 插件 `Log File Highlighter` 如何配置](#14-问-vscode-插件-log-file-highlighter-如何配置)
  - [1.5. 问: VSCode 插件 `Doxygen Documentation Generator` 如何配置](#15-问-vscode-插件-doxygen-documentation-generator-如何配置)
  - [1.6. 问: 如何自动安装python脚本需要的库](#16-问-如何自动安装python脚本需要的库)
  - [1.7. watchdog 使用说明](#17-watchdog-使用说明)
  - [1.8. SNMP 协议介绍](#18-snmp-协议介绍)
  - [1.9. 问: CentOS7 bash 出现错误 -bash: 警告:setlocale: LC\_CTYPE: 无法改变区域选项 (UTF-8): 没有那个文件或目录](#19-问-centos7-bash-出现错误--bash-警告setlocale-lc_ctype-无法改变区域选项-utf-8-没有那个文件或目录)
  - [1.10. 问: snmp 报文和 trap 报文 分别是什么](#110-问-snmp-报文和-trap-报文-分别是什么)
  - [1.11. 问: 如何查看CentOS电脑的内存信息](#111-问-如何查看centos电脑的内存信息)
  - [1.12. 问: 如何查看CentOS电脑的CPU信息](#112-问-如何查看centos电脑的cpu信息)
  - [1.13. 问: GMT，CST，UTC 分别是什么？](#113-问-gmtcstutc-分别是什么)
  - [1.14. 问: 如何进入 docker 中某个容器的日志](#114-问-如何进入-docker-中某个容器的日志)
  - [1.15. 问: 如何进入 docker 中某个容器的命令行](#115-问-如何进入-docker-中某个容器的命令行)
  - [1.16. 问: 如何查看 docker 中当前的正在运行的容器](#116-问-如何查看-docker-中当前的正在运行的容器)
  - [1.17. 问: 一条命令导出当前分支所有 commit](#117-问-一条命令导出当前分支所有-commit)
  - [1.18. 问: git submodule 如何初始化特定子模块](#118-问-git-submodule-如何初始化特定子模块)
  - [1.19. 问: 为何推荐使用 `nullptr` 替代 `NULL` 和 `0`](#119-问-为何推荐使用-nullptr-替代-null-和-0)
  - [1.20. 问: 如何使用 python 遍历文件夹并生成 md 格式文件](#120-问-如何使用-python-遍历文件夹并生成-md-格式文件)
  - [1.21. 问: C++ 为何推荐使用匿名命名空间而非 static 关键字](#121-问-c-为何推荐使用匿名命名空间而非-static-关键字)
  - [1.22. 问: C++ 如何计算百分数(保留两位小数)字符串](#122-问-c-如何计算百分数保留两位小数字符串)
  - [1.23. 问: 如何使用everything搜索局域网共享文件夹](#123-问-如何使用everything搜索局域网共享文件夹)
  - [1.24. 问: 如何使用 C++ 生成 csv 文件](#124-问-如何使用-c-生成-csv-文件)
  - [1.25. 问: C++ 解析pcap文件中的 udp 报文](#125-问-c-解析pcap文件中的-udp-报文)
  - [1.26. 问: google 自定义不搜索特定网站](#126-问-google-自定义不搜索特定网站)
  - [1.27. 问: google 搜索技巧](#127-问-google-搜索技巧)
  - [1.28. 问: 如何使用 gperftools 查看函数调用火焰图](#128-问-如何使用-gperftools-查看函数调用火焰图)
  - [1.29. 问: perf 基本用法](#129-问-perf-基本用法)
  - [1.30. 问: 如何创建本地ssh-key](#130-问-如何创建本地ssh-key)
  - [1.31. 问:Openwrt配置vlan的方法](#131-问openwrt配置vlan的方法)
  - [1.32. 问: 如何使用 clang-format 不格式化某些文件](#132-问-如何使用-clang-format-不格式化某些文件)
  - [1.33. 问: 如何计算某个文件夹下，代码文件的注释占所有行数的比例](#133-问-如何计算某个文件夹下代码文件的注释占所有行数的比例)
  - [1.34. 问: 如何计算某个文件夹下，代码文件的空行、注释和代码行数](#134-问-如何计算某个文件夹下代码文件的空行注释和代码行数)
  - [1.35. 问: 如何查找某个文件夹下所有文件的行数](#135-问-如何查找某个文件夹下所有文件的行数)
  - [1.36. 问: cmake 脚本中如何让一个变量表示某文件夹下所有源文件](#136-问-cmake-脚本中如何让一个变量表示某文件夹下所有源文件)
  - [1.37. 问:如何在centos上配置telnet服务](#137-问如何在centos上配置telnet服务)
  - [1.38. 问:如何在centos上配置ntp服务器](#138-问如何在centos上配置ntp服务器)
  - [1.39. 问: 如何在 CMake 脚本中初始化 git 子模块](#139-问-如何在-cmake-脚本中初始化-git-子模块)
  - [1.40. 问: 如何初始化一个包含 `.gitmodules` 文件的仓库](#140-问-如何初始化一个包含-gitmodules-文件的仓库)
  - [1.41. 问: MySQL 如何使用分页查询](#141-问-mysql-如何使用分页查询)
  - [1.42. 问: 如何在 `gitlab` 库中创建并使用 `issue` 模板](#142-问-如何在-gitlab-库中创建并使用-issue-模板)
  - [1.43. 问: 如何使用文件编号查询某文件夹下的文件名称](#143-问-如何使用文件编号查询某文件夹下的文件名称)
  - [1.44. 问: 设备软件安装目录规范](#144-问-设备软件安装目录规范)
  - [1.45. 问: googletest 如何运行测试的子集](#145-问-googletest-如何运行测试的子集)
  - [1.46. 问：Centos 使用 yum 后使用 cmake 出现 libstdc++.so 链接错误](#146-问centos-使用-yum-后使用-cmake-出现-libstdcso-链接错误)
  - [1.47. 问：如何使用 coredump 进行调试，以主板中 sa 软件为例](#147-问如何使用-coredump-进行调试以主板中-sa-软件为例)
  - [1.48. 问：使用后 yum 命令后， libstdc++ 出现链接错误](#148-问使用后-yum-命令后-libstdc-出现链接错误)
  - [1.49. 问：如何使用iperf3打流](#149-问如何使用iperf3打流)
  - [1.50. 问：如何从抓包文件中提取amr音频流并播放](#150-问如何从抓包文件中提取amr音频流并播放)
  - [1.51. 问：如何查看文件的 md5 数值](#151-问如何查看文件的-md5-数值)
  - [1.52. 问：如何在抓包中导出 rtp 音频进行分析](#152-问如何在抓包中导出-rtp-音频进行分析)
  - [1.53. 问: 如何 git 如何拉取远程仓库的指定分支](#153-问-如何-git-如何拉取远程仓库的指定分支)
  - [1.54. 问：windows 上 mysql5.7 如何允许远程访问？](#154-问windows-上-mysql57-如何允许远程访问)
  - [1.55. 问： wireshark 抓包时出现提示 failed to set hardware filter to promiscuous mode: 连到系统上的设备没有发挥作用。](#155-问-wireshark-抓包时出现提示-failed-to-set-hardware-filter-to-promiscuous-mode-连到系统上的设备没有发挥作用)
  - [1.56. 问：wireshark 中混杂模式指的是什么意思？](#156-问wireshark-中混杂模式指的是什么意思)
  - [1.57. 问: `error while loading shared libraries` 加载动态库失败如何解决？](#157-问-error-while-loading-shared-libraries-加载动态库失败如何解决)
  - [1.58. 问： `FAQ` 是什么？](#158-问-faq-是什么)
  - [1.59. 问： `Q&A` 是什么?](#159-问-qa-是什么)
  - [1.60. 问： Centos7 如何源码编译 git](#160-问-centos7-如何源码编译-git)
  - [1.61. 问： Centos定位查找文件命令](#161-问-centos定位查找文件命令)
  - [1.62. 问： `Centos7` 如何源码编译 gcc/g++](#162-问-centos7-如何源码编译-gccg)
  - [1.63. 问： `Centos7` 如何关闭防火墙](#163-问-centos7-如何关闭防火墙)
  - [1.64. 问: `Centos7` 设置笔记本合盖不休眠](#164-问-centos7-设置笔记本合盖不休眠)
  - [1.65. 问: `Centos7` 如何在命令行链接 `wifi`](#165-问-centos7-如何在命令行链接-wifi)
  - [1.66. 问：调度台现场问题排查取证的方法](#166-问调度台现场问题排查取证的方法)
  - [1.67. 问：windows/linux如何添加静态路由](#167-问windowslinux如何添加静态路由)
  - [1.68. 问：windows/linux查询端口状态](#168-问windowslinux查询端口状态)
  - [1.69. 问：检测网络是否可达的方法](#169-问检测网络是否可达的方法)
  - [1.70. 问：Linux服务器登录方法](#170-问linux服务器登录方法)
  - [1.71. 问：Linux主机登录方法](#171-问linux主机登录方法)
  - [1.72. 问: `DELL`服务器`iDRAC`远程控制设置](#172-问-dell服务器idrac远程控制设置)
  - [1.73. 问: 如何生成 GitLab 的 `Private Token`](#173-问-如何生成-gitlab-的-private-token)
  - [1.74. 问: 如何改变 `Centos7` 的主机名称](#174-问-如何改变-centos7-的主机名称)
  - [1.75. 问: CentoS7以上使用fdisk对4T磁盘进行分区, 对home进行扩容](#175-问-centos7以上使用fdisk对4t磁盘进行分区-对home进行扩容)
  - [1.76. 问: EN50128 中 D.52 提到的结构化方法](#176-问-en50128-中-d52-提到的结构化方法)
  - [1.77. 问: ssh 如何免密登录](#177-问-ssh-如何免密登录)
  - [1.78. 问: MySQL 如何避免长事务对业务的影响？](#178-问-mysql-如何避免长事务对业务的影响)
  - [1.79. 问: MySQL 使用长连接后有时因为返回的结果集过大，导致内存增长过快，如何解决?](#179-问-mysql-使用长连接后有时因为返回的结果集过大导致内存增长过快如何解决)
  - [1.80. 问: 正则表达式, 如何匹配 xxx (ms)](#180-问-正则表达式-如何匹配-xxx-ms)
  - [1.81. 问: 正则表达式，如何选中不带有文本 172.2.200.66 的行](#181-问-正则表达式如何选中不带有文本-172220066-的行)
  - [1.82. 问: wireshark 报文中 ICMP 报文出现 Destination unreachable (Port unreachable),为什么会出现这个错误](#182-问-wireshark-报文中-icmp-报文出现-destination-unreachable-port-unreachable为什么会出现这个错误)
  - [1.83. 问： 华为核心网服务安装要点](#183-问-华为核心网服务安装要点)
  - [1.84. 问: 如何转换 md 文件为 latex 文件](#184-问-如何转换-md-文件为-latex-文件)
  - [1.85. 问: g++ 编译选项 `-Wl,--no-as-needed` 是什么意思？](#185-问-g-编译选项--wl--no-as-needed-是什么意思)
  - [1.86. 问: 出现编译警告 `warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking`](#186-问-出现编译警告-warning-using-getaddrinfo-in-statically-linked-applications-requires-at-runtime-the-shared-libraries-from-the-glibc-version-used-for-linking)
  - [1.87. 问: 如何查看 centos7 通过 yum 安装了哪些软件](#187-问-如何查看-centos7-通过-yum-安装了哪些软件)
  - [1.88. 问: 如何自动统计最近一次 git 提交中增加或删除的代码行数](#188-问-如何自动统计最近一次-git-提交中增加或删除的代码行数)
  - [1.89. 问: ubuntu 如何查看cpu温度](#189-问-ubuntu-如何查看cpu温度)
  - [1.90. 问: 初次使用 git 需要进行的配置](#190-问-初次使用-git-需要进行的配置)
  - [1.91. 问: NAT 是啥](#191-问-nat-是啥)
  - [1.92. 问: IPSec 是啥](#192-问-ipsec-是啥)
  - [1.93. 问: mysql 如何实现主主复制](#193-问-mysql-如何实现主主复制)
  - [1.94. 问：如何批量删除日志文件中的空行](#194-问如何批量删除日志文件中的空行)
  - [1.95. 问: 如何把日志中大量重复日志删除](#195-问-如何把日志中大量重复日志删除)
  - [1.96. 问: 什么是 SQA ?](#196-问-什么是-sqa-)
  - [1.97. 问: 什么是 8D 分析](#197-问-什么是-8d-分析)
  - [1.98. 问: 重启电脑后 docker desktop 一直卡在启动中](#198-问-重启电脑后-docker-desktop-一直卡在启动中)
  - [1.99. 问: CSDN 如何不登陆复制代码?](#199-问-csdn-如何不登陆复制代码)
  - [1.100. 问: MySQL 如何查看数据库中所有表的行数](#1100-问-mysql-如何查看数据库中所有表的行数)
  - [1.101. 问: Centos7 如何查询磁盘挂载与占用情况](#1101-问-centos7-如何查询磁盘挂载与占用情况)
  - [1.102. 问: git 如何通过命令返回指定时间的 commit 信息](#1102-问-git-如何通过命令返回指定时间的-commit-信息)
  - [1.103. 问: wsl 镜像如何导入与导出](#1103-问-wsl-镜像如何导入与导出)
  - [1.104. 问: centos 查看系统版本](#1104-问-centos-查看系统版本)
  - [1.105. 问: openEuler 查看系统版本](#1105-问-openeuler-查看系统版本)
  - [1.106. 问: ubuntu 安装 32 位 libmysql](#1106-问-ubuntu-安装-32-位-libmysql)
  - [1.107. 问: ubuntu 查看已安装软件](#1107-问-ubuntu-查看已安装软件)
  - [1.108. 问: mysql 批量插入过程](#1108-问-mysql-批量插入过程)
  - [1.109. 问: centos7 中 查找所有运行的端口](#1109-问-centos7-中-查找所有运行的端口)
  - [1.110. 问: 查看被占用端口对应的 PID](#1110-问-查看被占用端口对应的-pid)
  - [1.111. 问: 查看指定 PID 的进程](#1111-问-查看指定-pid-的进程)
  - [1.112. 问: 替换 sh 脚本中的 window 字符 ^M](#1112-问-替换-sh-脚本中的-window-字符-m)
  - [1.113. 问: 查看可执行文件依赖的 动态库](#1113-问-查看可执行文件依赖的-动态库)
  - [1.114. 问: 获取 GitLab 指定库中所有 open 状态下的 issue](#1114-问-获取-gitlab-指定库中所有-open-状态下的-issue)
  - [1.115. 问: 获取 GitLab 指定库中拥有 Bug 标签的 issue 并导出到文件 bug.json](#1115-问-获取-gitlab-指定库中拥有-bug-标签的-issue-并导出到文件-bugjson)
  - [1.116. 问: google/benchmark 执行对应的性能测试](#1116-问-googlebenchmark-执行对应的性能测试)
  - [1.117. 问: cmake 全部编译](#1117-问-cmake-全部编译)
  - [1.118. 问: cmake 编译 gos 单元测试](#1118-问-cmake-编译-gos-单元测试)
  - [1.119. 问: cmake 重新生成](#1119-问-cmake-重新生成)
  - [1.120. 问: CMake 运行测试](#1120-问-cmake-运行测试)
  - [1.121. 问:CMake指定MSVC运行时库](#1121-问cmake指定msvc运行时库)
  - [1.122. 问:为何官网下载的googleTest框架的运行时库缺省为/MT 不能修改](#1122-问为何官网下载的googletest框架的运行时库缺省为mt-不能修改)
  - [1.123. 问: ubuntu 替换清华源](#1123-问-ubuntu-替换清华源)
  - [1.124. 问：调度台软件登录时，提示音频加载失败](#1124-问调度台软件登录时提示音频加载失败)
  - [1.125. 问：调度台和调度服务器网络正常时，调度台提示连接二开调度服务器失败](#1125-问调度台和调度服务器网络正常时调度台提示连接二开调度服务器失败)
  - [1.126. 问：调度台软件打开后，登录界面，登录和退出按钮错位。](#1126-问调度台软件打开后登录界面登录和退出按钮错位)
  - [1.127. 问：调度台软件左下角指示灯，LTE爆红、CAD爆红、ATS爆红、NTP爆红](#1127-问调度台软件左下角指示灯lte爆红cad爆红ats爆红ntp爆红)
  - [1.128. 问：人工广播发起后，没有返回广播状态，无法开始广播。](#1128-问人工广播发起后没有返回广播状态无法开始广播)
  - [1.129. 问：人工广播发起后，按下PTT说话车上没有听到广播声音。](#1129-问人工广播发起后按下ptt说话车上没有听到广播声音)
  - [1.130. 问：预录音广播发起后，没有收到广播状态。](#1130-问预录音广播发起后没有收到广播状态)
  - [1.131. 问：预录音广播发起后，实际播放次数和调度台选择次数不符。](#1131-问预录音广播发起后实际播放次数和调度台选择次数不符)
  - [1.132. 问：IPH报警器触发后，调度台没有显示IPH请求](#1132-问iph报警器触发后调度台没有显示iph请求)
  - [1.133. 问：IPH报警器触发，调度台接听后，报警器还处于未接通状态](#1133-问iph报警器触发调度台接听后报警器还处于未接通状态)
  - [1.134. 问：IPH报警器触发后，调度台接听但没有视频。](#1134-问iph报警器触发后调度台接听但没有视频)
  - [1.135. 问：IPH报警器触发后，调度台接听但听不到报警器语音的声音。](#1135-问iph报警器触发后调度台接听但听不到报警器语音的声音)
  - [1.136. 问：调度台可以听到未监听的未知组号的组呼](#1136-问调度台可以听到未监听的未知组号的组呼)
  - [1.137. 问： 对群组进行组呼时出现抢权失败，出现抢权提示音。](#1137-问-对群组进行组呼时出现抢权失败出现抢权提示音)
  - [1.138. 问：短信出现提示提示音但没有短信记录](#1138-问短信出现提示提示音但没有短信记录)
  - [1.139. 问：调度台视频上拉时，选择不需要确认直接拉取时手持台还需要进行确认](#1139-问调度台视频上拉时选择不需要确认直接拉取时手持台还需要进行确认)
  - [1.140. 问：数据库无法远程通过root访问](#1140-问数据库无法远程通过root访问)
  - [1.141. 问：数据库开机不会自动启动](#1141-问数据库开机不会自动启动)
  - [1.142. 问：dis进程打开后闪退，dis.log显示数据库连接错误](#1142-问dis进程打开后闪退dislog显示数据库连接错误)
  - [1.143. 问：dis开启后，dis.log中显示数据库有字段找不到](#1143-问dis开启后dislog中显示数据库有字段找不到)
  - [1.144. 问：如何查看进程是否正常启动并运行](#1144-问如何查看进程是否正常启动并运行)
  - [1.145. 问：服务器数据库备份设置，如何手动复原数据库内容](#1145-问服务器数据库备份设置如何手动复原数据库内容)
  - [1.146. 问：18号线车载台终端信道机自检项不通过，如何修复。](#1146-问18号线车载台终端信道机自检项不通过如何修复)
  - [1.147. 问：18号线手柄一直处于摘机状态](#1147-问18号线手柄一直处于摘机状态)
  - [1.148. 问：18号线车载台终端主机自检项不通过](#1148-问18号线车载台终端主机自检项不通过)
  - [1.149. 问：车载台出现信道机自检不过，PLMN获取不到](#1149-问车载台出现信道机自检不过plmn获取不到)
  - [1.150. 问：车载台登录不上去，一直处于登录界面](#1150-问车载台登录不上去一直处于登录界面)
  - [1.151. 问：车载台终端话柄爆红](#1151-问车载台终端话柄爆红)
  - [1.152. 问：车载台终端右上角主机、dis状态爆红](#1152-问车载台终端右上角主机dis状态爆红)
  - [1.153. 问：车载台终端右上角IPH/PA爆红](#1153-问车载台终端右上角iphpa爆红)
  - [1.154. 问：车载台终端触屏不灵](#1154-问车载台终端触屏不灵)
  - [1.155. 问：车载台终端扬声器没声音](#1155-问车载台终端扬声器没声音)
  - [1.156. 问：车载台终端出现黑屏](#1156-问车载台终端出现黑屏)
  - [1.157. 问：如何验证18号线固定台的车站广播功能](#1157-问如何验证18号线固定台的车站广播功能)
  - [1.158. 问：18号线固定台车站广播出现故障，无声音放出](#1158-问18号线固定台车站广播出现故障无声音放出)
  - [1.159. 问：网管服务器vsftp服务无法正常启动](#1159-问网管服务器vsftp服务无法正常启动)
  - [1.160. 问：ftp无法登陆服务器，ls无法看到文件](#1160-问ftp无法登陆服务器ls无法看到文件)
  - [1.161. 问：设备如何被网管纳管](#1161-问设备如何被网管纳管)
  - [1.162. 问：系统状态中CAD服务器、录音录像服务器图标一直成灰色，设备上线也是灰色状态，或者设备列表中调度台设备的名称为空白](#1162-问系统状态中cad服务器录音录像服务器图标一直成灰色设备上线也是灰色状态或者设备列表中调度台设备的名称为空白)
  - [1.163. 问：如何快速查看所有设备的版本信息内容和统计](#1163-问如何快速查看所有设备的版本信息内容和统计)
  - [1.164. 问：如何导出活跃告警和历史告警](#1164-问如何导出活跃告警和历史告警)
  - [1.165. 问：使用网管对主机版本进行升级](#1165-问使用网管对主机版本进行升级)
  - [1.166. 问：如何进行告警配置，类似固定台的PA连接失败告警，因为固定台不需要和PA进行对接，该项告警没必要出现。](#1166-问如何进行告警配置类似固定台的pa连接失败告警因为固定台不需要和pa进行对接该项告警没必要出现)
  - [1.167. 问：录音录像服务器配置](#1167-问录音录像服务器配置)
  - [1.168. 问：录音录像的文件怎么导出](#1168-问录音录像的文件怎么导出)
- [沟通相关FAQ](#沟通相关faq)
  - [对外反馈问题时出现的问题](#对外反馈问题时出现的问题)
  - [现场反馈问题](#现场反馈问题)


# 1. 工作相关QA

## 1.1. 问：如何在markdown文档中插入目录 

答：
1. 如果你使用VS Code 首先你需要安装Markdown All in One插件
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/3e6cadae-fe97-4b07-9358-1c40db785976)

   
2. 按住`ctrl + shift + p`打开命令面板,并输入`Add/Update section numbers`,添加章节序号。 非必须
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/10b56e73-42ea-4562-a3e8-55f97d07894c)


3. 按住`ctrl + shift + p`打开命令面板,并输入`Create Table of Contents`,添加目录。
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/a8ff0b81-d9f5-4eef-bad2-adf6e5ce884b)


## 1.2. 问: 如何使用 python 读取 excel 文件

```python
import pandas as pd
from tabulate import tabulate

# 读取 Excel 文件
df = pd.read_excel('input.xlsx')

# 将数据转换为 Markdown 表格
md_table = tabulate(df, headers='keys', tablefmt='pipe')

# 写入 Markdown 文件
with open('output.md', 'w') as f:
    f.write(md_table)
```

## 1.3. 问: python 转换 word 到 md 文件

```python
from docx import Document

def convert_word_to_md(file_path):
    doc = Document(file_path)
    md_content = ""

    for paragraph in doc.paragraphs:
        md_content += paragraph.text + "\n\n"

    return md_content

# 调用示例
word_file = "xx.docx"
md_content = convert_word_to_md(word_file)

# 写入 md 文件
with open("xx.md", "w", encoding="utf-8") as f:
    f.write(md_content)
```

## 1.4. 问: VSCode 插件 `Log File Highlighter` 如何配置

1. 打开(Ctrl+P) VSCode 的 `settings.json` 文件
2. 添加以下配置

```json
  "logFileHighlighter.customPatterns": [
    {
      /// 错误，必须处理的问题
      "pattern": "exception|ERROR|error|FATAL|fatal|critical|FAILED|bad_variant_access",
      "foreground": "#FF0000"
    },
    {
      /// 警告，必须注意的信息
      "pattern": "require type: .{1,5},|SetDevInfo: |SendSnmpGetReq success!| null |since last log time|WARN|warn|warning|percent: 99.|percent: 100| \\b(?:9\\d(?:\\.\\d{1,2})?|100(?:\\.0{1,2})?)%|\\(s\\)",
      "foreground": "#FFFF00"
    },
    {
      /// 信息，值得注意的信息
      "pattern": "not online, donot check dev|New devices connect to the OMC|SendTextMessage all success|(\"DCCapacityPos\":｜get APP request call|INFO  |info |RUN|OK|PASSED|Send DC handle req call which have ulDCCapaCity|spPID->usInstID|spPID->usTaskID|link auth successful, client|RequestCallReq|Dialling is handle as link call.|Function Avg Time:|frequency count|get SA msg:|server_close_connect|OnServerDisconnectClient usClientID|tcp_send: send failed, Socket|SetButtonStatus|get request call|is not need save link group call|handle auto pick up group|Dialling is handle as group call.|eSDK_SendSMS|Skip not auto pick up group|is not auto pick up!|get app request call|Group Call Speaker Change:|OnRequestCallReq|\\(31\\)|\\(34\\)|\\(36\\))",
      "foreground": "#42B883"
    },
    {
      /// 调试，用于调试程序的信息
      "pattern": "debug|Debug|DEBUG|Spend Time|Memory Change|Total Time|interval_time_factory",
      "foreground": "#007FFF"
    },
    {
      /// 详细信息，可以忽略的信息
      "pattern": "DETAIL|detail",
      "foreground": "#2F90B9"
    },
    {
      /// 当前关注的信息（需要每次更新）
      "pattern": "(6021102|172\\.2\\.200\\.22)",
      "foreground": "#000000",
      "background": "#19F334"
    }
  ]
```

## 1.5. 问: VSCode 插件 `Doxygen Documentation Generator` 如何配置

1. 打开(Ctrl+P) VSCode 的 `settings.json` 文件
2. 添加以下配置
```json
  "doxdocgen.generic.useGitUserEmail": true,
  "doxdocgen.generic.useGitUserName": true,
  "doxdocgen.generic.dateFormat": "YYYY-MM-DD HH:mm:ss",
  "doxdocgen.file.fileTemplate": "@file {indent:17}{name}",
  "doxdocgen.generic.briefTemplate": "@brief {indent:17}{text}",
  "doxdocgen.generic.dateTemplate": "@date {indent:17}{date}",
  "doxdocgen.generic.paramTemplate": "@param {indent:17}{param}    []",
  "doxdocgen.generic.authorTag": "@author          {author}({email})",
  "doxdocgen.file.versionTag": "",
  "doxdocgen.generic.returnTemplate": "@return {indent:17}{type} ",
  "doxdocgen.file.fileOrder": [
    "file",
    "brief",
    "author",
    /// "version",
    "date",
    "copyright"
  ],
  "doxdocgen.generic.order": [
    "brief",
    "param",
    "return",
    /// "empty",
    "custom"
  ],
  "doxdocgen.generic.customTags": [
    "@author          {author}({email})",
    "@date            {date}"
  ],
  "doxdocgen.file.copyrightTag": [
    "@copyright {indent:17}Copyright (c) 2021-{year} GBCOM"
  ],
```

## 1.6. 问: 如何自动安装python脚本需要的库

1. 在 py 文件的同目录运行一下命令，生成 requirements.txt 文件


```shell
pipreqs ./ --encoding=utf8
```

2. 运行命令安装依赖库

```shell
pip install -r requirements.txt
```

## 1.7. watchdog 使用说明

[WatchDog使用说明.docx](uploads/f5afefa5338bce37f5732a95cc09affd/WatchDog使用说明.docx)

## 1.8. SNMP 协议介绍

GitHub Copilot: SNMP（Simple Network Management Protocol）是一种用于管理和监控网络设备的标准协议。SNMP协议定义了一组消息格式和通信规则，使得网络管理系统可以与网络设备进行交互，并获取设备的状态信息、配置参数等。

SNMP的标准协议文档由多个RFC（Request for Comments）文档组成。以下是一些与SNMP相关的主要RFC文档：

1. RFC 1155: 定义了SNMP的基本数据类型，如整数、字符串、对象标识符等。

2. RFC 1157: 定义了SNMP的第一个版本（SNMPv1），包括消息格式、管理信息库（MIB）等。

3. RFC 1901-1908: 定义了SNMP的第二个版本（SNMPv2），引入了更多的功能和改进，如SNMPv2c、SNMPv2u、SNMPv2p等。

4. RFC 3411-3418: 定义了SNMP的第三个版本（SNMPv3），引入了安全性和认证机制，如用户身份验证、消息加密等。

除了这些主要的RFC文档外，还有许多其他的RFC文档涵盖了SNMP的各个方面，如MIB定义、SNMP协议的扩展等。

您可以通过访问IETF（Internet Engineering Task Force）的网站`https://www.ietf.org/` 来获取完整的SNMP标准协议文档。在该网站上，您可以搜索并找到与SNMP相关的RFC文档，并下载阅读它们。

## 1.9. 问: CentOS7 bash 出现错误 -bash: 警告:setlocale: LC_CTYPE: 无法改变区域选项 (UTF-8): 没有那个文件或目录

```sh
# 安装中文语言包
sudo yum install -y langpacks-zh_CN
vim /etc/locale.conf
# 增加以下内容
LANG="zh_CN.UTF-8"
LC_CTYPE="zh_CN.UTF-8"
# 重新生成区域信息
sudo localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8
```

## 1.10. 问: snmp 报文和 trap 报文 分别是什么

SNMP（Simple Network Management Protocol）报文和 Trap 报文是与网络管理相关的概念。


1. SNMP 报文：SNMP 报文是用于在网络中传输管理信息的数据单元。它可以包含请求（Get、GetNext、Set 等）和响应（Response）等类型的消息，用于管理网络中的设备和资源。SNMP 报文通常包含操作类型、OID（Object Identifier）、值等信息，以便进行网络管理操作。
2. Trap 报文：Trap 报文是一种异步通知机制，用于在网络中向管理站点发送事件通知。当网络设备或代理发生特定事件时（如端口状态改变、温度超过阈值等），它会生成一个 Trap 报文并发送给管理站点，以便管理站点可以及时响应和处理相关事件。  

这些报文在 SNMP 协议中扮演着重要的角色，用于实现网络设备的监控、配置和故障处理等管理功能。

## 1.11. 问: 如何查看CentOS电脑的内存信息

```shell
free -m
```

## 1.12. 问: 如何查看CentOS电脑的CPU信息

```shell
cat /proc/cpuinfo |more
```

## 1.13. 问: GMT，CST，UTC 分别是什么？

1. UTC(世界标准时间)

协调世界时，又称世界标准时间或世界协调时间，简称UTC（从英文“Coordinated Universal Time”而来），是最主要的世界时间标准，其以原子时秒长为基础，在时刻上尽量接近于格林尼治标准时间。

2. GMT(格林尼治平时)

格林尼治平时（又称格林尼治平均时间或格林尼治标准时间，旧译格林威治标准时间；英语：Greenwich MeanTime，GMT）是指位于英国伦敦郊区的皇家格林尼治天文台的标准时间，因为本初子午线被定义在通过那里的经线。


理论上来说，格林尼治标准时间的正午是指当太阳横穿格林尼治子午线时（也就是在格林尼治上空最高点时）的时间。由于地球在它的椭圆轨道里的运动速度不均匀，这个时刻可能与实际的太阳时有误差，最大误差达16分钟。


由于地球每天的自转是有些不规则的，而且正在缓慢减速，因此格林尼治时间已经不再被作为标准时间使用。现在的标准时间，是由原子钟报时的协调世界时（UTC）。

3. CST(北京时间)

北京时间，China Standard Time，中国标准时间。在时区划分上，属东八区，比协调世界时早8小时，记为UTC+8。

## 1.14. 问: 如何进入 docker 中某个容器的日志

```shell
docker logs <container_id_or_name>
```

## 1.15. 问: 如何进入 docker 中某个容器的命令行

```shell
docker exec -it <container_id_or_name> bash
```

## 1.16. 问: 如何查看 docker 中当前的正在运行的容器

```shell
docker ps
```

## 1.17. 问: 一条命令导出当前分支所有 commit

```c++
git log --no-merges 721bfa7..HEAD --date=iso --pretty=format:'%h|%s|%an|%ad|' --shortstat | sed '/^$/d' | sed -n '1h;1!H;${g;s/|\n/,/g;p;}' > /home/commits.csv
```

## 1.18. 问: git submodule 如何初始化特定子模块

```c++
git submodule update --init <submodule_path>
```

## 1.19. 问: 为何推荐使用 `nullptr` 替代 `NULL` 和 `0`

1. CppCoreGuidelines: [ES.47: Use nullptr rather than 0 or NULL](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#es47-use-nullptr-rather-than-0-or-null)


## 1.20. 问: 如何使用 python 遍历文件夹并生成 md 格式文件

```python
import os
import re

def get_directory_files(path, pattern, is_recursive):
    if not os.path.exists(path):
        return []

    vec = []
    for root, dirs, files in os.walk(path):
        for file in files:
            if not os.path.isdir(file):
                file_name = os.path.basename(file)
                if re.match(pattern, file_name):
                    vec.append(os.path.join(root, file))

        if not is_recursive:
            break

    # vec.sort()
    return vec

if __name__ == '__main__':
    vec = get_directory_files('.', r'.*\.*', True)

    record = []
    for file in vec:
        file_name = os.path.basename(file)
        record.append((file_name, file))

    # for it in record:
    #     print(f'file name: {it[0]}, file path: {it[1]}')

    # 写入 md 文档
    with open('file_path.md', 'w') as f:
        f.write('# 文件路径\n\n')
        for it in record:
            f.write(f'[{it[0]}]({it[1]}): {it[1]}\n\n')
```

## 1.21. 问: C++ 为何推荐使用匿名命名空间而非 static 关键字

1. [`Cpp Core Guideline`](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#sf22-use-an-unnamed-anonymous-namespace-for-all-internalnon-exported-entities): SF.22: Use an unnamed (anonymous) namespace for all internal/non-exported entities
2. 匿名命名空间可以修饰 class，而 static 关键字不能修饰 class
3. 对于一组多个标识符函数只需要使用一个匿名空间来声明，不需要多次输入static。
4. 注意: 不能在 .h 文件中使用匿名命名空间，否则会导致链接错误
举例:

```c++
/// xx.cpp
namespace
{
    int f();
    bool h();
    class c { /* ... */ };
}
```

参考:

[C++ 匿名命名空间](https://www.cnblogs.com/youxin/p/4308364.html)

## 1.22. 问: C++ 如何计算百分数(保留两位小数)字符串

```c++
#include <sstream>  // 包含头文件以使用 std::ostringstream
#include <iomanip>  // 包含头文件以使用 std::setprecision
std::string calculatePercentage(int value, int all_count) {
    double result = static_cast<double>(value) / all_count;  // 将其中一个操作数转换为 double 类型，以得到浮点数除法的结果

    // 使用 std::ostringstream 构建包含格式化数据的字符串
    std::ostringstream oss;
    oss << std::fixed << std::setprecision(2) << result * 100 << "%";

    // 返回构建的字符串
    return oss.str();
}
```

## 1.23. 问: 如何使用everything搜索局域网共享文件夹

打开everything，点击工具-选项-文件夹，点击添加，然后在网络里找到共享服务器文件夹，也可以直接在输入框里直接输入路径; 设置完成后重启everything，让它重新索引\
注意: 一定要输入文件夹路径，只输入服务器地址是不行的

## 1.24. 问: 如何使用 C++ 生成 csv 文件

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

// 生成 CSV 文件的函数
void generateCSV(const std::string& filename, const std::vector<std::vector<std::string>>& data) {
    std::ofstream file(filename);

    if (file.is_open()) {
        for (const auto& row : data) {
            for (size_t i = 0; i < row.size(); ++i) {
                file << row[i];
                if (i != row.size() - 1) {
                    file << ",";
                }
            }
            file << "\n";
        }

        file.close();
        std::cout << "CSV file " << filename << " generated successfully." << std::endl;
    } else {
        std::cerr << "Error: Unable to open file " << filename << " for writing." << std::endl;
    }
}

int main() {
    // 生成的 CSV 数据
    std::vector<std::vector<std::string>> data = {
        {"Name", "Age", "City"},
        {"John", "30", "New York"},
        {"Alice", "25", "San Francisco"},
        {"Bob", "35", "Seattle"}
    };

    // 生成 CSV 文件
    generateCSV("output.csv", data);

    return 0;
}
```

## 1.25. 问: C++ 解析pcap文件中的 udp 报文

需要安装 libpcap 库, 需要 开源库 [nlohmann/json](https://github.com/nlohmann/json) 中的 json.hpp 文件

解析文件 [`yyy.pcap`](uploads/9871b49db738ca21c023535ca5c1303a/yyy.pcap) 中的 udp 报文, 并将解析结果写入 `output.json` 文件中

```c++
#include <iostream>
#include <fstream>
#include <pcap.h>
#include "nlohmann/json.hpp"
#include <netinet/ip.h>
#include <net/ethernet.h>
#include <netinet/udp.h>
#include <sys/socket.h>
#include <netinet/in.h>

std::vector<nlohmann::json> json_vec;

void packet_handler(u_char* user, const struct pcap_pkthdr* pkthdr, const u_char* packet)
{
    // 解析以太网帧头部
    struct ether_header* eth = (struct ether_header*)packet;
    /// 解析 tcp/udp 头部
    struct ip* ip = (struct ip*)(packet + sizeof(struct ether_header));

    // Create a JSON object
    nlohmann::json json_obj;
    json_obj["source_ip"] = inet_ntoa(ip->ip_src);
    json_obj["destination_ip"] = inet_ntoa(ip->ip_dst);
    /// json_obj["protocol"] = (int)ip->ip_p;
    json_obj["version"] = (int)ip->ip_v;
    json_obj["header_length"] = (int)ip->ip_hl;
    json_obj["ttl"] = (int)ip->ip_ttl;
    json_obj["total_length"] = ntohs(ip->ip_len);
    json_obj["checksum"] = ntohs(ip->ip_sum);
    json_obj["identification"] = ntohs(ip->ip_id);
    json_obj["fragment_offset"] = ntohs(ip->ip_off);
    json_obj["type_of_service"] = ntohs(ip->ip_tos);
    json_obj["flags"] = ntohs(ip->ip_off);

    if (ip->ip_p == IPPROTO_TCP)
    {
        json_obj["protocol"] = "TCP";
    }
    else if (ip->ip_p == IPPROTO_UDP)
    {
        json_obj["protocol"] = "UDP";

        struct udphdr* udp = (struct udphdr*)(packet + sizeof(struct ether_header) + sizeof(struct ip));
        nlohmann::json udp_obj;
        udp_obj["source_port"] = ntohs(udp->uh_sport);
        udp_obj["destination_port"] = ntohs(udp->uh_dport);
        udp_obj["length"] = ntohs(udp->uh_ulen);
        udp_obj["checksum"] = ntohs(udp->uh_sum);
        std::string data;
        for (int i = 0; i < ntohs(udp->uh_ulen) - sizeof(struct udphdr); ++i)
        {
            data += (char)packet[i + sizeof(struct ether_header) + sizeof(struct ip) + sizeof(struct udphdr)];
        }
        udp_obj["data"] = data;
        json_obj["udp"] = udp_obj;
    }
    else
    {
        json_obj["protocol"] = (int)ip->ip_p;
    }

    json_vec.push_back(json_obj);
}

int main()
{
    char errbuf[PCAP_ERRBUF_SIZE];
    pcap_t* pcap_handle;

    // 打开离线 pcap 文件
    pcap_handle = pcap_open_offline("yyy.pcap", errbuf);
    if (pcap_handle == NULL)
    {
        std::cerr << "Error opening pcap file: " << errbuf << std::endl;
        return 1;
    }

    // 循环读取数据包
    if (pcap_loop(pcap_handle, 0, packet_handler, NULL) < 0)
    {
        std::cerr << "Error reading packets: " << pcap_geterr(pcap_handle) << std::endl;
        return 1;
    }

    // 关闭 pcap 文件
    pcap_close(pcap_handle);

    // Write the JSON object to a file
    std::ofstream output_file("output.json");
    nlohmann::json json_array(json_vec);
    output_file <<  json_array.dump(4);
    output_file.close();

    return 0;
}
```

## 1.26. 问: google 自定义不搜索特定网站

1. 设置 -》搜索引擎-》管理搜索引擎，在默认搜索引擎那里找到你要修改的搜索引擎，鼠标左键单击三下它的查询网址，右键复制；
2. 对复制的文本，增加不想要搜索的网站, `+-site:blog.csdn.net -site:baike.baidu.com+`, 添加如下位置
```c++
{google:baseURL}search?q=%s+-site:blog.csdn.net -site:baike.baidu.com+&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchFieldtrialParameter}{google:iOSSearchLanguage}{google:prefetchSource}{google:searchClient}{google:sourceId}{google:contextualSearchVersion}ie={inputEncoding}
```
3. 新增其他所有引擎，贴上刚刚增加过滤网站的字符串后，设置该搜索引擎为默认搜索引擎，即可。

## 1.27. 问: google 搜索技巧

1. 指定在某个网站中搜索

```c++
/// 在 github.com 网站中搜索 json parser
json parser site:github.com
```

2. 指定不搜索某网站内容

```c++
/// 搜索ethheader 结构体头文件, 过滤掉 csdn.net 网站内容
ethheader 结构体头文件 -site:csdn.net
```

3. 搜索指定文件类型

```c++
CppCoreGuidelines filetype:pdf
```

4. 完全匹配文本

```c++
/// 搜索整体字符串
“boost c++”
```

5. 过滤关键字

```c++
/// 搜索云服务的内容，并过滤带有 advertising 的结果
云服务 -advertising
```

6. 逻辑与、或：AND、OR

```c++
手机 OR 相机 电脑 OR 鼠标 OR 键盘
它等同于 (手机 OR 相机) (电脑 OR 鼠标 OR 键盘)
```

7. 通配符：?和*

?: 代表一个字符
*: 代表一串字符串

```c++
/// 搜索中国什么银行
中国*银行
```

8. 为搜索添加时间区间

```c++
/// 搜索2020年之前的内容
BEFORE:2020
/// 搜索2020年之后的内容
AFTER:2020
/// 搜索时间区间内的内容
2020..2021
```

## 1.28. 问: 如何使用 gperftools 查看函数调用火焰图

1. 安装软件

```c++
apt-get install google-perftools libgoogle-perftools-dev graphviz
```

2. 创建文件 test.cc

```c++
#include <iostream>
#include <gperftools/profiler.h>
#include <regex>

int main()
{
    auto make_cpu_profiler = [](const string &filename)
    {
        ProfilerStart(filename.c_str());
        ProfilerRegisterThread();
        return std::shared_ptr<void>(nullptr, [](void *) { ProfilerStop(); });
    };

    auto cp = make_cpu_profiler("case1.perf");  // 启动性能分析
    auto str = "neir:automata"s;

    for (int i = 0; i < 1000; i++)
    {                                                // 循环一千次
        auto reg = make_regex(R"(^(\w+)\:(\w+)$)");  // 正则表达式对象
        auto what = make_match();

        assert(regex_match(str, what, reg));  // 正则匹配
    }
```

3. 编译并运行

```sh
g+++ -std=c++20 -lprofiler test.cc -o a.out
```

4. 查看结果

```sh
pprof --text ./a.out case1.perf > case1.txt
或
pprof --svg ./a.out case1.perf > case1.svg
或
pprof --collapsed ./a.out case1.perf > case1.cbt
flamegraph.pl case1.cbt > flame.svg
flamegraph.pl --invert --color aqua case1.cbt > icicle.svg
```

* 注: 如果找不到 `pprof`, 可以拉取这个库进行使用， `git clone git@github.com:gperftools/gperftools.git`

* 注: 如果找不到 `flamegraph.pl`， 可以拉取这个库进行使用 `git clone git@github.com:brendangregg/FlameGraph.git`

## 1.29. 问: perf 基本用法

1. 查看 pid 为 1234 的进程的 cpu 使用情况

```sh
perf top -K -p 1234
```

## 1.30. 问: 如何创建本地ssh-key

1. 打开终端（或命令提示符，取决于你使用的操作系统）。

2. 输入以下命令来生成 SSH key。在命令中，你需要提供你的电子邮件地址，这将作为密钥的标签。

   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

   `-t rsa` 指定要使用 RSA 算法，`-b 4096` 指定密钥的位数（4096 位是一个常用的安全选择），`-C` 用于添加注释，一般填写你的电子邮件地址。

3. 系统将提示你选择密钥文件的存储位置和文件名。如果你不输入任何内容，系统将默认在用户主目录下的 `.ssh` 文件夹中创建 `id_rsa` 和 `id_rsa.pub` 文件。你也可以为密钥文件指定自定义的文件名和路径。

4. 然后，系统将询问你是否要设置密码来保护私钥。这是一个可选的步骤，添加密码会增加安全性，但你需要在每次使用私钥时输入密码。如果你想要额外的安全性，请输入密码，否则你可以留空直接按回车。

5. 在执行上述步骤后，你的 SSH key 就已经生成了。公钥（`id_rsa.pub` 文件）是你要在 GitHub 或其他 Git 托管服务上添加的部分。

   你可以使用以下命令来查看生成的 SSH key：

   ```bash
   cat ~/.ssh/id_rsa.pub
   ```

   或者，如果你使用的是 Windows 平台：

   ```bash
   type %userprofile%\.ssh\id_rsa.pub
   ```

6. 复制公钥（以 `ssh-rsa` 开头的一长串字符），然后将其添加到你的 GitHub 账户或其他 Git 托管服务的 SSH key 设置中。

## 1.31. 问:Openwrt配置vlan的方法

一、主机的内部的网络拓扑图

![设备网络架构](uploads/5507d8f0ae525172a984c01b86f91948/1698302551718.png)  

请按照实际的网络拓扑架构完成port与物理接口的对应关系，可以使用命令`swconfig dev switch0 show`展示在switch0下的端口状态，此时插拔网线即可知晓物理网口与哪个port对应。
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/54112f9f-f2d2-4441-949f-0fb3db3228e7)  

在我的设备中前面板的网口对应的物理网卡都是eth1,port1对应网口标签LAND，port2对应LAN1，prot3对应LAN2，port4对应LAN3。

使用下述方法配置时请对应好需要配置的端口和vlan。WEB页面中也可以通过插拔网线确认对应网口

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/38145f7a-f834-43a7-988c-d5e07c40da68)  


二、WEB网页配置过程

1、配置vlan
- 导航栏选择网络配置-交换机
- 点击添加按钮，添加vlan
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/ffeefd40-12ec-428d-a8b1-01e6b0403e90)  

- 新的vlan中CPU要设置为`关联`,其余端口根据需要将对应端口划分成不同vlan。因为默认所有端口都在vlan1中，划分时先将vlan1中相应端口关闭。端口的下拉选择框解释：`不关联`是Access模式，`关联`是Trunk模式,`关闭`是不使用该端口。
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/e2f6c699-861e-4165-94e3-42f47f56952d)  

上图中vlan1为默认vlan，端口1和端口2的效果和未修改之前一样，外接设备可以ping通br-lan上的地址，br-lan桥接了eth0和eth1.1（vlan1）。

vlan2绑定的是端口3，vlan3绑定的是端口4

2、配置IP
- 导航栏选择网络配置-接口，添加新接口

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/f2192a54-f37e-4d80-a162-e641735310eb)  

- 输入接口名称，选择下方对应需求的vlan接口，点击提交

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/1267d32c-e7f9-4207-b0dc-0d285707806b)  

- 提交后，页面就可以进行IP配置了。配置好的IP在后台通过ifconfig查看时，eth1.1对应vlan1,eth1.2对应vlan2,eth1.3对应vlan3。

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/80f18068-d051-4986-a64e-b6522a56d70d)   

3、修改br-lan的桥接模式
- 进入主机web界面
- 导航栏选择网络配置-接口，选择LAN口，点击修改

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/0fb01542-fb2b-47e1-8fb6-7ffd22d5cc94)  


- 进入后选择物理设置，接口勾选eth0和eth1.1(eth1.1对应的是vlan1的接口，我们设备前面板上的网口默认都是划分在vlan1中)

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/9ccd8df8-a644-443a-8119-ad7722c670b2)  


- 点击保存&应用


三、通过修改network配置文件，划分vlan
1、进入network配置文件
```
vi /etc/config/network
```
2、修改br-lan桥接的网络，从原来的桥接eth0和eth1改成桥接eth0和eth1.1。

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/5b147311-451d-4a13-a3e2-ee6886713089)  


```
config interface 'lan'
        option type 'bridge'
        option _orig_ifname 'eth1'
        option _orig_bridge 'true'
        option proto 'static'
        option netmask '255.255.255.0'
        option gateway '192.0.1.25'
        option ipaddr '192.0.1.27'
        option ifname 'eth0 eth1.1'
```
3、vlan1中包含所有端口，将需要重新划分vlan的端口删除，然后添加新的vlan,添加vlan对应虚拟网卡的IP地址。
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/f420b79e-57b4-4137-8ff3-f95b9b3c62ee)  

```
config switch_vlan
        option device 'eth1'
        option vlan '1'
        option vid '1'
        option ports '0 2 1'

config switch_vlan
        option device 'eth1'
        option vlan '2'
        option vid '2'
        option ports '0t 3'

config interface 'test'
        option proto 'static'
        option netmask '255.255.255.0'
        option ipaddr '192.168.101.144'
        option ifname 'eth1.3'

config switch_vlan
        option device 'eth1'
        option vlan '3'
        option vid '3'
        option ports '0t 4'
```
4、重启网络服务
```
/etc/init.d/network restart
```

## 1.32. 问: 如何使用 clang-format 不格式化某些文件

1. 单个文件

```c++
// clang-format off

不需要格式化的代码

// clang-format on
```

2. 文件夹下的文件

在该文件夹下创建 `.clang-format` 文件, 该文件写入如下语句

```c++
DisableFormat: true
```

## 1.33. 问: 如何计算某个文件夹下，代码文件的注释占所有行数的比例

```sh
cloc --by-percent c --quiet ./ds/thirdparty
```

## 1.34. 问: 如何计算某个文件夹下，代码文件的空行、注释和代码行数

```sh
cloc ./ds/thirdparty
```

## 1.35. 问: 如何查找某个文件夹下所有文件的行数

```sh
find ./ds/thirdparty -type f -name "*" -print0 | xargs -0 wc -l
```

## 1.36. 问: cmake 脚本中如何让一个变量表示某文件夹下所有源文件

本 `CMakeLists.txt` 同级目录的子目录 `common` 下所有源文件赋值给变量 COMMON_FILE

```c++
aux_source_directory(${CMAKE_CURRENT_LIST_DIR}/common COMMON_FILE)
```

## 1.37. 问:如何在centos上配置telnet服务
centos7下配置使用telnet登录系统

在CentOS7中，默认情况下，telnet是被禁用的，因为它不是安全的协议。但是，如果您仍然想使用telnet，可以按照以下步骤进行配置：

1、安装telnet客户端和服务器：

```
sudo yum install xinetd telnet telnet-server
```

离线安装：
请先离线下载好`telnet-server-0.17-65.el7_8.x86_64.rpm`、`telnet-0.17-65.el7_8.x86_64.rpm`、`xinetd-2.3.15-14.el7.x86_64.rpm`  
然后使用rpm命令手动安装
```
rpm -ivh telnet-server-0.17-65.el7_8.x86_64.rpm
rpm -ivh telnet-0.17-65.el7_8.x86_64.rpm
rpm -ivh xinetd-2.3.15-14.el7.x86_64.rpm
```

2、启动telnet服务，并将其设置为开机启动：

```
sudo systemctl start telnet.socket
sudo systemctl enable telnet.socket
```

3、配置防火墙以允许telnet连接：

```
sudo firewall-cmd --add-service=telnet --permanent
sudo firewall-cmd --reload
```

4、创建一个新的用户并设置密码：

```
sudo adduser username
sudo passwd username
```

5、用新用户登录到系统：

```
telnet localhost
```

6、输入新用户的用户名和密码进行登录。

注意：虽然这个方法可以让您使用telnet登录系统，但它不是安全的协议，建议使用更安全的SSH协议来进行系统登录。

7、root用户直接登录

默认情况下，系统是不允许root用户telnet远程登录的。如果要使用root用户直接登录，需设置如下内容。或者可以添加一个可以登录的用户，登录并su到root用户（建议采用此方法，保证系统安全）。此步骤可跳过！

允许root用户通过telnet登陆：
编辑/etc/pam.d/login，注释掉下面这行

```
vi /etc/pam.d/login
#把auth的限制去掉
#auth [user_unknown=ignore success=ok ignore=ignore default=bad] pam_securetty.so
```

开启root用户远程登陆。此步骤可跳过!

```
vi /etc/pam.d/remote
#auth required pam_securetty.so
```

* 重启telnet和xinetd服务 【telnet服务依赖于xinetd服务】

```
systemctl restart telnet.socket
systemctl restart xinetd
```

* 将 23端口（系统默认23为telnet端口）添加到防火墙允许的端口的列表中。

```
firewall-cmd --zone=public --add-port=23/tcp --permanent
```

8、卸载telnet

执行 rpm -qa telnet*查看是否已经安装过了。

```
rpm -qa telent*
```

使用：yum remove telnet-*   全部卸载掉

```
yum remove telnet-*
```


## 1.38. 问:如何在centos上配置ntp服务器
Centos7 配置NTP服务器

在 CentOS 7 或 RHEL 7 系统上，您可以使用 `yum` 命令来安装 `ntpd`（NTP服务器）。下面是如何安装 `ntpd` 的步骤：

1. 打开终端或 SSH 到您的服务器。

2. 使用 `yum` 安装 `ntpd` 服务：

   ```bash
   sudo yum install ntp
   ```

3. 安装过程中，您可能需要确认是否要继续，输入 `y` 并按 Enter 键。

4. 离线安装，从网络上获取RPM包：

   ```
   rpm -ivh ntp-4.2.6p5-29.el7.centos.2.x86_64.rpm
   rpm -ivh autogen-libopts-5.18-5.el7.x86_64.rpm
   rpm -ivh net-snmp-utils-5.7.2-49.el7_9.1.x86_64.rpm
   ```

5. 安装完成后，您可以启动 `ntpd` 服务并设置它在系统启动时自动启动：

   ```bash
   sudo systemctl start ntpd
   sudo systemctl enable ntpd
   ```

   这将启动 NTP 服务并配置它在系统重启后自动启动。

6. 您可以使用以下命令检查 `ntpd` 服务的状态，以确保它正在运行：

   ```bash
   sudo systemctl status ntpd
   ```

现在，`ntpd` 服务已成功安装并正在运行。您可以继续配置 `/etc/ntp.conf` 文件，以指定要同步的 NTP 服务器和其他参数，以满足您的需求。

在 CentOS 7 中，`ntp.conf` 文件用于配置 NTP 服务器和客户端的设置。该文件提供了有关如何同步外部时钟源和如何向内部设备提供 NTP 同步的配置选项。下面是 `ntp.conf` 文件的详细说明：
1. 配置服务器选项：

   - `server`：使用 `server` 关键字指定外部 NTP 服务器，以从这些服务器同步时间。例如：

     ```
     server 0.centos.pool.ntp.org iburst
     server 1.centos.pool.ntp.org iburst
     ```

     在这个示例中，NTP 服务器将同步到 `centos.pool.ntp.org` 服务器池中的服务器。

   - `iburst`：`iburst` 选项表示快速同步，通常添加在服务器配置后面，以加速同步。

2. 允许其他客户端同步：

   - `restrict`：`restrict` 配置允许或限制 NTP 客户端访问您的 NTP 服务器。默认情况下，`restrict` 允许本地子网的客户端访问。您可以添加或修改 `restrict` 条目以满足您的需求。

     例如，以下配置将允许本地子网中的客户端同步并阻止其他客户端的修改和 TRAP 操作：

     ```
     restrict 192.168.1.0 mask 255.255.255.0 nomodify notrap
     ```

3. 提供 NTP 同步给内部设备：

   - NTP 服务器的配置允许内部设备向该服务器请求时间同步。在内部设备上，您需要配置它们以将 NTP 服务器设置为您的 CentOS 7 服务器的 IP 地址。这样，内部设备将与您的服务器同步时间。

   - 您可以通过将 NTP 服务器的 IP 地址配置为内部设备的 NTP 服务器来实现。通常，内部设备将在其操作系统或设备设置中提供 NTP 服务器的配置选项。

总的来说，`ntp.conf` 文件用于配置 NTP 服务器和客户端的行为。您可以添加外部 NTP 服务器来同步您的服务器的时间，然后允许本地子网的客户端同步。内部设备需要配置为使用您的 CentOS 7 服务器的 IP 地址作为其 NTP 服务器，以实现时间同步。这将确保所有内部设备具有准确的时间。

要配置 NTP 服务器以不限制连接的客户端，您可以简单地在 `ntp.conf` 文件中删除或注释掉任何 `restrict` 行。默认情况下，`ntp.conf` 中的 `restrict` 行允许本地子网的客户端访问，因此如果您删除或注释掉这些行，NTP 服务器将不再限制连接的客户端。

以下是如何配置不限制连接的客户端的示例：

1. 打开 `/etc/ntp.conf` 文件以编辑它：

   ```bash
   sudo nano /etc/ntp.conf
   ```

2. 寻找 `restrict` 行，并删除或注释掉它们。默认情况下，`restrict` 行可能如下所示：

   ```plaintext
   restrict 127.0.0.1
   restrict ::1
   ```

   注释掉或删除这些行，使文件看起来像这样：

   ```plaintext
   #restrict 127.0.0.1
   #restrict ::1
   ```

3. 保存并关闭文件。

4. 重新启动 NTP 服务以使更改生效：

   ```bash
   sudo systemctl restart ntpd
   ```

现在，您的 NTP 服务器将不再限制连接的客户端，并允许来自任何来源的 NTP 请求。这适用于在一个受信任网络内部运行 NTP 服务器，不需要严格的访问控制。但请注意，如果您的 NTP 服务器可公开访问，那么强烈建议配置适当的安全性以防止滥用。

## 1.39. 问: 如何在 CMake 脚本中初始化 git 子模块

在 `CMakeLists.txt` 中 `project(xxx)` 语句之后输入如下指令，在执行 cmake .. 时自动初始化 git 子模块(对应子模块的文件夹需要不存在)

```sh

execute_process(
  COMMAND git submodule update --init --recursive
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  RESULT_VARIABLE GIT_SUBMOD_RESULT)
if(NOT GIT_SUBMOD_RESULT EQUAL "0")
  message(
    FATAL_ERROR
      "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules"
  )
endif()
```

## 1.40. 问: 如何初始化一个包含 `.gitmodules` 文件的仓库

```git
git submodule update --init
```

## 1.41. 问: MySQL 如何使用分页查询

[MySQL分页查询及其优化](https://www.w3cschool.cn/mysql/mysql-xilz2oy6.html)

[MySQL分页查询优化](http://uusama.com/458.html)

## 1.42. 问: 如何在 `gitlab` 库中创建并使用 `issue` 模板

1. 在 gitlab 库中 master 分支下，根目录创建文件夹 `.gitlab/issue_templates`
2. 并在该文件夹下创建对应名称的 `.md` 文件
3. 上传 `.md` 文件，即可在新建 `issue` 时，点击 `Choose a template` 使用其模版


## 1.43. 问: 如何使用文件编号查询某文件夹下的文件名称

```c++
#include <iostream>
#include <vector>
#include <regex>
#include <string>
#include <filesystem>

std::vector<std::string> get_directory_files(const std::string& path, const std::regex& reg, bool is_recursive)
{
    auto p = std::filesystem::path(path);
    if (!std::filesystem::exists(p))
    {
        return {};
    }

    std::vector<std::string> vec;
    auto f = [&](const auto& dir_entry)
    {
        auto fp = dir_entry.path();
        /// 过滤文件夹
        if (!std::filesystem::is_directory(std::filesystem::status(fp)))
        {
            auto file_name = fp.filename().string();
            /// 正则匹配
            if (std::regex_match(file_name, reg))
            {
                vec.push_back(fp.string());
            }
        }
    };

    if (is_recursive)
    {
        /// 递归查找
        std::ranges::for_each(std::filesystem::recursive_directory_iterator{p}, f);
    }
    else
    {
        /// 非递归查找
        std::ranges::for_each(std::filesystem::directory_iterator{p}, f);
    }

    std::ranges::sort(vec);
    return vec;
}

int main()
{
    auto c4 =
        get_directory_files("/Users/lijiancong/Workspace/gitlab/sz13_sil2/doc/工作区/", std::regex("(GBCOM.*)"), true);

    for (auto& i : c4)
    {
        auto pos = i.find_last_of("/");
        i = i.substr(pos + 1);
        std::cout << i << std::endl;
    }

    std::string str;
    while (getline(std::cin, str))
    {
        str = "GBCOM-SIL2-0" + str;

        auto it = std::find_if(c4.begin(), c4.end(), [&](const auto& file_name) { return file_name.find(str) == 0; });

        if (it == c4.end())
        {
            std::cout << "未找到" << std::endl;
        }
        else
        {
            std::cout << "文件: " << *it << std::endl;
            auto pos = it->find_last_of("V");
            std::cout << "版本号: " << it->substr(pos, 4) << std::endl;
        }
        std::cout << std::endl;
    }

    return 0;
}
```


## 1.44. 问: 设备软件安装目录规范

    设备软件安装目录规范如下（现场安装目录按本文修改）：

    1、二开软件（DIS、MRS、OMC）安装根目录：

    Linux缺省安装在 /home/gbcom

    windows 缺省安装在d:/gbcom目录 （windows安装后手工设置系统环境变量GBCOM_HOME)

   linux服务器的启动脚本统一采用： start_gbcom.sh 脚本位于根目录下，内容如下：

```c++
    #!/bin/bash
    shell_dir=$(dirname "$0")
    export GBCOM_HOME=$shell_dir
    cd $GBCOM_HOME
    $GBCOM_HOME/procmon &
```

    该脚本在/etc/rc.local中被调用，调用方法如下：

    source /home/gbcom/start_gbcom.sh

   注意必须要用source调用该脚本，保证GBCOM_HOME环境变量生效

   2. dis、omc、mrs

    安装在根目录下一级目录中，目录名分别为 dis、omc、mrs

   3. procmon

    安装在根目录下  （windows下为watcgDog服务）

   4. pcap

   安装在根目录下 （windows下为pcap服务）

   5. ds_chk

  安装在根目录下

   6. ftps

  安装在根目录下

   7. mysql

   根据系统安装的缺省目录，不指定

   8、ftp服务器

   安装在根目录的ftp目录下

   ftp的数据目录为ftp下的data目录，

   用户名：gbcom 密码 gbcom@123

   9. dc、omt、spt

   安装在根目录下一级目录中，目录名分别为 dc、omt、spt


## 1.45. 问: googletest 如何运行测试的子集

```text
./foo_test Has no flag, and thus runs all its tests.
./foo_test --gtest_filter=* Also runs everything, due to the single match-everything * value.
./foo_test --gtest_filter=FooTest.* Runs everything in test suite FooTest .
./foo_test --gtest_filter=*Null*:*Constructor* Runs any test whose full name contains either "Null" or "Constructor" .
./foo_test --gtest_filter=-*DeathTest.* Runs all non-death tests.
./foo_test --gtest_filter=FooTest.*-FooTest.Bar Runs everything in test suite FooTest except FooTest.Bar.
./foo_test --gtest_filter=FooTest.*:BarTest.*-FooTest.Bar:BarTest.Foo Runs everything in test suite FooTest except FooTest.Bar and everything in test suite BarTest except BarTest.Foo.
```

## 1.46. 问：Centos 使用 yum 后使用 cmake 出现 libstdc++.so 链接错误

```c++
rm -f /usr/lib64/libstdc++.so.6
ln -s /usr/local/lib64/libstdc++.so.6 /usr/lib64/libstdc++.so.6
```

## 1.47. 问：如何使用 coredump 进行调试，以主板中 sa 软件为例

1. sa 软件可以添加编译命令  `-g` 以添加调试信息

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/5e9a3414-13c3-44a1-94f3-063e9e32b321)


2. 使用临时命令 打开主机 `coredump` 生成

```sh
ulimit -c unlimited
```

通过命令 `ulimit -c ` 查看 coredump 大小不为0，确认 coredump 已经开启

3. 运行可执行程序，并触发崩溃，生成 coredump 文件

4. 查询找到 coredump 文件所在

```sh
cat /proc/sys/kernel/core_pattern
```
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/4c9f8122-78b6-4832-b082-a2843cf65c53)


5. 拷贝到可执行文件目录下

```sh
cp /tmp/coredump文件名 /sbin/
```

6. 使用 gdb 查看 coredump 文件

```sh
gdb sa coredumpxxx
```

sa: 可执行文件

coredumpxxx: coredump 文件名

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/882f0e8e-e11f-49df-8e9b-48059612d118)


## 1.48. 问：使用后 yum 命令后， libstdc++ 出现链接错误

```c++
rm -f /usr/lib64/libstdc++.so.6
ln -s /usr/local/lib64/libstdc++.so.6 /usr/lib64/libstdc++.so.6
```

## 1.49. 问：如何使用iperf3打流
[iperf3使用说明.docx](https://github.com/grow-man/MyLearningRecorder/files/13630745/iperf3.docx)


## 1.50. 问：如何从抓包文件中提取amr音频流并播放
[提取抓包文件中的amr音频流并播放.docx](https://github.com/grow-man/MyLearningRecorder/files/13631545/amr.docx)  

## 1.51. 问：如何查看文件的 md5 数值

windows

```c++
certutil -hashfile 文件 MD5
```

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/f9825e29-f76a-4665-894a-9533ae3f6c1f)  

linux：

```sh
md5sum 文件名
```
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/72f5a5dc-c19e-4f48-b57b-79348f771694)

## 1.52. 问：如何在抓包中导出 rtp 音频进行分析

[Wireshark导出rtp音频数据并使用Audacity分析](https://blog.csdn.net/gtychuashuiwang/article/details/128399570)

## 1.53. 问: 如何 git 如何拉取远程仓库的指定分支

```sh
git clone -b develop http://xxxxx
```

## 1.54. 问：windows 上 mysql5.7 如何允许远程访问？

[windows中mysql如何设置远程连接](https://blog.csdn.net/qq_43308242/article/details/104839328)

1. 使用命令 `mysql -uroot -p` 进入 mysql
2. 输入如下命令

```sh
use mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '你的密码' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

3. 关闭本机对 3306 端口的防火墙

## 1.55. 问： wireshark 抓包时出现提示 failed to set hardware filter to promiscuous mode: 连到系统上的设备没有发挥作用。 

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/a5db608a-b4b8-4aea-8d81-f0030c8146de)


可以通过关闭混杂模式进行抓包

点击 捕获 -> 选项，取消勾选混杂模式即可抓包

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/86a4f52a-4b01-4afa-b2e2-2100641743dc)  

## 1.56. 问：wireshark 中混杂模式指的是什么意思？

通过设置网卡为混杂模式就能捕获局域网内所有发包内容，包括非广播包和非发给自己主机的数据包。

不勾选此选项可以捕获，广播包和自己的包。


## 1.57. 问: `error while loading shared libraries` 加载动态库失败如何解决？

动态库缓存问题： Linux 使用动态链接库缓存来提高性能。如果你在程序运行前更新了动态库文件，可能需要刷新动态库缓存。

解决方法：
1. 把相应的动态库文件放入到`/usr/lib`目录下。
2. 刷新动态库缓存 `sudo ldconfig`
注：上述操作只需执行一次，重启后仍生效。

## 1.58. 问： `FAQ` 是什么？

FAQ 是 Frequently Asked Questions（常见问题）的缩写。它是指经常被人们提出的一些问题和对应的解答，通常用于帮助用户解决常见问题或提供相关信息。

## 1.59. 问： `Q&A` 是什么?

`Question and Answer`（问题与回答） 的缩写

## 1.60. 问： [Centos7 如何源码编译 git](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%AE%89%E8%A3%85-Git)

1. 首先安装 gcc 和 g++

```sh
yum install -y gcc gcc-c++
```

2. 安装依赖

```c++
yum install -y dh-autoreconf curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X
```

3. 下载源码并安装

```sh
curl -O https://github.com/git/git/archive/refs/tags/v2.42.0.tar.gz
tar -xzvf git-2.42.0.tar.gz
cd git-2.42.0
make configure
./configure
make all doc info -j12
yum remove git  ///< 删除老版本 git
sudo make install
sudo make install install-doc install-html install-info
```

## 1.61. 问： Centos定位查找文件命令

1. 本文件夹下查找文集

```sh
find -name filename
```

2. 全部查找

```sh
find / -name filename
```

3. 使用正则表达式，查找 .cs 后缀的文件

```sh
find / -name "*.cs"
```

## 1.62. 问： `Centos7` 如何源码编译 gcc/g++

1. 安装编译工具 gcc g++

```sh
yum install -y gcc gcc-c++
```

2. 安装编译依赖的 32位库

```sh
yum install glibc-devel.i686
```

3. 下载源码，以 `GCC13.2` 举例

```sh
curl -O http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-13.2.0/gcc-13.2.0.tar.gz
tar -xzvf gcc-13.2.0.tar.gz
cd gcc-13.2.0
```

4. 下载依赖，配置编译选项

```sh
./contrib/download_prerequisites ///< 下载依赖
./configure --enable-languages=c,c++ --enable-multilib ///< 配置编译 32位 和 64位
```

5. 编译并安装

```sh
sudo make -j12 ///< 编译

yum remove gcc gcc-c++ ///< 删除yum安装的gcc

sudo make install ///< 安装

gcc -v ///< 查看版本
g++ -v ///< 查看版本
```

6. 创建 `main.cpp` 并编译测试是否安装成功

## 1.63. 问： `Centos7` 如何关闭防火墙

1. 查看防火墙状态

```sh
systemctl status firewalld
```

2. 关闭防火墙

```sh
systemctl stop firewalld
```

3. 停止防火墙自启动

```sh
systemctl disable firewalld
```

## 1.64. 问: `Centos7` 设置笔记本合盖不休眠

```sh
vim /etc/systemd/logind.conf
```

配置文件中找到我们要修改的配置项：

```sh
HandlePowerKey 按下电源键后的行为，默认power off
HandleSleepKey 按下挂起键后的行为，默认suspend
HandleHibernateKey 按下休眠键后的行为，默认hibernate
HandleLidSwitch 合上笔记本盖后的行为，默认suspend
```

选项：

```sh
ignore 忽略，跳过
power off 关机
reboot 重启
halt 挂起
lock 仅锁屏，计算机继续工作。
```

重启服务生效

```sh
systemctl restart systemd-logind
```

## 1.65. 问: `Centos7` 如何在命令行链接 `wifi`

1. 第一步，安装包

```sh
yum install NetworkManager*
```

2. 设置NetworkManager自动启动

```sh
chkconfig NetworkManager on
```

3. 开启WiFi

```sh
nmcli r wifi on
```

4. 扫描可用wifi

```sh
nmcli dev wifi
```

5. 用4查询到的`wifi` `SSID`连接 `wifi`

```sh
nmcli --ask dev wifi connect SSID
```

更换命令中的SSID为复制的WiFi的名字

加上--ask后会让你添加wifi密码，如果有密码的话

or

```sh
nmctl dev wifi con "wifi名" password "密码" name "别名"
```

6. 如果wifi没有连接上

```sh
nmcli con up wifi连接名（刚才nmtui创建的连接）
```

7. 添加成功后查看已创建的wifi连接（别名）

```sh
nmcli conn
```

8. 关闭开机启动以太网

```sh
cd /etc/sysconfig/network-scripts
vi ifcfg-enp4s0f2   //有线网卡配置文件
# 设置
ONBOOT=no
```

## 1.66. 问：调度台现场问题排查取证的方法

1.  记录问题产生时间，拍摄记录问题，描述问题现象

2.  取日志，路径为dc.exe所在目录下log文件夹下dc.log

3.  复现时抓包，调度台打开wireshark工具，对网卡开启抓包；

    调度台服务器使用tcpdump –i 网卡-vvv –s 0 –w 问题产生时间.pcap

## 1.67. 问：windows/linux如何添加静态路由

答：

1.  windows: 右击左下角windows图标，点击windows
    powershell(管理员)，在窗口输入下面命令

2.  route -p（永久保存） add 172.16.1.0（目标地址） mask 255.255.255.0
    192.168.101.1（网关地址/下一跳地址，通过该地址出去访问目标地址）

3.  linux:使用CRT进入服务器，命令行输入下面命令

4.  route add -net 172.16.1.0 （目标地址）netmask 255.255.255.0 gw
    192.168.101.1（网关地址/下一跳地址，通过该地址出去访问目标地址）

5.  CentOS7永久静态路由需要写到 /etc/sysconfig/network-scripts/route-网卡名
    文件中，故在/etc/sysconfig/network-scripts/下，新建文件名为route-网卡名的文件，（查询网卡名ifconfig）下面命令：

    vim /etc/sysconfig/network-scripts/route-网卡名

    100.0.0.0/24 via 192.168.10.20 dev 网卡名

## 1.68. 问：windows/linux查询端口状态

答：

1.  windows：netstat -ano \#查看所有端口

    netstat -ano \| findstr 端口 \#查看指定端口

2.  linux：netstat -anp \#查看所有端口

    netstat -anp \| grep 端口 \#查看指定端口


## 1.69. 问：检测网络是否可达的方法

1.  telnet连接

2.  抓包

3.  Ping

## 1.70. 问：Linux服务器登录方法

1.  首先电脑IP地址要和服务器IP地址可以正常通信

2.  CRT连接，CRT中输入服务器IP选择ssh连接进入

3.  直接电脑cmd窗口，使用ssh IP地址，连接进入

## 1.71. 问：Linux主机登录方法

1.  首先电脑IP地址要和主机IP地址可以正常通信

2.  CRT连接，CRT中输入主机IP选择telnet连接进入

3.  直接电脑cmd窗口，使用telnet IP地址，连接进入


## 1.72. 问: `DELL`服务器`iDRAC`远程控制设置

[DELL服务器iDRAC远程控制设置](https://www.cnblogs.com/panjianhui/p/12626185.html)


## 1.73. 问: 如何生成 GitLab 的 `Private Token`

在 GitLab 上生成 Private Token 遵循以下步骤：

1. **登录到 GitLab 帐户：** 首先，登录到你的 GitLab 帐户。

2. **导航到设置：** 在页面右上角，你会看到一个下拉菜单，选择 "Settings"。

3. **选择 Access Tokens：** 在左侧导航栏中，选择 "Access Tokens"。

4. **生成新 Token：** 在 "Create a personal access token" 部分，填写必要的信息，比如名称、到期日期等。

5. **选择权限：** 选择此访问令牌的权限。通常，你需要选择 `api`，以便访问 GitLab API。

6. **生成 Token：** 点击 "Create personal access token"。

7. **复制 Token：** 一旦 Token 生成，复制它并保存在安全的地方。**这是你唯一的机会复制它，因为它不会再次显示。**


## 1.74. 问: 如何改变 `Centos7` 的主机名称

```sh
hostnamectl set-hostname host_name
```

## 1.75. 问: CentoS7以上使用fdisk对4T磁盘进行分区, 对home进行扩容

[Centos7对home扩容.docx](https://github.com/grow-man/MyLearningRecorder/files/13631641/Centos7.home.docx)  


## 1.76. 问: EN50128 中 D.52 提到的结构化方法

* SSADM (Structured Systems Analysis and Design Method)
* LBMS (Life Cycle Business Method Specification)
* MASCOT (Modular Approach to Software Construction, Operation and Test)
* JSD (Jackson Structured Design)
* Yourdon
* SOM (Software through Object-oriented Methodology)
* SDL (Specification and Description Language)


## 1.77. 问: ssh 如何免密登录

以 Centos7 为例， 把自己电脑的 id_rsa.pub 中的内容，追加到需要免密登录服务器的 ~/.ssh/authorized_keys 中，再次 ssh 登录即可

自己的 `id_rsa.pub` 文件通常是在命令行中使用 `ssh-keygen` 命令后生成于 `C:\Users\yourname\.ssh\` 文件夹下

[参考](https://blog.csdn.net/jeikerxiao/article/details/84105529)

## 1.78. 问: MySQL 如何避免长事务对业务的影响？

1. 首先，从应用开发端来看：

- 确认是否使用了 set autocommit=0。这个确认工作可以在测试环境中开展，把 MySQL 的 general_log 开起来，然后随便跑一个业务逻辑，通过 general_log 的日志来确认。一般框架如果会设置这个值，也就会提供参数来控制行为，你的目标就是把它改成 1。

- 确认是否有不必要的只读事务。有些框架会习惯不管什么语句先用 begin/commit 框起来。我见过有些是业务并没有这个需要，但是也把好几个 select 语句放到了事务中。这种只读事务可以去掉。

- 业务连接数据库的时候，根据业务本身的预估，通过 SET MAX_EXECUTION_TIME 命令，来控制每个语句执行的最长时间，避免单个语句意外执行太长时间。（为什么会意外？在后续的文章中会提到这类案例）

2. 其次，从数据库端来看：

- 监控 information_schema.Innodb_trx 表，设置长事务阈值，超过就报警 / 或者 kill；

- Percona 的 pt-kill 这个工具不错，推荐使用；

- 在业务功能测试阶段要求输出所有的 general_log，分析日志行为提前发现问题；

- 如果使用的是 MySQL 5.6 或者更新版本，把 innodb_undo_tablespaces 设置成 2（或更大的值）。如果真的出现大事务导致回滚段过大，这样设置后清理起来更方便。

## 1.79. 问: MySQL 使用长连接后有时因为返回的结果集过大，导致内存增长过快，如何解决?

1. 定期断开长连接。使用一段时间，或者程序里面判断执行过一个占用内存的大查询后，断开连接，之后要查询再重连。
2. 如果你用的是 MySQL 5.7 或更新版本，可以在每次执行一个比较大的操作后，通过执行 mysql_reset_connection 来重新初始化连接资源。这个过程不需要重连和重新做权限验证，但是会将连接恢复到刚刚创建完时的状态。

## 1.80. 问: 正则表达式, 如何匹配 xxx (ms)

```regex
\d{3}\s\(ms\)
```

## 1.81. 问: 正则表达式，如何选中不带有文本 172.2.200.66 的行

```sh
不选中换行符:
^(?!.*172\.2\.200\.66).*$
选中换行符:
^(?!.*172\.2\.200\.66).*\r?\n?
```

## 1.82. 问: wireshark 报文中 ICMP 报文出现 Destination unreachable (Port unreachable),为什么会出现这个错误

当一个主机试图连接到另一个主机上的一个不存在的端口时，就会出现“Destination unreachable (Port unreachable)”错误。这通常是由于以下原因之一导致的：

1. 目标主机上的应用程序没有在指定的端口上运行。例如，如果你尝试连接到一个没有运行Web服务器的主机的80端口，就会出现这个错误。

2. 目标主机上的防火墙或路由器阻止了连接。这可能是因为防火墙或路由器配置不正确，或者因为它们正在阻止未经授权的连接。

3. 目标主机不可达。这可能是因为目标主机已关闭、网络故障或其他原因导致的。

当Wireshark捕获到一个“Destination unreachable (Port unreachable)”错误时，它通常会包含ICMP报文。这个ICMP报文是目标主机发送回来的，告诉源主机连接失败的原因。在Wireshark中，你可以查看ICMP报文的详细信息，以确定连接失败的原因。

## 1.83. 问： 华为核心网服务安装要点

1. 用超级用户登录，
2. 软件不要安装在中文和有空格的目录
3. 给软件赋予超级用户权限
4. 关闭防火墙

## 1.84. 问: 如何转换 md 文件为 latex 文件

使用 pandoc.exe 以及 eisvogel latex 模板 生成

[pandoc 安装链接](https://pandoc.org/installing.html)

[eisvogel 安装链接](https://github.com/Wandmalfarbe/pandoc-latex-template)

```ps
pandoc skiplist.md -o example.pdf --from markdown --template eisvogel --listings --pdf-engine=xelatex -V CJKmainfont="Microsoft YaHei"
```

## 1.85. 问: g++ 编译选项 `-Wl,--no-as-needed` 是什么意思？

`-Wl,--no-as-needed`是一个编译选项，用于告诉链接器在链接时不要忽略未使用的库。

在Linux系统中，链接器默认会忽略未使用的库，这意味着如果您的程序没有使用库中的任何函数，那么该库将不会被链接到您的程序中。这种行为可以减少程序的大小和启动时间，但也可能导致一些问题，例如在使用`dlopen`动态加载库时，未使用的库可能会被错误地忽略。

使用`-Wl,--no-as-needed`选项可以禁用链接器的这种行为，确保所有库都被链接到程序中，无论是否使用了库中的函数。这可以解决一些链接问题，例如在使用`dlopen`动态加载库时，确保所有依赖库都被正确地加载。

需要注意的是，使用`-Wl,--no-as-needed`选项可能会增加程序的大小和启动时间，因为所有库都被链接到程序中，即使您的程序没有使用库中的任何函数。因此，只有在需要时才应该使用该选项。

## 1.86. 问: 出现编译警告 `warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking`

详细报错:

```shell
[build] ../../../lib/libgtest.a(gtest-all.cc.o): In function `testing::internal::StreamingListener::SocketWriter::MakeConnection()':
[build] /home/lijiancong/gitlab/wz2/ds/thirdparty/googletest/googletest/src/gtest.cc:4916: warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
```

这个警告是由于在静态链接时使用了`getaddrinfo`函数，而该函数需要在运行时使用与链接时使用的glibc版本相同的共享库。如果您不想看到这个警告，可以在编译时添加`-Wl,--no-as-needed`选项。

以下是在编译时添加`-Wl,--no-as-needed`选项的示例：

```
g++ -o myapp myapp.cpp -lgtest -Wl,--no-as-needed
```

请注意，这个警告并不会影响您的程序的运行，只是提醒您在使用`getaddrinfo`函数时需要注意。如果您的程序没有使用`getaddrinfo`函数，那么您可以忽略这个警告。

## 1.87. 问: 如何查看 centos7 通过 yum 安装了哪些软件

```shell
yum list installed
```

## 1.88. 问: 如何自动统计最近一次 git 提交中增加或删除的代码行数

输入:
```git
git diff --numstat HEAD~1 HEAD
```

输出格式:
```shell
<新增的行数>\t<删除的行数>\t<文件名>
```

## 1.89. 问: ubuntu 如何查看cpu温度

在Ubuntu上查看CPU温度，可以使用`lm-sensors`工具。请按照以下步骤操作：

1. 首先安装`lm-sensors`：

```
sudo apt update
sudo apt install lm-sensors
```

2. 运行`sensors-detect`命令，以检测您的系统上的传感器：

```
sudo sensors-detect
```

按照提示回答问题。大多数情况下，您可以直接按Enter键选择默认选项。完成后，它将生成一个配置文件。

3. 加载内核模块：

```
sudo service kmod start
```

4. 现在，您可以使用`sensors`命令查看CPU温度：

每两秒刷新一次 sensors 命令
```
watch -n 2 sensors
```

这将显示系统上所有传感器的输出，包括CPU温度。输出可能因硬件和传感器类型而异。

## 1.90. 问: 初次使用 git 需要进行的配置

```shell
git config --global user.name "你的名字"
git config --global user.email "你的邮箱"

ssh-keygen -t rsa -C 你的邮箱 // 一路回车设置ssh-key
```

## 1.91. 问: NAT 是啥

NAT（Network Address Translation）是一种网络地址转换技术，常用于将私有网络内的IP地址转换为公网IP地址。这种技术可以将多个设备共享一个公网IP地址，从而在一定程度上缓解IPv4地址不足的问题。

NAT通常被用于家庭或小型办公室网络，使得多个设备可以通过一个公网IP地址与互联网进行通信。在NAT网络中，私有网络中的每个设备都分配了一个私有IP地址，这些地址通常在本地网络中是唯一的，但在公网中不是唯一的。当这些设备需要访问互联网时，NAT将其私有IP地址转换为公网IP地址，从而实现与互联网通信。

此外，NAT还可以用于安全目的，例如将防火墙后面的所有设备都使用一个公网IP地址，从而减少入侵者的攻击面。

## 1.92. 问: IPSec 是啥

IPSec（Internet Protocol Security）是一种在Internet Protocol（IP）层上提供数据加密、数据完整性校验和身份验证的协议。它提供了一种安全的通信方式，用于保护在公共网络（如Internet）上传输的数据。IPSec是一个开放的标准，被广泛用于VPN（Virtual Private Network）和其他安全网络连接的实现中。

IPSec使用一系列加密算法、认证机制和密钥管理协议来确保数据的保密性、完整性和可靠性。它可以为网络连接提供端到端的安全性，从而使用户可以安全地远程访问私人网络资源，而不必担心敏感数据被攻击者截获和篡改。IPSec还可以用于保护VoIP（Voice over IP）和视频流等实时应用程序的数据传输，从而保证数据的实时性和安全性。

IPSec协议是一个复杂的协议，需要在网络设备上进行配置和管理。但是，现代的网络设备通常都支持IPSec协议，并提供了易于使用的管理界面，使得配置和管理变得更加容易。

## 1.93. 问: mysql 如何实现主主复制

MySQL 支持多种不同的复制方式，其中包括主从复制和主主复制。主从复制是最常见的复制方式，其中一个 MySQL 服务器作为主服务器，负责接收和处理写入操作，并将它们复制到一个或多个从服务器上。从服务器只能读取数据，不能写入数据。

相比之下，主主复制则允许多个 MySQL 服务器同时充当主服务器，每个主服务器都可以接收和处理写入操作，并将它们同步到其他主服务器上。这种复制方式可以提高系统的可用性和容错能力，因为即使一个主服务器出现故障，其他主服务器仍然可以继续提供服务。

要实现 MySQL 的主主复制，您需要执行以下步骤：

1. 在每个主服务器上创建一个 MySQL 实例，并分别配置它们的主服务器和从服务器信息。这些信息包括服务器 ID、日志文件名称和位置、以及要复制的数据库和表的列表等等。

2. 在每个主服务器上启用二进制日志记录（binary logging），以便记录所有写入操作，并将它们传播到其他主服务器和从服务器上。您可以使用 MySQL 的配置文件或命令行选项来启用二进制日志记录。

3. 在每个主服务器上配置复制过滤器（replication filters），以便过滤掉不需要复制的数据。例如，您可以选择只复制某些数据库或表，或者排除某些操作类型，如 DROP TABLE 或 DELETE。

4. 在每个主服务器上配置主主复制，并将其连接到其他主服务器上。您可以使用 MySQL 的 CHANGE MASTER TO 命令或配置文件来指定其他主服务器的连接信息。请注意，您需要为每个主服务器配置一个单独的复制连接。

5. 在每个主服务器上启动复制进程，并等待数据同步完成。如果一切正常，您应该能够在每个主服务器上看到同样的数据。

需要注意的是，MySQL 的主主复制需要进行一些额外的配置和维护工作，以确保数据的一致性和可靠性。例如，您需要定期检查和修复主键冲突、解决数据同步延迟和冲突、以及备份和恢复数据等等。因此，如果您不熟悉 MySQL 的复制和管理技术，建议先进行一些测试和实验，以确保您的系统能够正确地处理故障和异常情况。


## 1.94. 问：如何批量删除日志文件中的空行

1. 打开需要进行文本处理的文件。
2. 按 Ctrl + H 打开替换面板。
3. 在替换面板中，将搜索模式切换为正则表达式模式（点击面板右侧的 .* 图标即可切换）。
4. 在搜索框中输入正则表达式 ^\s*$\n?，表示搜索空行。其中，^ 表示行的开头，$ 表示行的结尾，\s 表示空白字符（包括空格、制表符等），* 表示匹配任意次数，\n 表示匹配行尾换行符。
5. 在替换框中不输入任何内容，表示将所有搜索到的空行替换为空。
6. 点击 Replace All 按钮即可删除所有空行。

## 1.95. 问: 如何把日志中大量重复日志删除

VSCode 中

1. 打开需要进行文本处理的文件。
2. 按 Ctrl + H 打开替换面板。
3. 在替换面板中，将搜索模式切换为正则表达式模式（点击面板右侧的 .* 图标即可切换）。
4. 在搜索框中输入正则表达式
```text
^.*你想要匹配的字符串.*\r?\n?

例:
^.*retry send app msg failed.*\r?\n?
^.*Find no position.*\r?\n?
^.*SetRegisterStatus: strLongNum.*\r?\n?
```
表示搜索包含特定字符串的整行，同时匹配 Windows 和 Unix 的换行符。其中，^ 表示行的开头，$ 表示行的结尾，\[、\]、\s 等字符需要用反斜杠进行转义。

5. 在替换框中输入 \r\n，表示用 Windows 换行符替换匹配的行。如果你使用的是 Unix 系统，可以输入 \n。
6. 点击 Replace All 按钮即可删除所有包含特定字符串的行并且不留下空行。

## 1.96. 问: 什么是 SQA ?

SQA（Software Quality Assurance）工作是指在软件开发生命周期中对软件质量进行管理和保障的工作。SQA 工作旨在确保软件产品能够满足用户需求和期望，同时也满足组织的质量标准和法律要求。

SQA 工作包括以下方面：

1. 规划和管理质量：确定开发过程中的质量标准和目标，并确保项目团队遵循这些标准和目标。

2. 质量保证：制定和执行各种质量保证活动，以确保软件产品的质量符合组织的标准和用户的期望。

3. 测试管理：规划、设计和管理测试活动，包括测试计划、测试用例、测试场景和测试报告。

4. 缺陷管理：管理软件开发过程中发现的问题和缺陷，包括问题记录、缺陷跟踪和缺陷修复等活动。

5. 核查和审核：审核软件开发过程中的各种文档、代码和配置文件，以确保其质量和完整性。

6. 过程改进：通过对软件开发过程进行分析和评估，发现问题和瓶颈，并提出改进建议，以提高软件开发效率和质量。

SQA 工作对于软件产品的成功交付和用户满意度至关重要。它可以帮助组织降低软件开发成本和风险，提高软件开发效率和质量，从而增强组织的竞争力。

## 1.97. 问: 什么是 8D 分析

8D分析（Eight Disciplines，简称8D）是一种用于解决问题和改进过程的问题解决方法。8D是一种系统性、纪律性的方法，通常用于解决质量问题，但也可以应用于其他类型的问题。

8D分析由八个步骤组成，每个步骤都有特定的任务和目标。这些步骤是：

1. 确定问题范围：明确问题的性质、影响范围和影响程度。
2. 组建团队：选择具备相关知识和技能的人员组成团队，确定团队负责人。
3. 描述问题：对问题进行详细的描述，包括问题的发生时间、地点、频率、严重性等。
4. 制定临时措施：采取必要的措施来遏制问题的发生和扩散，确保问题不会进一步恶化。
5. 确定根本原因：使用常用的问题分析工具和技术来确定问题的根本原因。
6. 制定长期措施：基于对根本原因的分析，制定可行的长期措施来解决问题。
7. 实施和验证措施：实施长期措施，并验证其有效性。
8. 预防措施：通过学习和总结经验，采取预防措施，防止问题再次发生。

8D分析是一种常用的问题解决方法，它可以帮助组织更好地理解问题，并通过制定可行的解决方案来改善和优化过程，提高组织的绩效和效率。

## 1.98. 问: 重启电脑后 docker desktop 一直卡在启动中

1. 杀掉或退出 docker desktop
2. 管理员模式运行 command line 输入
```shell
net stop com.docker.service
wsl --unregister docker-desktop
wsl --unregister docker-desktop-data
net start com.docker.service
```

## 1.99. 问: CSDN 如何不登陆复制代码?

1. F12 进入开发者模式

2. 命令行输入
```log
document.designMode='on'
```

## 1.100. 问: MySQL 如何查看数据库中所有表的行数

```sql
SELECT table_name, table_rows FROM information_schema.tables WHERE table_schema = 'your_database_name';
```

## 1.101. 问: Centos7 如何查询磁盘挂载与占用情况

```sh
* df -T  只可以查看已经挂载的分区和文件系统类型

* fdisk -l 可以显示出所有挂载和未挂载的分区，但不显示文件系统类型

* parted -l 可以查看未挂载的文件系统类型，以及哪些分区尚未格式化

* lsblk -f 可以查看未挂载的文件系统类型

* df -h 查看磁盘使用率

* du -h 查看文件夹磁盘占用情况

* sudo fdisk -l 操作系统上所有可用分区的信息
```

## 1.102. 问: git 如何通过命令返回指定时间的 commit 信息

1. 通过标签号，查询该标签号(V2.0.56)， 到当前的提交信息
```sh
git log V2.0.0.58-P4..HEAD --pretty=format:"* %ad %an [%h](%H) : %s %b" --date=short --no-merges
```

2. 通过时间查询，该时间到现在的提交信息

```sh
git log  --after="2023-3-6 16:20" --pretty=format:"* %ad %an [%h](%H) : %s %b" --date=short --no-merges
```

## 1.103. 问: wsl 镜像如何导入与导出

```cmd
/// 导出
wsl --export <系统名字> <导出位置//导出名字.tar>

wsl --export Ubuntu F://desktop//ubuntu.tar

/// 导入
wsl --import <系统名字> <要搬到的位置> <之前导出包的位置>

wsl --import Ubuntu D://WSLUbuntu F://desktop//ubuntu.tar
```

## 1.104. 问: centos 查看系统版本

```shell
cat /etc/centos-release
```

## 1.105. 问: openEuler 查看系统版本

```shell
cat /etc/openEuler-release
```

## 1.106. 问: ubuntu 安装 32 位 libmysql

```shell
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install libmysqlclient-dev:i386
```

## 1.107. 问: ubuntu 查看已安装软件

```sh
dpkg -l | grep -i "mysql"
```

## 1.108. 问: mysql 批量插入过程

```sql
BEGIN
	DECLARE i INT DEFAULT 0;
    WHILE i < for_time * 10000 DO
		INSERT INTO operation_log(UUID, Time, UserType, UserID, LogInfo) VALUES(i, 1671612154, "123456789", "123456789", "123456789");
         SET i = i + 1;
    END WHILE;
END
```

## 1.109. 问: centos7 中 查找所有运行的端口

```sh
netstat -ano
```

## 1.110. 问: 查看被占用端口对应的 PID

```sh
netstat -aon|findstr "<pid>"
```

## 1.111. 问: 查看指定 PID 的进程

```sh
tasklist | findstr "<pid>"
```

## 1.112. 问: 替换 sh 脚本中的 window 字符 ^M

```sh
sed -i -e 's/\r$//' compress_log.sh
```

## 1.113. 问: 查看可执行文件依赖的 动态库

```cmd
dd /sbin/ftpd
```

## 1.114. 问: 获取 GitLab 指定库中所有 open 状态下的 issue

```cmd
curl.exe --header "Private-Token: ojWG5DPUbmRSGqMxZs1s" "http://gitlab.gbcom.com.cn/api/v4/projects/701/issues"
```

## 1.115. 问: 获取 GitLab 指定库中拥有 Bug 标签的 issue 并导出到文件 bug.json

```cmd
curl.exe -o bug.json --header "Private-Token: ojWG5DPUbmRSGqMxZs1s" "http://gitlab.gbcom.com.cn/api/v4/projects/701/issues?labels=Bug&state=opened&per_page=1000"
```

## 1.116. 问: google/benchmark 执行对应的性能测试

```cmd
/// 执行对应的性能测试
.\gos_benchmark.exe --benchmark_filter=BM_LogStream
/// 跑指定的单元测试和执行重复
./build/ds/cp4_filesystem/cp4_filesystem_tests --gtest_filter=vector.for_erase  --gtest_repeat=1000 --gtest_break_on_failure
```

## 1.117. 问: cmake 全部编译

1. windows 中
```cmd
cmake --build ./build/ --config=Debug
```

2. linux 中
```sh
sudo cmake --build ./build/ --target all --clean-first -- -j $(nproc)
```

## 1.118. 问: cmake 编译 gos 单元测试

1. windows
```cmd
cmake --build ./build/ds/gos --target gos_tests
```
2. linux
```sh
cmake --build ./build/ds/gos --target gos_tests -- -j$(nproc)
```

## 1.119. 问: cmake 重新生成

windows

```cmd
cmake -E chdir "build" cmake .. -A Win32
```

## 1.120. 问: CMake 运行测试

windows

```cmd
cmake --build ./build/ --target RUN_TESTS --config=Debug

# 生成、编译、运行测试
cmake -E chdir "build" cmake .. -A Win32 ; cmake --build ./build/ ; cmake -E chdir "build" ctest .. -C Debug
```

## 1.121. 问:CMake指定MSVC运行时库
```
在CMake 3.15版本后新增MSVC_RUNTIME_LIBRARY 目标变量用于修改MSVC运行时库
具体用法为：在写完cmake_minimum_required和project之后马上设置MSVC运行库，这样会影响所有的生成目标，例如：
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>") ///在DEBUG模式下使用/MT 库
MultiThreaded关键字表示MT库
其他具体关键字可以参照官网：https://runebook.dev/zh/docs/cmake/variable/cmake_msvc_runtime_library
```

## 1.122. 问:为何官网下载的googleTest框架的运行时库缺省为/MT 不能修改

将string(REPLACE "/MD" "-MT" ${flag_var} "${${flag_var}}")注释后可以修改
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/6959dc91-77af-451a-887a-246ad7439a6f)  

## 1.123. 问: ubuntu 替换清华源

```cmd
sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
```

## 1.124. 问：调度台软件登录时，提示音频加载失败

答：

1.  查看是否没有接音频设备。

2.  查看音频设备是否被禁用，电脑右下角右键点击声音设置小喇叭，选择声音，查看播放和录制中音频设备是否正常。

    注：若是刚安装华为服务，有可能是没有使用管理员权限安装华为服务导致。

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/eecd5de4-8fde-412d-a153-3ef36ee810f2)  

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/5aea763c-8333-4678-a328-a3213a8e8015)  

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/b86811de-5fb6-4a71-b268-7757a7649c4a)  

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/21a66fe1-fc75-4502-a8ec-6cb0d266fe5d)  


## 1.125. 问：调度台和调度服务器网络正常时，调度台提示连接二开调度服务器失败

答：

1.  远程连接二开调度服务器查看dis进程是否正常运行（是否有进程号、日志是否有error打印）。

2.  Dis是不是在反复重启

3.  Dis起来后数据库是否正常运行

## 1.126. 问：调度台软件打开后，登录界面，登录和退出按钮错位。

答：查看调度台电脑的分辨率，在系统桌面右键选择显示设置，查看缩放与布局将分辨率设置成适配的。

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/4d13f35e-0a4f-4684-a5a9-a7402b6acdee)


## 1.127. 问：调度台软件左下角指示灯，LTE爆红、CAD爆红、ATS爆红、NTP爆红

答：**LTE爆红**时，ping核心网MDC地址看是否可以正常通信，如果不行就排查网络问题。可以ping通的话，查看sdk服务正常运行。

CAD爆红，ping二开服务器dis的地址看是否可以正常通信。

ATS爆红，进入调度台服务器查看ATS接口是否正常，查看日志是否有关于ATS的报错，尝试pingATS接口地址能否通信。

NTP爆红，查看连接的NTP服务器的NTP状态是否正常


## 1.128. 问：人工广播发起后，没有返回广播状态，无法开始广播。

答：

1.  当我们点击人工广播按钮时，打开窗口，这时就会有人工广播请求发送给PA系统，打断所有车上的其他广播，应答给我们调度台可以开始的广播状态。

2.  查看车载主机的SA日志，tail -f
    /mnt/emmc/logsave/sa.log，先查看和广播接口是否正常连接，如果连接正常的话，调度台人工广播发起的时候，sa的日志也会有发起人工广播的打印

3.  如果没有先排查我们内部问题查看调度台日志，是否有发起人工广播的请求

4.  如果有，则需要广播厂家排查问题，可以进行抓包，通过报文进一步确认请求是否发出。

人工广播业务时序如下：
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/2e07ac4c-6be9-4a2f-acd1-d8e15523bef0)



## 1.129. 问：人工广播发起后，按下PTT说话车上没有听到广播声音。

答：

1.  在主机上抓包查看是否有PCM报文发出

2.  查看调度台日志，看是否有发送PCM的打印，在调度台电脑上安装Wireshark，打开抓包工具，在做人工广播业务时查看是否有UDP报文发送

## 1.130. 问：预录音广播发起后，没有收到广播状态。

答：

1.  确认包有没有发送到广播系统

2.  需要确认预录音广播是否成功播放出来，如果列车上成功播放，则是广播系统没给立即应答的消息，有可能他们的做法是播放完成后才给我们应答，但这样会存在另一个问题，我们调度台在预录音广播发起后，窗口是打开状态时，调度台没收到广播的应答，就会重复去向广播系统发送相同预录音广播，广播系统没做好判断的话，预录音广播就会在车上一直重复播放，广播系统应该收到预录音消息后，立刻给调度台应答消息。

3.  如果车上没有播放预录音广播，先排查调度台发送的消息，车载台主机SA是否收到并转发，查看sa.log就可以看出。

## 1.131. 问：预录音广播发起后，实际播放次数和调度台选择次数不符。

答：预录音广播次数是和预录音广播内容一起发送给广播系统的，可以通过查看sa的日志，如果车上预录音广播正常播放，那次数不对，大概率是广播系统处理问题，或者由于其他到站等广播干扰。

## 1.132. 问：IPH报警器触发后，调度台没有显示IPH请求

答：查看sa日志先确认IPH请求有没有发给我们，如果没有需要广播系统排查，有的话则排查我们内部。

第一种，排查列车是否有位置信息，如果没有，查看dis和ATS接口是否正常，临时测试的话可以使用手动转组，给列车一个位置。

第二种，排查网络是否正常，sa是否将消息发送给dis，查看dis的日志，查看dc的日志。

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/3c82f861-7150-461a-b698-3b177a7870ec)


## 1.133. 问：IPH报警器触发，调度台接听后，报警器还处于未接通状态

答：

1.  查看sa日志，调度台接听后会有消息发送给dis，dis再发送给sa，sa日志中有调度台接听的消息

2.  在主机上抓包查看消息有没有发送给广播厂家，如果发了就需要广播厂家排查问题。

## 1.134. 问：IPH报警器触发后，调度台接听但没有视频。

答：

1.  使用调度台ping广播主机的地址，ping不通的话先解决网络问题，

2.  如果能ping通，在调度台的电脑上使用VLC进行拉流，可以查看dc.log里面会有接听IPH的视频URL信息，复制到VLC里面拉流看能否查看到视频。例如："VideoURL":"rtsp://192.0.1.27:55404/h264/ch1/sub/av_stream"

3.  如果不能看到视频，则需要广播厂家排查摄像头的IP和端口等是否配置正确。

4.  如果能看到视频，则需要排查调度台软件问题。

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/bd4e8fad-1c3a-494c-896e-ee63b46976de)


## 1.135. 问：IPH报警器触发后，调度台接听但听不到报警器语音的声音。

答：

1.  调度台听不到报警器的语音，直接调度台抓包，看调度台上能否收到报警器的语音报文

2.  如果没有，在车载台主机上进行抓包，看主机是否能抓到报警器语音报文

3.  如果能抓到，则排查内部问题

4.  如果还是抓不到，则需要广播系统排查报警器语音是否发送出来

5.  如果报警器发出来了，则排查中间车载防火墙是否把报文拦截了。

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/135a3ae1-ac63-4e70-9b64-01887a438dec)


## 1.136. 问：调度台可以听到未监听的未知组号的组呼

答：

1.  先查看该调度台右下角呼叫记录中是那个群组进行的组呼。

2.  正在说话的会有话权人显示，根据组名称和组号码来判断这个组的类型。

3.  如果是静态组，在静态组列表内一开始没找到该群组，右键选择查看所有组，从中找到这个组，其状态应该是对讲，被调度台监听通话了,退出群组就听不到通话了；

4.  如果是动态组或者是派接组，可以通过dc.exe -t
    打开测试，查找到创建这个动态组和派接组的调度台，然后询问是否该群组是否有用，没有的话就释放掉。

## 1.137. 问： 对群组进行组呼时出现抢权失败，出现抢权提示音。

答：

1.  查看调度台是否正常接入LTE网络。

2.  查看该群组的组成员有没有这个调度台

3.  如果有应该是其他调度台同时在说话，正常的抢权提示

4.  如果没有，需要核心网把调度台加入该静态组。

## 1.138. 问：短信出现提示提示音但没有短信记录

答：查看dc.log有没有新进短信的打印，彩信可以到sdk目录下面找有没有相关内容。

## 1.139. 问：调度台视频上拉时，选择不需要确认直接拉取时手持台还需要进行确认

答：需要手持台将视频回传中设置被动回传需确认的勾选去掉。

## 1.140. 问：数据库无法远程通过root访问

答：服务器的数据库未打开root远程访问。

开启远程权限的方法：

mysql\> use mysql;

mysql\> show databases；  \#查询当前数据库

mysql\> select user,host from user; \#查询是否只允许localhost登录

mysql\> grant all privileges on \*.\* to root\@'%' identified by '登录的密码';
\#允许远程登录

mysql\> select user,host from user; 再次查询是否允许远程登录

mysql\> flush  privileges; \#刷新系统权限相关表

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/af2c93eb-c94e-4a1b-9acc-353f9141443c)


## 1.141. 问：数据库开机不会自动启动

答：通过命令查看一下数据库是否开启自启动

chkconfig//查看mysql是否开机自启动

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/1efb66ae-0c26-447b-84b6-66f2ff28cd9e)


如果看到mysql的服务，并且3,4,5都是on的话则成功，如果是off，则输入

chkconfig --level 345 mysql on

## 1.142. 问：dis进程打开后闪退，dis.log显示数据库连接错误

答：

1.  查看dis.ini中数据库地址配置是否正确

2.  通过Navicat连接数据库，查看数据库是否已导入。

## 1.143. 问：dis开启后，dis.log中显示数据库有字段找不到

答：

1.  远程Navicat连入数据库，查看报错字段在数据库中是否存在

2.  如果不存在，右键选中该数据库表格，然后设计表按照版本文档说明进行新字段添加

3.  如果存在，dis.log中还是出现错误打印，需要排查一下数据库是否配置了不区分了大小写，查看/etc/my.cnf文件里面是否配置了lower_case_table_names=1//表名不再区分大小写。

## 1.144. 问：如何查看进程是否正常启动并运行

答：

1.  反复使用pidof xxx 查看进程是否起来并且pid是否有变化，正常运行的进程pid应该是不变的。

2.  查看日志，日志连续且没有error打印。

## 1.145. 问：服务器数据库备份设置，如何手动复原数据库内容

答：

1.  需要将backup_db.sh脚本放置到dis文件同级目录下，修改脚本内容为现场实际数据库配置

2.  dis同级目录中有bak目录，该目录下有数据库备份文件，解压数据库文件

3.  进入本机mysql数据库中，mysql -uroot -p密码

4.  输入“source 数据库备份文件的绝对路径;”回车，即可将数据库文件恢复

## 1.146. 问：18号线车载台终端信道机自检项不通过，如何修复。

答：

1.  查看操作日志后发现有恢复配置操作

2.  进入配置页面查看信道机配置并确定，重启车载台app或车载台主机。

## 1.147. 问：18号线手柄一直处于摘机状态

答：查看话柄是否悬挂到正确的位置，话柄下方是否有遮挡，在测试app中查看PTT按钮是否有效。

## 1.148. 问：18号线车载台终端主机自检项不通过

答：使用网线连接车载台主机，CRT连接主机并查看dba、sa日志，日志中是否有明显报错，根据日志提示进行修复；仍无法修复，联系开发人员。

## 1.149. 问：车载台出现信道机自检不过，PLMN获取不到

答：

1.  现场快速处理方式，重启。

2.  如果不行重新配置网关地址（751地址），点击保存然后重启。

3.  如果还不行，重新对车载台进行入网配置。

## 1.150. 问：车载台登录不上去，一直处于登录界面

答：

1.  一直登录不上是车载台和核心网通信故障，通常出现在新设备未入网，可以跳过登录进到设置检查开具配置和软卡号是否正确。

2.  如果不正确，重新进行入网配置；

3.  如果没发现配置错误，可以找个手台或者其他车载台，在同小区物理位置大致相同的地方，看能否正常入网，如果不行需要核心网排查问题。

4.  出现反复登录退出，需要查看开户IMSI是否重复。

5.  终端系统时间是否正常

6.  检查核心网对车载台信道机后路由开户时是否正确

7.  核心网udc开户时关联一项要为空，否则也无法进行登录

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/cea57b53-402c-486f-8b08-f8b5f3e578a2)

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/b16d4704-4f80-46b2-bf14-54cc37272919)

## 1.151. 问：车载台终端话柄爆红

1.  话柄未挂机好

2.  话柄线缆未接好，需要检查话柄后面接线和车载台后面接线

## 1.152. 问：车载台终端右上角主机、dis状态爆红

1.  检查主机的D口线是否松动

2.  检查车载台终端背面的D口线是否松动

3.  检查各项开局配置是否正确

4.  通过web网页输入主机地址，检查主机配置是否正确

5.  CRT连接主机，查看主机dba.log是否有错误打印

## 1.153. 问：车载台终端右上角IPH/PA爆红

1.  检查广播接口线缆是否松动

2.  检查主机web界面中主机配置IPH/PA地址是否正确

3.  CRT连接主机，ping对方广播主机地址看能否ping通

4.  查看主机sa.log是否有错误打印，保留当时的日志和抓包文件

## 1.154. 问：车载台终端触屏不灵

1.  重启设备，查看能否恢复

2.  更换终端设备

## 1.155. 问：车载台终端扬声器没声音

1.  车载台APP设置界面，点击回到桌面

2.  使用测试APP播放音乐，监听车载台扬声器是否有声音，摘下话柄监听声音是否从话柄中传出。

3.  话柄有声音则是扬声器故障

4.  更换扬声器

## 1.156. 问：车载台终端出现黑屏

1.  车载台主机是否正常供电

2.  点击终端面板的rst按钮修复

3.  重启车载台主机，查看能否恢复

4.  更换设备


## 1.157. 问：如何验证18号线固定台的车站广播功能

答：

1.  使用手持台手动切换至车站上行或下行广播组 

2.  手持台进行组呼，固定台监测到有站区广播通话时，会自动切换至广播组，通话声音从车站广播系统中播出

3.  广播结束之后，固定台群组会自动切换到当前通话组

## 1.158. 问：18号线固定台车站广播出现故障，无声音放出

答：

1.  当前固定台的LTE网络是否正常

2.  检查物理线路连接是否正常，1分3的线上绿色凤凰头是否连接广播系统

3.  网络连接是否正常，尝试ping广播设备的ip地址

## 1.159. 问：网管服务器vsftp服务无法正常启动

答：

1.  使用命令systemctl status vsftpd查看当前服务状态

2.  systemctl start vsftpd启动服务，启动不了有错误提示，可能是配置文件错误

3.  配置文件备份，使用原生配置文件vsftpd.conf,在其中进行配置

4.  重新启动vsftpd服务

## 1.160. 问：ftp无法登陆服务器，ls无法看到文件

答：

1.  查看服务器vsftpd服务器是否开启正常运行。systemctl status vsftpd

2.  服务器防火墙是否关闭。systemctl disable firewalld.service \#永久关闭防火墙

3.  SELinux是否关闭

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/88118d66-9792-4043-9f75-f2d58b342010)


## 1.161. 问：设备如何被网管纳管

答：

1.  omc.ini中配置allow_auto_online=true是允许自动上线，当设备配置网管地址为omc服务器地址时，设备将自动被网管纳管。

2.  omc.ini中配置allow_auto_online=false是不允许自动上线，当设备配置网管地址后，需要在omt客户端上需要添加设备进行纳管。

3.  设备的mac地址要是不清楚的话，可以在omc.log中可以看到未被纳管设备的IP和MAC地址。

## 1.162. 问：系统状态中CAD服务器、录音录像服务器图标一直成灰色，设备上线也是灰色状态，或者设备列表中调度台设备的名称为空白

答：

1.  需要在设备的配置文件中[oma]中配置dev_name=XXX字段

2.  CAD服务器和录音录像服务器要安装系统状态中的图例，dev_name设置成相同的名称，系统状态中的图例会根据设备实际情况进行颜色变化。

## 1.163. 问：如何快速查看所有设备的版本信息内容和统计

答：

1.  登陆omt客户端，打开设备列表

2.  选择车载台或固定台，右键显示全部基本信息后可以查看到安卓版本和信道机版本。

3.  右键可以进行全部导出，可将设备列表整体导出，便于进行设备版本统计

## 1.164. 问：如何导出活跃告警和历史告警

>   答：

1.  选中网管告警事件

2.  按照需求对告警进行筛选查询

3.  右上角导出按钮或右键导出，会对当前查询内容列表进行导出至当前电脑

## 1.165. 问：使用网管对主机版本进行升级

1.  omt客户端的系统设置-版本管理中添加主机版本

2.  升级管理中选择要升级的设备和版本，点击升级

## 1.166. 问：如何进行告警配置，类似固定台的PA连接失败告警，因为固定台不需要和PA进行对接，该项告警没必要出现。

答：

1.  选择系统设置-告警配置

2.  选择设备，选中相关告警

3.  点击修改，选择忽略该告警

## 1.167. 问：录音录像服务器配置

答：

[How_to_use_MdcProxy_RECServer-CN.doc](/uploads/bf6eaee60188f76431f90ee485a4df81/How_to_use_MdcProxy_RECServer-CN.doc)

1.  需要核心网开录音录像节点

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/10be9a1f-2fd0-43c9-b3db-cb8156dba755)


2.  mrs.ini文件配置，user、pwd等按照核心网开户时的配置

## 1.168. 问：录音录像的文件怎么导出

答：

1.  从spt客户端上直接选中文件右键导出，选择导出文件的目标文件夹

2.  直接从mrs服务器中找到文件存储目录，手动从mrs服务器上直接拷贝出来 

# 沟通相关FAQ

## 对外反馈问题时出现的问题

1.对外反馈问题需要对方协助分析时需要提供出现问题的时间点。  
2.反馈问题提供的材料尽量准确，不要提供错误的信息。  
    例如：RG200U无法入网，移远给出的分析报告中的时间是16：32分，但是实际取模块日志的时间是8:55
    反馈16：32这个时间点给移动，徒然浪费时间。
 
移远分析模块日志截图：     
<img width="776" alt="f5c2ceb8043c28c0b669e6ee8826d81" src="https://github.com/grow-man/MyLearningRecorder/assets/52662997/88736c62-1a15-4067-a2f3-4a0ae62bf309">
截图显示模块被拒绝入网的时间是16:32,但是实际取模块的时间是8：55左右，时间对不上。

将16：32这个时间点提供给网络侧分析，导致他们浪费时间。  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/dea777fe-3d45-466c-85b8-4f308ca39187)
    
3.反馈问题时尽量提供相关证据，例如日志、抓包文件、截图等。截图时注意截图内容，不要出现敏感信息。

## 现场反馈问题
1.问题描述尽量清晰。  
2.反馈问题时尽量将问题发生的环境一并描述。
3.尽量第一时间截图、拍照、录视频。
4.反馈问题时尽量提供问题发生的事件节点。
4、请务必取出日志、抓包文件、截图等资料，并妥善保存。
