工具的功能：将log目录下的dsp数据（org或者pbs文件）转换成tp文件。

参数：dspconv  -i  log-dir-path  -o output-dir-path  [-a “tp-addr1,tp-addr2,…”]  [-t [Common|LTE|TG AG]]
-i log-dir-path                                        输入log目录（目录结构参考logel工具抓取log后在History下生成的时间戳目录下的结构）
-o output-dir-path                                输出路径
[-a “tp-addr1,tp-addr2,…”]               可选参数，让用户指定导出特定 地址的tp数据，默认全部导出
[-t [Common|LTE|TG| AG]]              可选参数，让用户指定转换哪种类型dsp数据（每种类型对应一个文件），默认全部转换


实现过程
1.	先搜索子目录下的dsp pbs文件，如有，根据输入参数转换成tp文件
2.	如果没有dsp pbs文件，查找org文件，根据输入参数转换成tp文件