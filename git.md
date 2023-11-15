## 子模块.gitsubmodules使用
在实际开发中我们有如下代码库：LTE集群代码库（包括调度台，调度服务器，录音录像服务器&终端，网管服务器&操作终端）、车载台嵌入式软件代码库、固定台嵌入式软件代码库。  
实操中发现如下问题：  
1、版本发布时不集中  
2、issue提交不集中，现场问题BUG可能涉及多个网元但是只在一个库提交  


## gitlab 不能直接上传超过10M文件
`curl.exe --request POST --header "Private-Token: z31sGkhX_EwRSxAZtgNz" --form "file=@D:\\常用软件\\tftp\\unzip(1)\unzip.exe" "http://gitlab.gbcom.com.cn/api/v4/projects/847/uploads"`  
Private-Token 是你的私钥令牌  
file=@D:\\常用软件\\tftp\\unzip(1)\unzip.exe 指定想要上传的文件  
http://gitlab.gbcom.com.cn/api/v4/projects/847/uploads 项目库 
