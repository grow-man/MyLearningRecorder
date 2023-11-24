解压的方法：
调用extract_db.bat这个批处理，传入两个参数：压缩解析库的全路径，释放的目录
举例：
extract_db.bat "D:\modem.db"  "E:\parser"

压缩的方法：
调用compress_db.bat这个批处理，传入两个参数：压缩文件名， 待压缩目录
举例：
compress_db.bat "D:\LogelTool\History\2015_10_21_20_21_56_053_modem.db" "D:\LogelTool\Parser\*" 
注意待压缩目录的结尾符*, 带*表示该文件夹下所有文件压缩，不带*表示把该文件夹压缩