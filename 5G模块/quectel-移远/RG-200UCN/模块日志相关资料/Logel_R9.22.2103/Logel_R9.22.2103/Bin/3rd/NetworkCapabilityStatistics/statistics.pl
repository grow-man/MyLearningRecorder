#!user/bin/perl -w
#use strict;
#use warnings;

if (scalar(@ARGV) != 5)
{
    die "[statistics.pl] must receive 5 parameters, please check the parameter list!";
}

my $delete_tmp_file_on_exit = 1;  # 解析完成以后是否删除临时文件

# 控制日志在打印到文件的同时，是否需同时打印到屏幕
my $log_both = 0;

#接收bat文件传进来的参数
my $data_folder         = ${ARGV[0]};    # 数据文件路径
my $band_cfg_folder     = ${ARGV[1]};    # Band配置文件路径
my $result_folder_path  = ${ARGV[2]};    # 导出文件夹路径
my $current_path        = ${ARGV[3]};    # Perl脚本路径
my $output_file_name    = ${ARGV[4]};    # 结果文件名称

my $msg_data_file       = $result_folder_path."\\all.msgd";       # 数据文件(.msgd)路径
my $air_data_file       = $result_folder_path."\\all.aird";       # 数据文件(.aird)路径
my $trace_data_file     = $data_folder."\\traceview.dat";         # 数据文件(traceview.dat)路径
my $trace_pbs_file      = $data_folder."\\traceview.pbs";         # 数据文件(traceview.pbs)路径
my $result_file         = $result_folder_path."\\$output_file_name"; # 结果文件路径
my $band_cfg_file       = $band_cfg_folder."\\Band.ini";          # Band配置文件

# 定义读写文件的句柄
my $fh_log;         #读取的日志文件句柄
my $fh_msg_data;    #读取的Internal Messages数据文件句柄
my $fh_trace_data;  #读取的Traces数据文件句柄
my $fh_air_data;    #读取的Air Messages数据文件句柄
my $fh_result;		#导出文件句柄
my $fh_band_cfg;    #Band配置文件句柄

my $CurASName;          #当前空口消息中提取出的空口消息名称
my $CurPeerData = ""; 	#当前空口消息中提取出的Peer数据
my $CurLocalData = "";	#当前空口消息中提取出的Local数据
my $Time = 0;
my $line_read;
my @trace_lines = ();
my $trace_line_cnt = 0;
my @mcc = ("","","");
my @mnc = ("","","");

#储存结果值
my %result_value_map = ();
my %capability_count_map         = ('SYSTEMINFORMATION'=>8, 'SYSTEMINFORMATIONBLOCKTYPE1'=>4, 'SYSTEM_INFORMATION_TYPE2'=>1, 'RRCCONNECTIONRECONFIGURATION'=>13, 'MBMSIMTERESTINDICATION-R11'=>1, 'RADIOBEARERSETUP'=>4, 'ALL_INTERNAL_MSG'=>3, 'MEASUREMENTREPORT'=>2, 'PAGING'=>2, 'SIB2'=>1, 'SIB3'=>1, 'SIB5'=>3,
'UEINFORMATIONREQUEST-R9'=>1, 'RRCCONNECTIONSETUP'=>1);
my %capability_extract_count_map = ('SYSTEMINFORMATION'=>0, 'SYSTEMINFORMATIONBLOCKTYPE1'=>0, 'SYSTEM_INFORMATION_TYPE2'=>0, 'RRCCONNECTIONRECONFIGURATION'=>0,  'MBMSIMTERESTINDICATION-R11'=>0, 'RADIOBEARERSETUP'=>0, 'ALL_INTERNAL_MSG'=>0, 'MEASUREMENTREPORT'=>0, 'PAGING'=>0, 'SIB2'=>0, 'SIB3'=>0, 'SIB5'=>0, 'UEINFORMATIONREQUEST-R9'=>0, 'RRCCONNECTIONSETUP'=>0);

my %gsm_band_cfg = ();
my %lte_band_cfg = ();
my %w_band_cfg = ();
my $current_band;
my %band_cfg = ('gsm'=>\%gsm_band_cfg, 'lte'=>\%lte_band_cfg, 'w'=>\%w_band_cfg);

