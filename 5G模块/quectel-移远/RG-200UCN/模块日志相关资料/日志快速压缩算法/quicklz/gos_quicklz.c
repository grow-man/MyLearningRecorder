// Sample demo for QuickLZ 1.5.x

// Remember to define QLZ_COMPRESSION_LEVEL to the same value for the compressor and decompressor

#include <stdio.h>
#include <stdlib.h>

#include "g_include.h"
#include "quicklz.h"

typedef struct
{
    qlz_state_compress      stCompState;
    qlz_state_decompress    stDecompState;
}_GOS_COMP_STATE_T;
 
HANDLE gos_comp_init(VOID)
{
    _GOS_COMP_STATE_T *pstState = (_GOS_COMP_STATE_T*)malloc(sizeof(_GOS_COMP_STATE_T));

    return (HANDLE)pstState;
}

VOID gos_comp_free(HANDLE hZip)
{
    if (hZip)
    {
        free(hZip);
    }
}

VOID gos_comp(HANDLE hZip, const CHAR *pucIn, UINT32 ulInLen, CHAR *pucOut, UINT32 *pulOutLen)
{
    _GOS_COMP_STATE_T *pstState = (_GOS_COMP_STATE_T *)hZip;

    memset(&pstState->stCompState, 0, sizeof(pstState->stCompState));

    *pulOutLen = qlz_compress(pucIn, pucOut, ulInLen, &pstState->stCompState);
}

UINT32 gos_get_comp_size(const CHAR *pucCompressed)
{
    return qlz_size_compressed(pucCompressed);
}

UINT32 gos_get_decomp_size(const CHAR *pucCompressed)
{
    return qlz_size_decompressed(pucCompressed);
}

VOID gos_decomp(HANDLE hZip, const CHAR *pucIn, CHAR *pucOut, UINT32 *pulOutLen)
{
    _GOS_COMP_STATE_T *pstState = (_GOS_COMP_STATE_T *)hZip;

    memset(&pstState->stDecompState, 0, sizeof(pstState->stDecompState));

    *pulOutLen = qlz_decompress(pucIn, pucOut, &pstState->stDecompState);
}

#if 0
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

    int iPriority;
    HANDLE hThread = GetCurrentThread();

    iPriority = GetThreadPriority(hThread);
    if ( iPriority != THREAD_PRIORITY_ERROR_RETURN )
    {
        SetThreadPriority(hThread, THREAD_PRIORITY_TIME_CRITICAL);
    }

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
#endif
