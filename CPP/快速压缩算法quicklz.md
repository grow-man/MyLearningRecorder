### 使用场景 
* 对压缩比不敏感的场景  
* 对内存不敏感的场景(例如我需要压缩一个100M的文件使用quicklz就需要申请200M的内存对于某些嵌入式设备来说简直就是灾难)  
* 对压缩时间有要求的场景(确实快，实测移远模块RG200U的100M日志文件压缩只需要5秒钟)

在网上搜索到https://github.com/RT-Thread-packages/quicklz/blob/master/quicklz_sample.c  
使用分片压缩/分片解压的方式解决内存问题  
