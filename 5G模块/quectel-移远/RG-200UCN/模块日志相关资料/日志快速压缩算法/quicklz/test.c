// Sample demo for QuickLZ 1.5.x

// Remember to define QLZ_COMPRESSION_LEVEL to the same value for the compressor and decompressor

#include <stdio.h>
#include <stdlib.h>

#include "quicklz.h"

#include <windows.h>
#include "gos_time.h"

void test_comp(qlz_state_compress *pstState, unsigned char *pucIn, int iInLen, unsigned char *pucOut, int *piOutLen)
{
    //char    *compressed;
    //qlz_state_compress *state_compress = (qlz_state_compress *)malloc(sizeof(qlz_state_compress));

    //compressed = (char*) malloc(data_size + 400);

    // allocate and initially zero out the states. After this, make sure it is
    // preserved across calls and never modified manually
    memset(pstState, 0, sizeof(qlz_state_compress));

    *piOutLen = qlz_compress((char*)pucIn, (char*)pucOut, iInLen, pstState);
}

void test_decomp(qlz_state_decompress *pstState, unsigned char *pucIn, int iInLen, unsigned char *pucOut, int *piOutLen)
{
    //char *file_data, *decompressed;
    //size_t d, c;
    //qlz_state_decompress *state_decompress = (qlz_state_decompress *)malloc(sizeof(qlz_state_decompress));

    // a compressed packet can be at most "uncompressed size" + 400 bytes large where
    // "uncompressed size" = 10000 in worst case in this sample demo
    //file_data = (char*) malloc(10000 + 400);

    // allocate decompression buffer
    //decompressed = (char*) malloc(10000);

    // allocate and initially zero out the scratch buffer. After this, make sure it is
    // preserved across calls and never modified manually
    memset(pstState, 0, sizeof(qlz_state_decompress));

    //c = qlz_size_compressed(pucIn);
    *piOutLen = qlz_decompress(pucIn, pucOut, pstState);

    return;
}

#define hash_func11(i)    (((i >> 12) ^ i) & (QLZ_HASH_VALUES - 1))

int main(int argc, char* argv[])
{
    //FILE *fp = fopen("d:\\test_1.f3g", "rb");
    FILE *fp = fopen("d:\\ZTE_TD.f3g", "rb");

    char *szOri;
    char *szComp;
    char *szUnComp;
    int  iDataSize = 24*1024*1024;
    int  iCompLen = 0;
    int  i, j;
    int  iUncompLen = 0;
    __int64 i64Time;
    double  dTime;
    qlz_state_compress *pstCompState = (qlz_state_compress *)malloc(sizeof(qlz_state_compress));
    qlz_state_decompress *pstDecompState = (qlz_state_decompress *)malloc(sizeof(qlz_state_decompress));

//     int iPriority;
//     HANDLE hThread = GetCurrentThread();
//
//     iPriority = GetThreadPriority(hThread);
//     if ( iPriority != THREAD_PRIORITY_ERROR_RETURN )
//     {
//         SetThreadPriority(hThread, THREAD_PRIORITY_TIME_CRITICAL);
//     }

    szOri = malloc(iDataSize*3+400);
    szComp = szOri+iDataSize;
    szUnComp = szComp+iDataSize+400;

    fseek(fp, 2*1024*1024, SEEK_SET);
    fread(szOri, iDataSize, 1, fp);
    fclose(fp);

    gos_time_init();
    i64Time = gos_get_uptime_1ns();
    test_comp(pstCompState, szOri, iDataSize, szComp, &iCompLen);
    i64Time = gos_get_uptime_1ns() - i64Time;
    dTime = i64Time/(double)1000000;
    printf("\n time = %.2f rate = %.1f speed = %.1f MBps",
            dTime,
            (double)100*iCompLen/iDataSize,
            (double)1000*(iDataSize/(1024*1024))/dTime);

    free(pstCompState);

    i64Time = gos_get_uptime_1ns();
    test_decomp(pstDecompState, szComp, iCompLen, szUnComp, &iUncompLen);
    i64Time = gos_get_uptime_1ns() - i64Time;
    dTime = i64Time/(double)1000000;
    printf("\n speed = %.1f MBps",
            (double)1000*(iDataSize/(1024*1024))/dTime);

    if (iUncompLen == iDataSize &&
        memcmp(szOri, szUnComp, iDataSize) == 0)
    {
        printf("\n test ok");
    }
    else
    {
        printf("\n test fail");
    }

    free(pstDecompState);
    free(szOri);

    getchar();
}