sub Prepare
{
	OpenLogFile();
	
	my ($sec, $min, $hour, $mday, $mon, $year) = (localtime)[0..5];
 	my $time_format = sprintf("%d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

	WriteLog("------------------- Start Export Wireless Network Capabilities ($time_format) -------------------");
	
	my $i = 0;
	for($i = 0; $i < scalar(@ARGV); $i++)
	{
	    WriteLog("Input Param[$i]: ${ARGV[$i]}");
	}
	
	# 格式化结果文件名称
	if ($result_file =~ /(.*)_pb\d+/i)
	{
		$result_file = $1."_NetworkCapability.csv";
	}
	else
	{
		$result_file .= "_NetworkCapability.csv";
	}
}

sub OpenLogFile()
{
	unless (open $fh_log, '+>>', "$current_path\\Statistics.log")
	{
	    die "Can not open log file for reading:$!";
	}
}

sub CloseLogFile()
{
	close $fh_log or die "Can not close log file: $!";
}

sub OpenFiles()
{
	unless(open $fh_band_cfg,    '<', $band_cfg_file)
	{
	    WriteLog("Can not open '$band_cfg_file' for reading: $!");
	    die "Can not open '$band_cfg_file' for reading: $!";
	}
	
    unless(open $fh_msg_data,    '<', $msg_data_file)
    {
        WriteLog("Can not open '$msg_data_file' for reading: $!");
        die "Can not open '$msg_data_file' for reading: $!";
    }
    
    unless(open $fh_trace_data,  '<', $trace_data_file)
    {
        WriteLog("Can not open '$trace_data_file' for reading: $!");
        die "Can not open '$trace_data_file' for reading: $!";
    }
    
    unless(open $fh_trace_pbs,   '<', $trace_pbs_file)
    {
		WriteLog("Can not open '$trace_pbs_file' for reading: $!");
		die "Can not open '$trace_pbs_file' for reading: $!";
	}
	
    unless(open $fh_air_data,    '<', $air_data_file)
    {
    	WriteLog("Can not open '$air_data_file' for reading: $!");
    	die "Can not open '$air_data_file' for reading: $!";
    }
    
    unless(open $fh_result,      '>', $result_file)
    {
		WriteLog("Can not open $result_file file for writting: $!");
		die "Can not open '$result_file' for writting: $!";
	}
}

sub CloseFiles
{
	close $fh_band_cfg   or die "Can not close '$band_cfg_file': $!";
    close $fh_msg_data   or die "Can not close '$msg_data_file': $!";
    close $fh_trace_data or die "Can not close '$trace_data_file': $!";
    close $fh_trace_pbs  or die "Can not close '$trace_pbs_file': $!";
    close $fh_air_data   or die "Can not close '$air_data_file': $!";
    close $fh_result,    or die "Can not close '$result_file': $!";
    
    CloseLogFile();
}

sub Ending
{
	if ($delete_tmp_file_on_exit)
	{
		unlink $msg_data_file;
		unlink $air_data_file;
	}
}

sub LoadBandConfig
{
	if (!fh_band_cfg)
	{
		return;
	}
	
	while ( $line_read = <$fh_band_cfg> )
    {
    	$line_read = trim($line_read);
    	if ($line_read eq "")
    	{
    		next;
    	}

        if ($line_read eq "[GSM]")
        {
            $current_band = \%gsm_band_cfg;
            next;
        }
        elsif ($line_read eq "[3G]")
        {
            $current_band = \%w_band_cfg;
            next;
        }
        elsif ($line_read eq "[LTE]")
        {
            $current_band = \%lte_band_cfg;
            next;
        }
        
        if ($line_read =~ /(\d+)\s*=(.*)/)
        {
        	my $band = $1;
	        my $value = $2;
	        
	        $$current_band{$band} = trim($value);
        }
    }
}

sub GetPeerData()
{
    # 把PeerData中数据拼接入字符串
    my $bPeerStart = 0;
    $CurPeerData = "";
    while ( $line_read = <$fh_air_data> )
    {
        if ($line_read =~ /\s*.*\[peer_msg_start\]\s*.*/)
        {
            $bPeerStart = 1;    
        }
        elsif ($line_read =~ /\s*.*\[peer_msg_end\]\s*.*/)
        {
            $line_read = "";
            last;                
        }
        elsif ($bPeerStart)
        {
            $CurPeerData .= $line_read;
        }
    }
}

sub WriteHeader2ResultFile
{
	if ($fh_result)
	{                    
		print $fh_result "mcc,mnc,"
		           		 # LTE
						 ."TTI bundling r12,MultiTA,Joint CA,UL Comp,Long DRX command MAC CE,eMBMS(Service Continue),"
						 ."multiACK-CSI-Reporting-r11,Smart Congestion Mitigation,bSRVCC related,aSRVCC related,DL CA,UL CA,Non-CA,"
						 ."VoLTE,UL 64QAM,SRVCC_DRX,SRVCC_CDRX,Multicarrier CA,eMFBI,CSG,ANR,CGI,ETWS&CMAS,MDT,UL MIMO,eICIC,"
						 ."timerT312-r12,logicalChanelSR-ProhibitTimer-r12,TM9,Measurement_r12 WideBand RSRQ,"
						 ."Measurement_r12 Extended RSRQ,Measurement_r12 RSRQ OnAllSymbols,IncMon,"
						 # WCDMA
					 	 ."W DB,DC,Non-DC,W-Type3i,W-eRACH,AMR WB,UMTS Cipher,Hsdpa / Hsupa,CBS,E-FACH,E_PCH,CPC,"
					 	 # GSM
					     ."Vamos,BSS Paging Coordination,GPRS Encryption Algorithm,GSM cipher with algorithm"
						 ."\n";
	}
}

sub WriteData2ResultFile
{
	if ($fh_result)
	{
		WriteParam2ResultFile(FormatValue("mcc"));
		WriteParam2ResultFile(FormatValue("mnc"));
		WriteParam2ResultFile(FormatValue("tti-bundling"));
		WriteParam2ResultFile(FormatValue("multi-ta"));
		WriteParam2ResultFile(FormatValue("joint-ca"));
		WriteParam2ResultFile(FormatValue("ul-comp"));
		WriteParam2ResultFile(FormatValue("long-drx"));
		WriteParam2ResultFile(FormatValue("embms"));
		WriteParam2ResultFile(FormatValue("multi-ack"));
		WriteParam2ResultFile(FormatValue("scm"));
		WriteParam2ResultFile(FormatValue("bsrvcc"));
		WriteParam2ResultFile(FormatValue("asrvcc"));
		WriteParam2ResultFile(FormatValue("dl-ca"));
		WriteParam2ResultFile(FormatValue("ul-ca"));
		WriteParam2ResultFile(FormatValue("non-ca"));
		WriteParam2ResultFile(FormatValue("volte"));
		WriteParam2ResultFile(FormatValue("ul-64qam"));
		WriteParam2ResultFile(FormatValue("srvcc-drx-cdrx"));
		WriteParam2ResultFile(FormatValue("srvcc-drx-cdrx"));
		WriteParam2ResultFile(FormatValue("multi-ca"));
		WriteParam2ResultFile(FormatValue("e-mfbi"));
		WriteParam2ResultFile(FormatValue("csg"));
		WriteParam2ResultFile(FormatValue("anr"));
		WriteParam2ResultFile(FormatValue("cgi"));
		WriteParam2ResultFile(FormatETWS_CMAS());
		WriteParam2ResultFile(FormatValue("mdt"));
		WriteParam2ResultFile(FormatValue("ul-mimo"));
		WriteParam2ResultFile(FormatValue("e-icic"));
		WriteParam2ResultFile(FormatValue("timer-t312-r12"));
		WriteParam2ResultFile(FormatValue("lcsr-prohibit-r12"));
		WriteParam2ResultFile(FormatValue("tm9"));
		WriteParam2ResultFile(FormatMeasWBRSRQ());
		WriteParam2ResultFile(FormatValue("meas-r12-extended-rsrq"));
		WriteParam2ResultFile(FormatValue("meas-r12-rsrq-onallsymbols"));
		WriteParam2ResultFile(FormatValue("inc-mon"));
		WriteParam2ResultFile(FormatValue("w-db"));
		WriteParam2ResultFile(FormatValue("dc"));
		WriteParam2ResultFile(FormatValue("non-dc"));
		WriteParam2ResultFile(FormatValue("w-type3i"));
		WriteParam2ResultFile(FormatValue("w-erach"));
		WriteParam2ResultFile(FormatValue("amr-wb"));
		WriteParam2ResultFile(FormatValue("umts-cipher"));
		WriteParam2ResultFile(FormatHsdpaHsupa());
		WriteParam2ResultFile(FormatValue("cbs"));
		WriteParam2ResultFile(FormatValue("e-fach"));
		WriteParam2ResultFile(FormatValue("e-pch"));
		WriteParam2ResultFile(FormatValue("cpc"));
		WriteParam2ResultFile(FormatValue("vamos"));
		WriteParam2ResultFile(FormatValue("bss_paging_coor"));
		WriteParam2ResultFile(FormatValue("gprs-algo"));
		WriteParam2ResultFile(FormatValue("gsm-algo"));
	}
}

sub WriteParam2ResultFile
{
	if ($fh_result)
	{
		print $fh_result "$_[0],";
	}
}

# 按行打印到日志文件中
sub WriteLog
{
	my $value = $_[0];
	print $fh_log $value."\n";
	
	if ($log_both)
	{
		print $value."\n";
	}
}

sub trim
{
    my $string = shift;
    $string =~ s/^\s+//s;
    $string =~ s/\s+$//s;
    if (length($string) < 1)
    {
        return " ";
    }
    else
    {
        return $string;
    }    
}

sub FormatValue
{
	if (exists $result_value_map{$_[0]})
	{
		if ($result_value_map{$_[0]} eq "1" || $result_value_map{$_[0]} eq "TRUE" || $result_value_map{$_[0]} eq "True" || $result_value_map{$_[0]} eq "True")
		{
			return "Yes";
		}
		elsif ($result_value_map{$_[0]} eq "0" || $result_value_map{$_[0]} eq "FALSE" || $result_value_map{$_[0]} eq "False" || $result_value_map{$_[0]} eq "false")
		{
			return "No";
		}
		else
		{
			return $result_value_map{$_[0]};
		}
	}
	else
	{
		return "No"
	}
}

sub FormatHsdpaHsupa
{
	my $hsdpa_support = (exists $result_value_map{'hsdpa'} and $result_value_map{'hsdpa'} eq "1");
	my $hsupa_support = (exists $result_value_map{'hsupa'} and $result_value_map{'hsupa'} eq "1");
	
	if ($hsdpa_support and $hsupa_support)
	{
		return "HSDPA / HSUPA";
	}
	elsif ($hsdpa_support)
	{
		return "HSDPA";
	}
	elsif ($hsupa_support)
	{
		return "HSUPA";
	}
	else
	{
		return "No";
	}
}

sub FormatETWS_CMAS
{
	my $etws_support = (exists $result_value_map{'etws'} and $result_value_map{'etws'} eq "true");
	my $cmas_support = (exists $result_value_map{'cmas'} and $result_value_map{'cmas'} eq "true");
	
	if ($etws_support and $cmas_support)
	{
		return "Yes";
	}
	else
	{
		return "No";
	}
}

sub FormatMeasWBRSRQ
{
	my $sib1_support = exists $result_value_map{'meas-wb-rsrq-sib1'};
	my $sib3_support = exists $result_value_map{'meas-wb-rsrq-sib3'};
	my $sib5_support = exists $result_value_map{'meas-wb-rsrq-sib5'};
	my $conn_support = (exists $result_value_map{'meas-wb-rsrq-conn'} and $result_value_map{'meas-wb-rsrq-conn'} eq "true");
	
	if (($sib1_support and $sib3_support and $sib5_support) or $conn_support)
	{
		return "Yes";
	}
	else
	{
		return "No";
	}
}

sub IsWFreq
{
	my $earfcn = $_[0];
	
	my $band = "";
	my $value = "";
	my @band_spec_list = ();
	foreach $band (keys %w_band_cfg)
	{
		$value = $w_band_cfg{$band};
		
		@band_spec_list = split(/,/, $value);
	    foreach $band_spec (@band_spec_list)
	    {
	    	if ($band_spec =~ /(\d+)-(\d+)/)
	    	{
	    		if ($earfcn >= $1 and $earfcn <= $2)
	    		{
	    			return 1;
	    		}
	    	}
	    	elsif ($earfcn == $band_spec)
	    	{
	    		return 1;
	    	}
	    }
	}

	return 0;
}

sub Is3G
{
	my $sub_count = $_[0];
	my $trace_index = $trace_line_cnt + $sub_count;
	my $trace_pbs_offset = 512 + 44 * $trace_index; # 512:PBS文件头；44:PBS二进制文件中每条trace长度

	binmode($fh_trace_pbs);

	my $buff;
	seek($fh_trace_pbs, $trace_pbs_offset, 0);
	if (read($fh_trace_pbs, $buff, 44))
	{
		my $rat = substr($buff, 10, 1);
		if ($rat eq "\1" || $rat eq "\3") # 第11个字节代表RAT：（1，3为3G；2为GSM；5：LTE）
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	
	return 0;
}

sub GetBand
{
	my $earfcn = $_[0];
	my $key = "";
	foreach $key (keys %band_cfg)
	{
		my $mode_band = $band_cfg{$key};

		my $band = "";
		my $value = "";
		my @band_spec_list = ();
		foreach $band (keys %$mode_band)
		{
			$value = $$mode_band{$band};
			
			@band_spec_list = split(/,/, $value);
		    foreach $band_spec (@band_spec_list)
		    {
		    	if ($band_spec =~ /(\d+)-(\d+)/)
		    	{
		    		if ($earfcn >= $1 and $earfcn <= $2)
		    		{
		    			return $band;
		    		}
		    	}
		    	elsif ($earfcn == $band_spec)
		    	{
		    		return $band;
		    	}
		    }
		}
	}
	
	return -1;
}

sub ProcessData
{
	LoadBandConfig();
	
	ProcessInternalMsgData();
	ProcessTraceData();
	ProcessAirMsgData();
	
	WriteHeader2ResultFile();
	WriteData2ResultFile();
}

sub ProcessInternalMsgData
{
	my $line_count = 0;
	my $msg_type = 0;
	my $mcc_ready = 0;
	my $mnc_ready = 0;
	my $valid_cell_info = 0;
    #按行读取数据文件all.msgd中的数据
    while ($line_read = <$fh_msg_data>) 
    {
    	if (AllDataProcessed("ALL_INTERNAL_MSG"))
    	{
    		last;
    	}
    	
    	if ($line_read =~ /.*\s+MSG_ID_UL_DCCH_MSG_TYPE\s+.*/)
    	{
    		$msg_type = 0;
    	}
    	elsif ($line_read =~ /.*\s+MAC_SUBHEADER_DL_MSG\s+.*/)
    	{
    		$msg_type = 1;
    	}
    	elsif ($line_read =~ /.*\s+MSG_ID_GMMREG_REGN_STAT_IND\s+.*/)
    	{
    		$msg_type = 2;
    		
    		$valid_cell_info = 0;
    		$mcc_ready = 0;
    		$mnc_ready = 0;
    	}
    	
    	if ($msg_type == 0 and !exists $result_value_map{'multi-ta'} and $line_read =~ /.*\s+multipleTimingAdvance_r11Opt\s+0x1\s+.*/)    
        {
        	$result_value_map{'multi-ta'} = "1";
        	$capability_extract_count_map{"ALL_INTERNAL_MSG"}++;
        }
        
        if ($msg_type == 1 and !exists $result_value_map{'long-drx'} and $line_read =~ /.*\s+LCID\s+0x1a\s+.*/)    
        {
        	$result_value_map{'long-drx'} = "1";
        	$capability_extract_count_map{"ALL_INTERNAL_MSG"}++;
        }
        
        if ($msg_type == 2 and !exists $result_value_map{'mcc-mnc'})
        {
        	if ($line_read =~ /.*\s+serv_type\s+(\S+)\n/)
        	{
        		if ($1 eq "GMMREG_FULL_SERVICE") #注网成功
        		{
        			$valid_cell_info = 1;
        		}
        	}
        	
        	if ($valid_cell_info != 1)
        	{
        		next;
        	}
        	
        	if ($line_read =~ /.*\s+mcc(\d)\s+0x(\S+)\n/)
        	{
        		$mcc[$1 - 1] = $2;
        		$mcc_ready = IsArryAllFilled(\@mcc, 3);
        	}
        	
        	if ($line_read =~ /.*\s+mnc(\d)\s+0x(\S+)\n/)
        	{
        		$mnc[$1 - 1] = $2;
        		$mnc_ready = IsArryAllFilled(\@mnc, 3);
        	}
        	
			if ($mcc_ready and $mnc_ready)
			{
				ForamtMCCMNC();
				$result_value_map{'mcc-mnc'} = "1";
        		$capability_extract_count_map{"ALL_INTERNAL_MSG"}++;
			}
        }
    }
}

sub IsArryAllFilled
{
	my $arr = $_[0];
	my $len = $_[1];

	for (; $len-- >= 0;)
	{
		if ($$arr[$len] eq "")
		{
			return 0;
		}
	}
	
	return 1;
}

sub ProcessTraceData
{
	binmode($fh_trace_data);

	my $buff;
	my $list_len;
	my $remain = "";
	my $buff_len;
	my $last_char;
	
	$trace_line_cnt = 0;
	while (read($fh_trace_data, $buff, 40960))
	{
		$buff_len = length($buff);
		$last_char = substr($buff, $buff_len - 1, 1);

		@trace_lines = split(/\0/, $buff);
		$list_len = scalar @trace_lines;
		
		if ($remain ne "")
		{
			$trace_lines[0] = $remain.$trace_lines[0];
		}

		if ($last_char eq "\0")
		{
			$remain = "";
		} 
		else
		{
			$remain = $trace_lines[$list_len - 1];
			pop @trace_lines;
		}
		
		FilterTraceData();
		
		$trace_line_cnt += scalar @trace_lines;
	}
}

sub FilterTraceData
{
	my $sub_count = 0;
	foreach my $line (@trace_lines)
	{
		if (!exists $result_value_map{'bsrvcc'})
    	{
			if ($line =~ /.*g.3gpp.ps2cs-srvcc-orig-pre-alerting.*/)
			{
				$result_value_map{'bsrvcc'} = "1";
			}
    	}

    	if (!exists $result_value_map{'asrvcc'})
    	{
			if ($line =~ /.*g.3gpp.srvcc-alerting.*/)
			{
				$result_value_map{'asrvcc'} = "1";
			}
    	}
    	
    	if (!exists $result_value_map{'dc'})
    	{
			if ($line =~ /.*DC\sdebug:DC\senable\/disable\s(\d).*/)
			{
				$result_value_map{'dc'} = $1;
				$result_value_map{'non-dc'} = $1 eq "1" ? "0" : "1";
			}
    	}
    	
    	if (!exists $result_value_map{'w-type3i'})
    	{
    		if ($line =~ /.*Alloc_Cell:\scell_id\s？=\s？(\d+).*/)
			{
				$result_value_map{'w-type3i'} = ($1 eq "8" || $1 eq "9") ? "1" : "0";
			}
    	}
    	
    	if (!exists $result_value_map{'vamos'})
    	{
    		if ($line =~ /.*RR:\s?vamos\slevel\s(\d).*/)
			{
				$result_value_map{'vamos'} = $1 eq "1" ? "1" : "0";
			}
    	}
    	
    	if (!exists $result_value_map{'bss_paging_coor'})
    	{
    		if ($line =~ /.*RRC:\s?Si13\sarfcn\s?=\s?\d+,\s?bsic\s?=\s?\d+,\s?bss_pag_coord\s?=\s?(\d+).*/)
			{
				$result_value_map{'bss_paging_coor'} = $1 eq "1" ? "1" : "0";
			}
    	}
    	
    	if (!exists $result_value_map{'amr-wb'})
    	{
    		if ($line =~ /.*checkrate.*/i || $line =~ /.*Current\sSpeechRate\sof\sWB\sis.*/i || $line =~ /.*gWBVoiceData:.*/i || $line =~ /.*AMR\sWB\suplink\srate.*/i)
			{
				if (Is3G($sub_count))
				{
					$result_value_map{'amr-wb'} = "1";
				}
			}
    	}
    	
    	$sub_count++;
	}
}

sub ProcessAirMsgData
{
	my $line_count = 0;
    #按行读取数据文件all.aird中的数据
    while ($line_read = <$fh_air_data>) 
    {
        #1005349-1   	14:14:18.086	--  	LTE		<- SYSTEMINFORMATIONBLOCKTYPE1		0:05:34.547
        #1005350-1   	14:14:18.086	--  	LTE		-> [0]INVITE                 		0:05:34.547
        if ($line_read =~ /\d*-\d*\s*(\d*:\d*:\d*\.\d*).*(<-|->) (\[\d\])?([\w|-]+)\s*\d*:\d*:\d*\.\d*\s*/)
        {
            $CurASName = $4;
            $Time = "\'".$1;
            
            # 按空口消息名称做相应处理
			if ($CurASName eq "SYSTEMINFORMATIONBLOCKTYPE1")
            {
            	if (AllDataProcessed("SYSTEMINFORMATIONBLOCKTYPE1"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	
            	if (!exists $result_value_map{'freq-band-indicator'})
            	{
            		ProcessFreqBandIndicator();
            	}
            	
            	if (!exists $result_value_map{'e-mfbi'})
            	{
            		ProcessEMFBI();
            	}
            	
            	if (!exists $result_value_map{'csg'})
            	{
            		ProcessCSG();
            	}
            	
            	if (!exists $result_value_map{'meas-wb-rsrq-sib1'})
            	{
            		ProcessMeasWBRSRQ_Sib1();
            	}
            }
            elsif ($CurASName eq "SYSTEMINFORMATION")
            {
            	if (AllDataProcessed("SYSTEMINFORMATION"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	#if (!exists $result_value_map{'ul-64qam'} || !exists $result_value_map{'w-erach'} 
            	#	|| !exists $result_value_map{'e-mfbi'} || !exists $result_value_map{'cbs'} } 
            	#	|| !exists $result_value_map{'e-fach' || !exists $result_value_map{'e-pch'}
            	#   || !exists $result_value_map{'etws' || !exists $result_value_map{'cmas'})
            	{
	            	my @sibs = split(/\n\s{16}sib/, $CurPeerData);
					for (my $i = 0; $i < scalar(@sibs); $i++)
					{
						if ($sibs[$i] =~ /^(\d+).*/)
						{
							ProcessSIBs($1, $sibs[$i]);
						}
					}
            	}
            	
            	if (!exists $result_value_map{'inc-mon'})
            	{
            		ProcessIncMon();
            	}
            }
            elsif ($CurASName eq "SYSTEM_INFORMATION_TYPE2")
            {
            	if (AllDataProcessed("SYSTEM_INFORMATION_TYPE2"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	
            	if (!exists $result_value_map{'scm'})
            	{
            		ProcessSCM();
            	}
            }
            elsif ($CurASName eq "RRCCONNECTIONSETUP")
            {
            	if (AllDataProcessed("RRCCONNECTIONSETUP"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	
            	if (!exists $result_value_map{'tti-bundling'})
            	{
            		ProcessTTIBundling();
            	}
            }
            elsif ($CurASName eq "RRCCONNECTIONRECONFIGURATION")
            {
            	if (AllDataProcessed("RRCCONNECTIONRECONFIGURATION"))
            	{
            		next;
            	}
            	
            	GetPeerData();

            	if (!exists $result_value_map{'tti-bundling'})
            	{
            		ProcessTTIBundling();
            	}

            	if (!exists $result_value_map{'dl-carrier-freq'})
            	{
            		ProcessDlCarrierFreqR10();
            	}

            	if (!exists $result_value_map{'ul-comp'})
            	{
            		ProcessUlComp();
            	}

            	if (!exists $result_value_map{'multi-ack'})
            	{
            		ProcessMultiACK();
            	}

            	if (!exists $result_value_map{'dl-ca'})
            	{
            		ProcessDLCA();
            	}

            	if (!exists $result_value_map{'ul-ca'})
            	{
            		ProcessULCA();
            	}

            	if (!exists $result_value_map{'srvcc-drx-cdrx'})
            	{
            		ProcessSRVCC_DRX_CDRX();
            	}
            	
            	if (!exists $result_value_map{'anr'})
            	{
            		ProcessANR();
            	}
            	
            	if (!exists $result_value_map{'cgi'})
            	{
            		ProcessCGI();
            	}

            	if (!exists $result_value_map{'timer-t312-r12'})
            	{
            		ProcessTimerT312();
            	}
            	
            	if (!exists $result_value_map{'lcsr-prohibit-r12'})
            	{
            		ProcessLCSR_Prohibit();
            	}
            	
            	if (!exists $result_value_map{'mdt'})
            	{
            		ProcessIncludeLocation();
            	}
            	
            	if (!exists $result_value_map{'meas-wb-rsrq-conn'})
            	{
            		ProcessMeasWBRSRQ_Connect();
            	}
            	
            }
            elsif ($CurASName eq "UEINFORMATIONREQUEST-R9")
            {
            	if (AllDataProcessed("UEINFORMATIONREQUEST-R9"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	if (!exists $result_value_map{'mdt'})
            	{
            		ProcessUEInfoReq();
            	}
            }
            elsif ($CurASName eq "RRCCONNECTIONREESTABLISHMENT")
            {
            	GetPeerData();
            }
            elsif ($CurASName eq "MBMSIMTERESTINDICATION-R11")
            {
            	if (AllDataProcessed("MBMSIMTERESTINDICATION-R11"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	
            	if (!exists $result_value_map{'embms'})
            	{
            		ProcessEMBMS();
            	}
            }
            elsif ($CurASName eq "INVITE")
            {
            	if (!exists $result_value_map{'volte'})
            	{
            		$result_value_map{'volte-invite'} = "1";
            		ProcessVoLTE();
            	}
            }
            elsif ($CurASName eq "ACK")
            {
            	if (!exists $result_value_map{'volte'})
            	{
            		$result_value_map{'volte-ack'} = "1";
            		ProcessVoLTE();
            	}
            }
            elsif ($CurASName eq "BYE")
            {
            	if (!exists $result_value_map{'volte'})
            	{
            		$result_value_map{'volte-bye'} = "1";
            		ProcessVoLTE();
            	}
            }
            elsif ($CurASName eq "RADIOBEARERSETUP")
            {
            	if (AllDataProcessed("RADIOBEARERSETUP"))
            	{
            		next;
            	}

            	GetPeerData();
            	
            	if (!exists $result_value_map{'w-db'})
            	{
            		ProcessWDB();
            	}

            	if (!exists $result_value_map{'hsdpa'} || !exists $result_value_map{'hsupa'})
            	{
            		ProcessHsdpaHsupa();
            	}
            	
            	if (!exists $result_value_map{'cpc'})
            	{
            		ProcessCPC();
            	}
            }
            elsif ($CurASName eq "RADIOBEARERRECONFIGURATION")
            {
            	GetPeerData();

            	if (!exists $result_value_map{'hsdpa'} || !exists $result_value_map{'hsupa'})
            	{
            		ProcessHsdpaHsupa();
            	}
            }
            elsif ($CurASName eq "SECURITYMODECOMMAND")
            {
            	GetPeerData();
            	if (!exists $result_value_map{'umts-cipher'})
            	{
            		ProcessUMTSCipher();
            	}
            }
            elsif ($CurASName eq "AUTHENTICATION_AND_CIPHERING_REQ")
            {
            	GetPeerData();
            	if (!exists $result_value_map{'gprs-algo'})
            	{
            		ProcessGPRSEncryptionAlgo();
            	}
            }
            elsif ($CurASName eq "CIPHERING_MODE_COMMAND")
            {
            	GetPeerData();
            	if (!exists $result_value_map{'gsm-algo'})
            	{
            		ProcessGSMCipherAlgo();
            	}
            }
            elsif ($CurASName eq "MEASUREMENTREPORT")
            {
            	if (AllDataProcessed("MEASUREMENTREPORT"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	
            	if (!exists $result_value_map{'mdt'})
            	{
            		ProcessEllipsoidPoint();
            	}
            	
            	if (!exists $result_value_map{'meas-r12-extended-rsrq'})
            	{
            		ProcessMeasExtendedRSRQ();
            	}
            }
            elsif ($CurASName eq "PAGING")
            {
            	if (AllDataProcessed("PAGING"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	if (!exists($result_value_map{'etws-cmas'}))
            	{
            		if (!exists $result_value_map{'etws'})
            		{
            			ProcessETWS();
            		}
            		
            		if (!exists $result_value_map{'cmas'})
            		{
            			ProcessCMAS();
            		}
            	}
            }
            elsif ($CurASName eq "SIB2")
            {
            	if (AllDataProcessed("SIB2"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	if (!exists($result_value_map{'ul-64qam'}))
            	{
            		ProcessSIB_2($CurPeerData);
            	}
            }
            elsif ($CurASName eq "SIB3")
            {
            	if (AllDataProcessed("SIB3"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	if (!exists($result_value_map{'meas-wb-rsrq-sib3'}))
            	{
            		ProcessSIB_3($CurPeerData);
            	}
            }
            elsif ($CurASName eq "SIB5")
            {
            	if (AllDataProcessed("SIB5"))
            	{
            		next;
            	}
            	
            	GetPeerData();
            	if (!exists($result_value_map{'cbs'}))
            	{
            		ProcessSIB_5($CurPeerData);
            	}
            	
            	if (!exists($result_value_map{'e-fach'}))
            	{
            		ProcessSIB_5($CurPeerData);
            	}
            	
            	if (!exists($result_value_map{'e-pch'}))
            	{
            		ProcessSIB_5($CurPeerData);
            	}
            }
            else
            {
            	next;
            }
        }       
    }
    
    ProcessNonCA();
    ProcessMultiCA();
}

sub ExportData2CSV
{
	if ($fh_result)
	{
		ExportHeader2CSV();
	}
	my $count = keys %result_value_map;
	
}

sub AllDataProcessed
{
	my $airMsg = $_[0];
	my $allCapabilitiesCount = $capability_count_map{$airMsg};
	my $capabilitiesExtractedCount = $capability_extract_count_map{$airMsg};
	
	return $allCapabilitiesCount == $capabilitiesExtractedCount;
}

sub ProcessTTIBundling
{
	# ttiBundling     FALSE
	if ($CurPeerData =~ /.*\s+ttiBundling.*/s)
	{
		$result_value_map{'tti-bundling'} = '1';
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
		$capability_extract_count_map{"RRCCONNECTIONSETUP"}++;
	}
}

sub ProcessFreqBandIndicator
{
	# freqBandIndicator     38
	if ($CurPeerData =~ /.*\s+freqBandIndicator\s+(\S+).*/s)
	{
		$result_value_map{'freq-band-indicator'} = $1;
		$capability_extract_count_map{"SYSTEMINFORMATIONBLOCKTYPE1"}++;
		if (exists $result_value_map{'dl-carrier-freq'})
		{
			ProcessJointCA();
		}
	}
}

sub ProcessEMFBI
{
	if ($CurPeerData =~ /.*\s+freqBandIndicatorPriority-r12\s+(\S+).*/s)
	{
		$result_value_map{'e-mfbi'} = $1;
		$capability_extract_count_map{"SYSTEMINFORMATIONBLOCKTYPE1"}++;
	}
}

sub ProcessCSG
{
	if ($CurPeerData =~ /.*\s+csg-Indication\s+TRUE.*/s and $CurPeerData =~ /.*\s+csg-Identity.*/s)
	{
		$result_value_map{'csg'} = $1;
		$capability_extract_count_map{"SYSTEMINFORMATIONBLOCKTYPE1"}++;
	}
}

sub ProcessMeasWBRSRQ_Sib1
{
	if ($CurPeerData =~ /.*\s+q-QualMinWB-r11\s+.*/s)
	{
		$result_value_map{'meas-wb-rsrq-sib1'} = $1;
		$capability_extract_count_map{"SYSTEMINFORMATIONBLOCKTYPE1"}++;
	}
}

sub ProcessMeasWBRSRQ_Connect
{
	if ($CurPeerData =~ /.*\s+widebandRSRQ-Meas-r11\s+.*/s)
	{
		$result_value_map{'meas-wb-rsrq-conn'} = $1;
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}
}

sub ProcessSIBs
{
	my $sib_type = $_[0];
	my $sib_str = $_[1];
	
	if ($sib_type eq "2") { ProcessSysInfoSIB_2($sib_str); }
	elsif ($sib_type eq "3") { ProcessSysInfoSIB_3($sib_str); }
	elsif ($sib_type eq "5") { ProcessSysInfoSIB_5($sib_str); }
}

sub ProcessSysInfoSIB_2
{
	my $data = $_[0];
	
	if (!exists $result_value_map{'ul-64qam'})
	{
		if ($data =~ /.*\s+enable64QAM\s+TRUE.*/s)
		{
			$result_value_map{'ul-64qam'} = "1";
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
			$capability_extract_count_map{"SIB2"}++;
		}
	}
}

sub ProcessSysInfoSIB_3
{
	my $data = $_[0];
	
	if (!exists $result_value_map{'meas-wb-rsrq-sib3'})
	{
		if ($CurPeerData =~ /.*\s+q-QualMinWB-r11\s+.*/s)
		{
			$result_value_map{'meas-wb-rsrq-sib3'} = "1";
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
			$capability_extract_count_map{"SIB3"}++;
		}
	}
}

sub ProcessSysInfoSIB_5
{
	my $data = $_[0];
	if (!exists $result_value_map{'w-erach'})
	{
		if ($data =~ /.*\s+commomEDCHSystemInfo\s+.*/s)
		{
			$result_value_map{'w-erach'} = "1";
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
		}
	}
	
	if (!exists $result_value_map{'cbs'})
	{
		if ($data =~ /.*\s+cbs.*/s)
		{
			$result_value_map{'cbs'} = "1";
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
			$capability_extract_count_map{"SIB5"}++;
		}
	}
	
	if (!exists $result_value_map{'e-fach'})
	{
		if ($data =~ /.*\s+hs-dsch-CommonSystemInformation\s+.*/s)
		{
			$result_value_map{'e-fach'} = "1";
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
			$capability_extract_count_map{"SIB5"}++;
		}
	}
	
	if (!exists $result_value_map{'e-pch'})
	{
		if ($data =~ /.*\s+commonEDCHSystemInfoFDD\s+.*/s)
		{
			$result_value_map{'e-pch'} = "1";
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
			$capability_extract_count_map{"SIB5"}++;
		}
	}
	
	if (!exists $result_value_map{'meas-wb-rsrq-sib5'})
	{
		if ($CurPeerData =~ /.*\s+q-QualMinWB-r11\s+.*/s)
		{
			$result_value_map{'meas-wb-rsrq-sib5'} = "1";
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
		}
	}
}

sub ProcessSIB_2
{
	my $data = $_[0];
	
	if (!exists $result_value_map{'ul-64qam'})
	{
		if ($data =~ /.*\s+enable64QAM\s+TRUE.*/s)
		{
			$result_value_map{'ul-64qam'} = "1";
			$capability_extract_count_map{"SIB2"}++;
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
		}
	}
}

sub ProcessSIB_3
{
	my $data = $_[0];
	
	if (!exists $result_value_map{'meas-wb-rsrq-sib3'})
	{
		if ($CurPeerData =~ /.*\s+q-QualMinWB-r11\s+.*/s)
		{
			$result_value_map{'meas-wb-rsrq-sib3'} = "1";
			$capability_extract_count_map{"SIB3"}++;
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
		}
	}
}

sub ProcessSIB_5
{
	my $data = $_[0];
	if (!exists $result_value_map{'cbs'})
	{
		if ($data =~ /.*\s+cbs.*/s)
		{
			$result_value_map{'cbs'} = "1";
			$capability_extract_count_map{"SIB5"}++;
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
		}
	}
	
	if (!exists $result_value_map{'e-fach'})
	{
		if ($data =~ /.*\s+hs-dsch-CommonSystemInformation\s+.*/s)
		{
			$result_value_map{'e-fach'} = "1";
			$capability_extract_count_map{"SIB5"}++;
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
		}
	}
	
	if (!exists $result_value_map{'e-pch'})
	{
		if ($data =~ /.*\s+commonEDCHSystemInfoFDD\s+.*/s)
		{
			$result_value_map{'e-pch'} = "1";
			$capability_extract_count_map{"SIB5"}++;
			$capability_extract_count_map{"SYSTEMINFORMATION"}++;
		}
	}
}

sub ProcessIncMon
{
	if (!ProcessInterFreq())
	{
		ProcessIntraFreq();
	}
}

sub ProcessInterFreq
{
	if ($CurPeerData =~ /.*\s+interFreqCarrierFreqListExt-r12\s+.*/s and $CurPeerData =~ /.*\s+reducedMeasPerformance-r12\s+.*/s)
	{
		$result_value_map{'inc-mon'} = 1;
		$capability_extract_count_map{"SYSTEMINFORMATION"}++;
		return 1;
	}
	
	return 0;
}

sub ProcessIntraFreq
{
	if ($CurPeerData =~ /.*\s+measIdToAddModListExt-r12\s+.*/s and $CurPeerData =~ /.*\s+reduceMeasPerformance-r12\s+.*/s)
	{
		$result_value_map{'inc-mon'} = 1;
		$capability_extract_count_map{"SYSTEMINFORMATION"}++;
	}
}

sub ProcessDlCarrierFreqR10
{
	# dl-carrier-freq-r10     37900
	if ($CurPeerData =~ /.*\s+dl-CarrierFreq-r10\s+(\S+).*/s)
	{
		$result_value_map{'dl-carrier-freq'} = $1;
		if (exists $result_value_map{'freq-band-indicator'})
		{
			ProcessJointCA();
		}
	}
}

sub ProcessJointCA
{
	if (exists $result_value_map{'freq-band-indicator'} and exists $result_value_map{'dl-carrier-freq'})
	{
		my $band1 = $result_value_map{'freq-band-indicator'};
		my $band2 = GetBand($result_value_map{'dl-carrier-freq'});
		if ($band2 == -1)
		{
			WriteLog("Can not get band of dlCarrierFreq: $result_value_map{'dl-carrier-freq'}");
			$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
			return;
		}
		
		if ($band1 != $band2)
		{
			$result_value_map{'joint-ca'} = "1";
		}
		else
		{
			$result_value_map{'joint-ca'} = "0";
		}
		
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}
}

sub ProcessUlComp
{
	# pucch-ConfigDedicated-v1130    XXXX    setup
	if ($CurPeerData =~ /.*\s+pucch-ConfigDedicated-v1130\s+(.*?)\n\s{6,18}\S+/s)
	{
		if ($1 =~ /.*setup.*/s)
		{
			$result_value_map{'up-comp'} = "1";
			$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
		}
	}
	elsif ($CurPeerData =~ /.*\s+pusch-ConfigDedicated-v1130\s+(.*?)\n\s{6,18}\S+/s)
	{
		if ($1 =~ /.*setup.*/s)
		{
			$result_value_map{'up-comp'} = "1";
			$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
		}
	}
}

sub ProcessEMBMS
{
	# mbms-FreqList-r11     1575
	if ($CurPeerData =~ /.*\s+mbms-FreqList-r11\s+(\d+).*/s)
	{
		$result_value_map{'embms'} = "1";
		$capability_extract_count_map{"MBMSIMTERESTINDICATION-R11"}++;
	}
}

sub ProcessMultiACK
{
	if ($CurPeerData =~ /.*\s+format3-r10.*cqi-ReportPeriodic-r10.*simultaneousAckNackAndCQI-Format3-r11\s=\ssetup/s)
	{
		$result_value_map{'multi-ack'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}
}

sub ProcessSCM
{
	if ($CurPeerData =~ /\s+ac-BarringSkipMMTELVoice-r12\s+true/s)
	{
		$result_value_map{'scm'} = "1";
		$capability_extract_count_map{"SYSTEM_INFORMATION_TYPE2"}++;
	}
}

sub ProcessDLCA
{
	if ($CurPeerData =~ /.*\s+sCellToAddModList-r10\s+.*/s)
	{
		$result_value_map{'dl-ca'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}
}

sub ProcessULCA
{
	if ($CurPeerData =~ /.*\s+sCellToAddModList-r10\s+.*/s and $CurPeerData =~ /.*\s+uplinkPowerControlDedicatedScell_r10\s+.*/s)
	{
		$result_value_map{'ul-ca'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}
}

sub ProcessNonCA
{
	if (exists $result_value_map{'ul-ca'})
	{
		if ($result_value_map{'ul-ca'} eq "1" )
		{
			$result_value_map{'non-ca'} = "0";
			return;
		}
	}
	
	if (exists $result_value_map{'dl-ca'})
	{
		if ($result_value_map{'dl-ca'} eq "1")
		{
			$result_value_map{'non-ca'} = "0";
			return;
		}
	}
	
	$result_value_map{'non-ca'} = "1";
}

sub ProcessVoLTE
{
	if (exists $result_value_map{'volte-invite'} and exists $result_value_map{'volte-ack'} and exists $result_value_map{'volte-bye'})
	{
		$result_value_map{'volte'} = "1";
	}
}

sub ProcessSRVCC_DRX_CDRX
{
	if ($CurPeerData =~ /.*\s+drx-Config\s+.*/s)
	{
		$result_value_map{'srvcc-drx-cdrx'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}
}

sub ProcessANR
{
	if ($CurPeerData =~ /.*\s+reportCGI\s+.*/s)
	{
		$result_value_map{'anr'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}	
}

sub ProcessCGI
{
	if ($CurPeerData =~ /.*\s+sps-Config\s+.*/s)
	{
		$result_value_map{'cgi'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}
}

sub ProcessMultiCA
{
	$result_value_map{'multi-ca'} = "NA";
}

sub ProcessWDB
{
	if ($CurPeerData =~ /.*\s+dl_SecondaryCellInfoFDDOpt\s+0x(\d).*/s)
	{
		if ($1 eq "1" and $CurPeerData =~ /.*\s+uarfcn_DL\s+(0x\S+)\s+.*/s)
		{
			$result_value_map{'w-db'} = IsWFreq(hex($1));
			$capability_extract_count_map{"RADIOBEARERSETUP"}++;
		}
	}
}

sub ProcessHsdpaHsupa
{
	if ($CurPeerData =~ /.*\s+(dl_InformationPerRL_List.*)/s)
	{
		my $tail = $1;
		if ($tail =~ /dl_InformationPerRL_List\s+0x\d\s+(.*?)\n\s{6,24}\S+/s || $tail =~ /dl_InformationPerRL_List\s+0x\d\s+(.*)/s)
		{
			my $list = $1;
			if ($list =~ /.*\s+servingHSDSCH_RL_indicator\s+0x1.*/s)
			{
				$result_value_map{'hsdpa'} = "1";
				$capability_extract_count_map{"RADIOBEARERSETUP"}++;
			}
			
			if ($list =~ /.*\s+servingEDCH_RL_indicator\s+0x1.*/s)
			{
				$result_value_map{'hsupa'} = "1";
				$capability_extract_count_map{"RADIOBEARERSETUP"}++;
			}
		}
	}
}

sub ProcessCPC
{
	if ($CurPeerData =~ /.*\s+dtx-drx-Info\s+.*/s)
	{
		$result_value_map{'cpc'} = "1";
		$capability_extract_count_map{"RADIOBEARERSETUP"}++;
	}
}

sub ProcessUMTSCipher
{
	if ($CurPeerData =~ /.*\s+startRestart\s+CipheringAlgorithm_(\S+)\s+.*/s)
	{
		$result_value_map{'umts-cipher'} = $1;
	}
}

sub ProcessGPRSEncryptionAlgo
{
	if ($CurPeerData =~ /.*\s+ciphering_algo\s+(\S+)\s+.*/s)
	{
		$result_value_map{'gprs-algo'} = $1;
	}
}

sub ProcessGSMCipherAlgo
{
	if ($CurPeerData =~ /.*\s+algorithm_identifire\s+(\S+)\s+.*/s)
	{
		$result_value_map{'gsm-algo'} = $1;
	}
}

sub ProcessMeasExtendedRSRQ
{
	if ($CurPeerData =~ /.*\s+measResultPCell\s+rsrpResult\s+\S+\s+rsrqResult\s+0\s+.*/s and $CurPeerData =~ /.*\s+measResult[P|S]Cell-v1250\s+-(\S+)\s+.*/s)
	{
		$result_value_map{'meas-r12-extended-rsrq'} = 1;
		$capability_extract_count_map{"MEASUREMENTREPORT"}++;
	}
}

sub ProcessETWS
{
	if ($CurPeerData =~ /.*\s+etws-Indication\s+(\S+)\s+.*/s)
	{
		if ($1 eq "true")
		{
			$result_value_map{'etws'} = "1";
			$capability_extract_count_map{"PAGING"}++;
			
			if (exists $result_value_map{'cmas'})
			{
				$result_value_map{'etws-cmas'} = "1";
			}
		}
		else
		{
			$result_value_map{'etws-cmas'} = "0";
		}
	}
}

sub ProcessCMAS
{
	if ($CurPeerData =~ /.*\s+cmas-Indication-r9\s+(\S+)\s+.*/s)
	{
		if ($1 eq "true")
		{
			$result_value_map{'cmas'} = "1";
			$capability_extract_count_map{"PAGING"}++;
			
			if (exists $result_value_map{'etws'})
			{
				$result_value_map{'etws-cmas'} = "1";
			}
		}
		else
		{
			$result_value_map{'etws-cmas'} = "0";
		}
	}
}

sub ProcessTimerT312
{
	if ($CurPeerData =~ /.*\s+t312-r12\s+.*/s)
	{
		$result_value_map{'timer-t312-r12'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}
}

sub ProcessLCSR_Prohibit
{
	if ($CurPeerData =~ /.*\s+logicalChannelSR-Prohibit-r12\s+(\S+)\s+.*/s)
	{
		$result_value_map{'lcsr-prohibit-r12'} = $1;
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
	}
}

sub ProcessIncludeLocation
{
	if ($CurPeerData =~ /.*\s+includeLocationInfo-r10\s+(\S+)\s+.*/s)
	{
		$result_value_map{'mdt'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
		$capability_extract_count_map{"MEASUREMENTREPORT"}++;
		$capability_extract_count_map{"UEINFORMATIONREQUEST-R9"}++;
	}
}

sub ProcessEllipsoidPoint
{
	if ($CurPeerData =~ /.*\s+ellipsoid-Point-r10\s+(\S+)\s+.*/s)
	{
		$result_value_map{'mdt'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
		$capability_extract_count_map{"MEASUREMENTREPORT"}++;
		$capability_extract_count_map{"UEINFORMATIONREQUEST-R9"}++;
	}
}

sub ProcessUEInfoReq
{
	if ($CurPeerData =~ /.*\s+ueInformationRequest.*/s)
	{
		$result_value_map{'mdt'} = "1";
		$capability_extract_count_map{"RRCCONNECTIONRECONFIGURATION"}++;
		$capability_extract_count_map{"MEASUREMENTREPORT"}++;
		$capability_extract_count_map{"UEINFORMATIONREQUEST-R9"}++;
	}
}

sub ForamtMCCMNC
{
	for (my $i = 0; $i < 3; $i++)
	{
		if ($mcc[$i] eq "f")
		{
			$mcc[$i] = "";
		}
		
		if ($mnc[$i] eq "f")
		{
			$mnc[$i] = "";
		}
	}
	
	my $v1 = join('', @mcc);
	my $v2 = join('', @mnc);

	$result_value_map{'mcc'} = "'$v1";
	$result_value_map{'mnc'} = "'$v2";
}

Prepare();
OpenFiles();
ProcessData();
CloseFiles();
Ending();

exit 0;