
del dsp_amr.mem
del *.pcm
del *.pk
del *.COD
del dump_info.txt
del data-0001-nb.txt
del data-0006-nb.txt
del data-0001-c2k.txt
del data-0006-c2k.txt
del data-0001-wb.txt
del data-0006-wb.txt
del data-0001-evs.txt
del data-0006-evs.txt

del out.txt
del out_time.txt
del data-vbc.txt

ren *.mem dsp_amr.mem 

VP_CONVERT.exe dsp_amr.mem >dump_info.txt
fs_efs_switch.exe data-0001-nb.txt  
enc_decoder.exe data-0006-nb.txt 
dump_tool_c2k_decoder.exe  data-0001-c2k.txt  data-0001-8k-c2k.pcm
dump_tool_c2k_decoder.exe  data-0006-c2k.txt  data-0006-8k-c2k.pcm
amr_wb.exe 0 data-0001-wb.txt data-0001-16k-0000-time.pcm data-0001-16k-0000.pcm
amr_wb.exe 1 data-0006-wb.txt data-0006-16k-0000-time.pcm data-0006-16k-0000.pcm
EVS_log_analyse.exe 0 data-0001-evs.txt evs_p1_8kout.pcm evs_p1_16kout.pcm  evs_p1_32kout.pcm
EVS_log_analyse.exe 1 data-0006-evs.txt evs_p6_8kout.pcm evs_p6_16kout.pcm  evs_p6_32kout.pcm


@cmd
