### 使用场景 
* 对压缩比不敏感的场景  
* 对内存不敏感的场景(例如我需要压缩一个100M的文件使用quicklz就需要申请200M的内存对于某些嵌入式设备来说简直就是灾难)  
* 对压缩时间有要求的场景(确实快，实测移远模块RG200U的100M日志文件压缩只需要5秒钟)

在网上搜索到https://github.com/RT-Thread-packages/quicklz/blob/master/quicklz_sample.c  
使用分片压缩/分片解压的方式解决内存问题  

核心代码如下：
压缩
```
for (i = 0; i < file_size; i += COMPRESS_BUFFER_SIZE)  
   {  
        if ((file_size - i) < COMPRESS_BUFFER_SIZE)  
        {  
            block_size = file_size - i;  
        }  
        else  
        {  
            block_size = COMPRESS_BUFFER_SIZE;  
        }  

        memset(buffer, 0x00, COMPRESS_BUFFER_SIZE);
        memset(cmprs_buffer, 0x00, COMPRESS_BUFFER_SIZE + BUFFER_PADDING);

        read(fd_in, buffer, block_size);

        /* The destination buffer must be at least size + 400 bytes large because incompressible data may increase in size. */
        cmprs_size = qlz_compress(buffer, (char *) cmprs_buffer, block_size, state_compress);

        /* Store compress block size to the block header (4 byte). */
        buffer_hdr[3] = cmprs_size % (1 << 8);
        buffer_hdr[2] = (cmprs_size % (1 << 16)) / (1 << 8);
        buffer_hdr[1] = (cmprs_size % (1 << 24)) / (1 << 16);
        buffer_hdr[0] = cmprs_size / (1 << 24);

        write(fd_out, buffer_hdr, BLOCK_HEADER_SIZE);
        write(fd_out, cmprs_buffer, cmprs_size);

        totle_cmprs_size += cmprs_size + BLOCK_HEADER_SIZE;
        rt_kprintf(">");
    }
```
解压缩  
```
for (i = 0; i < file_size; i += BLOCK_HEADER_SIZE + block_size)
    {
        /* Get the decompress block size from the block header. */
        read(fd_in, buffer_hdr, BLOCK_HEADER_SIZE);
        block_size = buffer_hdr[0] * (1 << 24) + buffer_hdr[1] * (1 << 16) + buffer_hdr[2] * (1 << 8) + buffer_hdr[3];

        memset(buffer, 0x00, COMPRESS_BUFFER_SIZE + BUFFER_PADDING);
        memset(dcmprs_buffer, 0x00, DCOMPRESS_BUFFER_SIZE);

        read(fd_in, buffer, block_size);

        dcmprs_size = qlz_decompress((const char *) buffer, dcmprs_buffer, state_decompress);
        write(fd_out, dcmprs_buffer, dcmprs_size);

        total_dcmprs_size += dcmprs_size;
        rt_kprintf(">");
    }
```


