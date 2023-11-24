#!user/bin/perl -w
#use strict;
#use warnings;

if (scalar(@ARGV) != 3)
{
    die "[export.pl] param error, AirMsg export file(*.aird) and Output Folder must be specified!\n";
}

# 控制日志是否同时打印到文件以及屏幕
my $log_both = 0;

#接收bat文件传进来的参数
my $data_file   = ${ARGV[0]};            # 数据文件(.aird)路径
my $result_folder_path  = ${ARGV[1]};    # 导出文件夹路径
my $current_path = ${ARGV[2]};           # Perl脚本路径
my $result_file_prefix = "";

# 定义读写文件的句柄
my $fh_log;         #读取的日志文件句柄
my $fh_data;        #读取的数据文件句柄
my $fh_result;		#导出文件句柄（通过关键字在下列各实际文件句柄间切换）
my $fh_result_sys; 	#导出文件句柄
my $fh_result_srb;	#导出文件句柄
my $fh_result_drb;	#导出文件句柄
my $fh_result_mac;	#导出文件句柄
my $fh_result_phy;	#导出文件句柄
my $fh_result_meas;	#导出文件句柄

my $CurASName;          #当前空口消息中提取出的空口消息名称
my $CurPeerData = ""; 	#当前空口消息中提取出的Peer数据
my $CurLocalData = "";	#当前空口消息中提取出的Local数据
my $Time = 0;
my $line_read;
my $line_write;

#各消息对应数据首列的位移
my %offset_csv_column = ('MIB'=>0, 'SIB_1'=>3, 'SYSTEMINFORMATION'=>19, 'SIB_2'=>55, 'SIB_3'=>17, 'SIB_5'=>11, 'SIB_7'=>9, 'SRB_2'=>10, 'DRB_3'=>32, 'MAC'=>8, 'MEAS_OBJ_ID'=>6, 'MEAS_RPT_CFG'=>20);
#各导出文件的文件名区分后缀
my %result_file_suffix = ('SYS'=>'sys_lte.csv', 'SRB'=>'srb_lte.csv', 'DRB'=>'drb_lte.csv', 'MAC'=>'mac_lte.csv', 'PHY'=>'phy_lte.csv', 'MEAS'=>'meas_lte.csv');
#各导出文件的文件句柄哈希
my %result_file_handle_map = ();
#测量消息储存ReportConfig参数用
my %rpt_cfg_value_map = ();
#储存各SIB值
my %sib_value_map = ();

sub Prepare
{
	OpenLogFile();
	FormatResultFilePath();
	
	WriteLog("------------------- Start Export Wireless Network Parameters -------------------");

	my $i = 0;
	for($i = 0; $i < scalar(@ARGV); $i++)
	{
	    WriteLog("Input Param[$i]: ${ARGV[$i]}");
	}
}

# 根据数据文件确认导出文件名称前缀
sub FormatResultFilePath()
{
	if ($data_file =~ /.*\\(\w+).aird/)
	{
		$result_file_prefix = "$result_folder_path\\";
	}
	else
	{
		die "Data file must be specified as an exported air message file(.aird)!";
	}
}

sub OpenLogFile()
{
	open $fh_log, '+>>', "$current_path\\Statistics.log" or die "Can not open log file for reading:$!";
}

sub CloseLogFile()
{
	close $fh_log or die "Can not close log file: $!";
}

sub OpenFiles()
{
    open $fh_data,       	'<', $data_file or die "Can not open '$data_file' for reading: $!";    
    open $fh_result_sys,  	'>', $result_file_prefix.$result_file_suffix{"SYS"} or die "Can not open SYS file for writting: $!";
    open $fh_result_srb, 	'>', $result_file_prefix.$result_file_suffix{"SRB"} or die "Can not open SRB file for writting: $!";
    open $fh_result_drb,  	'>', $result_file_prefix.$result_file_suffix{"DRB"} or die "Can not open DRB file for writting: $!";
    open $fh_result_mac,  	'>', $result_file_prefix.$result_file_suffix{"MAC"} or die "Can not open MAC file for writting: $!";
    open $fh_result_phy,  	'>', $result_file_prefix.$result_file_suffix{"PHY"} or die "Can not open PHY file for writting: $!";
    open $fh_result_meas,  	'>', $result_file_prefix.$result_file_suffix{"MEAS"} or die "Can not open MEAS file for writting: $!";
    
    %result_file_handle_map = ('SYS'=>$fh_result_sys, 'SRB'=>$fh_result_srb, 'DRB'=>$fh_result_drb, 'MAC'=>$fh_result_mac, 'PHY'=>$fh_result_phy, 'MEAS'=>$fh_result_meas);

    WriteResultHeader();
}

sub CloseFiles()
{
    close $fh_data or die "Can not close '$data_file': $!";
    close $fh_result_sys, or die "Can not close SYS file: $!";
    close $fh_result_srb, or die "Can not close SRB file: $!";
    close $fh_result_drb, or die "Can not close DRB file: $!";
    close $fh_result_mac, or die "Can not close MAC file: $!";
    close $fh_result_phy, or die "Can not close PHY file: $!";
    close $fh_result_meas, or die "Can not close MEAS file: $!";
    
    CloseLogFile();
}

# 通过key选择待导出文件
sub SelectResultFile
{
	if (!exists($result_file_handle_map{$_[0]}))
	{
		WriteLog("Error: Exported file \"".$_[0]."\" not found!");
		return 0;
	}
	
	$fh_result = $result_file_handle_map{$_[0]};
	return 1;
}

sub WriteResultHeader
{
	print $fh_result_sys
	      # COMMON
		  "UE Time,phycellid"
		  # MIB
		  .",dl-Bandwidth(MIB),phich-Duration(MIB),phich-Resource(MIB)"
		  # SIB1
	      .",mcc(SIB1),mnc(SIB1),cellReservedForOperatorUse(SIB1),trackingAreaCode(SIB1),cellIdentity(SIB1),cellBarred(SIB1),intraFreqReselection(SIB1)"
	      .",csg-Indication(SIB1),q-RxLevMin(SIB1),p-Max(SIB1),freqBandIndicator(SIB1),si-Periodicity:sib-MappingInfo(SIB1),subframeAssignment(SIB1)"
	      .",specialSubframePatterns(SIB1),si-WindowLength(SIB1),systemInfoValueTag(SIB1)"
	      # SIB2
	      .",numberOfRA-Preambles(SIB2),sizeOfRA-PreamblesGroupA(SIB2),messageSizeGroupA(SIB2),messagePowerOffsetGroupB(SIB2),powerRampingStep(SIB2)"
	      .",preambleInitialReceivedTargetPower(SIB2),preambleTransMax(SIB2),ra-ResponseWindowSize(SIB2),mac-ContentionResolutionTimer(SIB2),maxHARQ-Msg3Tx(SIB2)"
	      .",modificationPeriodCoeff(SIB2),defaultPagingCycle(SIB2),nB(SIB2),rootSequenceIndex(SIB2),prach-ConfigIndex(SIB2),highSpeedFlag(SIB2)"
	      .",zeroCorrelationZoneConfig(SIB2),prach-FreqOffset(SIB2),referenceSignalPower(SIB2),p-b(SIB2),n-SB(SIB2),hoppingMode(SIB2),pusch-HoppingOffset(SIB2)"
	      .",enable64QAM(SIB2),groupHoppingEnabled(SIB2),groupAssignmentPUSCH(SIB2),sequenceHoppingEnabled(SIB2),cyclicShift(SIB2),deltaPUCCH-Shift(SIB2)"
	      .",nRB-CQI(SIB2),nCS-AN(SIB2),n1PUCCH-AN(SIB2),srs-BandwidthConfig(SIB2),srs-SubframeConfig(SIB2),ackNackSRS-SimultaneousTransmission(SIB2)"
	      .",srs-MaxUpPts(SIB2),p0-NominalPUSCH(SIB2),alpha(SIB2),p0-NominalPUCCH(SIB2),deltaF-PUCCH-Format1(SIB2),deltaF-PUCCH-Format1b(SIB2),deltaF-PUCCH-Format2(SIB2)"
	      .",deltaF-PUCCH-Format2a(SIB2),deltaF-PUCCH-Format2b(SIB2),deltaPreambleMsg3(SIB2),ul-CyclicPrefixLength(SIB2),enable64QAM-v1270(SIB2),t300(SIB2)"
	      .",t301(SIB2),t310(SIB2),n310(SIB2),t311(SIB2),n311(SIB2),additionalSpectrumEmission(SIB2),timeAlignmentTimerCommon(SIB2)"
	      # SIB3
	      .",q-Hyst(SIB3),s-NonIntraSearch(SIB3),threshServingLow(SIB3),cellReselectionPriority(SIB3),q-RxLevMin(SIB3),p-Max(SIB3),s-IntraSearch(SIB3)"
	      .",presenceAntennaPort1(SIB3),neighCellConfig(SIB3),t-ReselectionEUTRA(SIB3),sf-Medium(SIB3),sf-High(SIB3),s-IntraSearchP-r9(SIB3),s-IntraSearchQ-r9(SIB3)"
	      .",s-NonIntraSearchP-r9(SIB3),s-NonIntraSearchQ-r9(SIB3),q-QualMin-r9(SIB3),dl-CarrierFreq(SIB5)"
	      # SIB5
	      .",q-RxLevMin(SIB5),t-ReselectionEUTRA(SIB5),threshX-High(SIB5),threshX-Low(SIB5),allowedMeasBandwidth(SIB5),presenceAntennaPort1(SIB5)"
	      .",cellReselectionPriority(SIB5),neighCellConfig(SIB5),q-OffsetFreq(SIB5),multiBandInfoList(SIB5)"
	      # SIB7
	      .",t-ReselectionGERAN(SIB7),startingARFCN(SIB7),bandIndicator(SIB7),explicitListOfARFCNs(SIB7),cellReselectionPriority(SIB7),ncc-Permitted(SIB7)"
	      .",q-RxLevMin(SIB7),threshX-High(SIB7),threshX-Low(SIB7)"
	      ."\n";
	      
	print $fh_result_srb
			# COMMON
			"UE Time,phycellid,srb-Identity"
			# SIB1
			.",t-PollRetransmit(SRB1),pollPDU(SRB1),pollByte(SRB1),maxRetxThreshold(SRB1),t-Reordering(SRB1),t-StatusProhibit(SRB1)"
			.",priority(SRB1),prioritisedBitRate(SRB1),bucketSizeDuration(SRB1),logicalChannelGroup(SRB1)"
			# SIB2
			.",t-PollRetransmit(SRB2),pollPDU(SRB2),pollByte(SRB2),maxRetxThreshold(SRB2),t-Reordering(SRB2),t-StatusProhibit(SRB2)"
			.",priority(SRB2),prioritisedBitRate(SRB2),bucketSizeDuration(SRB2),logicalChannelGroup(SRB2)"
			."\n";
			
	print $fh_result_drb
			# COMMON
			"UE Time,phycellid"
			# DRB1
			.",eps-BearerIdentity(DRB1),drb-Identity(DRB1),discardTimer(DRB1),statusReportRequired(DRB1),headerCompression(DRB1),t-PollRetransmit(DRB1)"
			.",pollPDU(DRB1),pollByte(DRB1),maxRetxThreshold(DRB1),t-Reordering(DRB1),t-StatusProhibit(DRB1),logicalChannelIdentity(DRB1),priority(DRB1)"
			.",prioritisedBitRate(DRB1),bucketSizeDuration(DRB1),logicalChannelGroup(DRB1)"
			# DRB2
			.",eps-BearerIdentity(DRB2),drb-Identity(DRB2),discardTimer(DRB2),statusReportRequired(DRB2),headerCompression(DRB2),t-PollRetransmit(DRB2),pollPDU(DRB2)"
			.",pollByte(DRB2),maxRetxThreshold(DRB2),t-Reordering(DRB2),t-StatusProhibit(DRB2),logicalChannelIdentity(DRB2)"
			.",priority(DRB2),prioritisedBitRate(DRB2),bucketSizeDuration(DRB2),logicalChannelGroup(DRB2)"
			# DRB3
			.",eps-BearerIdentity(DRB3),drb-Identity(DRB3),discardTimer(DRB3),pdcp-SN-Size(DRB3),maxCID(DRB3),profiles(DRB3),sn-FieldLength(DRB3-UL),sn-FieldLength(DRB3-DL)"
			.",t-Reordering(DRB3),logicalChannelIdentity(DRB3),priority(DRB3),prioritisedBitRate(DRB3),bucketSizeDuration(DRB3),logicalChannelGroup(DRB3)"
			."\n";
			
	print $fh_result_mac
			# COMMON
			"UE Time,phycellid"
			# RRCCONNECTIONSETUP
			.",maxHARQ-Tx,periodicBSR-Timer,retxBSR-Timer,ttiBundling,timeAlignmentTimerDedicated,periodicPHR-Timer,prohibitPHR-Timer,dl-PathlossChange"
			# RRCCONNECTIONRECONFIGURATION
			.",onDurationTimer,drx-InactivityTimer,drx-RetransmissionTimer,longDRX-CycleStartOffset,shortDRX-Cycle,drxShortCycleTimer"
			."\n";
			
	print $fh_result_phy
			# COMMON
			"UE Time,phycellid"
			# RRCCONNECTIONSETUP
			.",p-a(pdsch-Config),ackNackRepetition(pucch-Config),tdd-AckNackFeedbackMode(pucch-Config),betaOffset-ACK-Index(pusch-Config),betaOffset-RI-Index(pusch-Config)"
			.",betaOffset-CQI-Index(pusch-Config),p0-UE-PUSCH(uplinkPowerControl),deltaMCS-Enabled(uplinkPowerControl),accumulationEnabled(uplinkPowerControl)"
			.",p0-UE-PUCCH(uplinkPowerControl),pSRS-Offset(uplinkPowerControl),filterCoefficient(uplinkPowerControl),tpc-PDCCH-ConfigPUCCH,tpc-PDCCH-ConfigPUSCH"
			.",cqi-ReportModeAperiodic(cqi-ReportConfig),nomPDSCH-RS-EPRE-Offset(cqi-ReportConfig),cqi-PUCCH-ResourceIndex(cqi-ReportConfig)"
			.",cqi-pmi-ConfigIndex(cqi-ReportConfig),widebandCQI(cqi-ReportConfig),ri-ConfigIndex(cqi-ReportConfig),simultaneousAckNackAndCQI(cqi-ReportConfig)"
			.",srs-Bandwidth(soundingRS-UL),srs-HoppingBandwidth(soundingRS-UL),freqDomainPosition(soundingRS-UL),duration(soundingRS-UL),srs-ConfigIndex(soundingRS-UL)"
			.",transmissionComb(soundingRS-UL),cyclicShift(soundingRS-UL),transmissionMode(antennaInfo),codebookSubsetRestriction(antennaInfo)"
			.",ue-TransmitAntennaSelection(antennaInfo),sr-PUCCH-ResourceIndex(schedulingRequestConfig),sr-ConfigIndex(schedulingRequestConfig),dsr-TransMax(schedulingRequestConfig)"
			."\n";
			
	print $fh_result_meas
			# COMMON
			"UE Time,phycellid"
			# RRCCONNECTIONRECONFIGURATION
			.",measObjectId,carrierFreq(measObjectId 1),allowedMeasBandwidth(measObjectId 1),presenceAntennaPort1(measObjectId 1),neighCellConfig(measObjectId 1)"
			.",offsetFreq(measObjectId 1),reportConfigId,a3-Offset(A3),reportOnLeave(A3),hysteresis(A3),timeToTrigger(A3),triggerQuantity(A3),reportQuantity(A3)"
			.",maxReportCells(A3),reportInterval(A3),reportAmount(A3),reportConfigId(A2),threshold-RSRP(A2),threshold-RSRQ(A2),hysteresis(A2),timeToTrigger(A2),triggerQuantity(A2),reportQuantity(A2)"
			.",maxReportCells(A2),reportInterval(A2),reportAmount(A2),filterCoefficientRSRP(quantityConfigEUTRA),filterCoefficientRSRQ(quantityConfigEUTRA),s-Measure"
			."\n";
}

sub GetLocalData()
{
	# 把LocalData中数据拼接入字符串
    my $bLocalStart = 0;
    $CurLocalData = "";
    while ( $line_read = <$fh_data> )
    {
        if ($line_read =~ /\s*.*\[local_msg_start\]\s*.*/)
        {
            $bLocalStart = 1;    
        }
        elsif ($line_read =~ /\s*.*\[local_msg_end\]\s*.*/)
        {
            $line_read = "";
            last;                
        }
        elsif ($bLocalStart)
        {
            $CurLocalData .= $line_read;
        }
    }
}

sub GetPeerData()
{
    # 把PeerData中数据拼接入字符串
    my $bPeerStart = 0;
    $CurPeerData = "";
    while ( $line_read = <$fh_data> )
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

sub GetPhyCellID()
{
	if ($CurLocalData =~ /.*\s*phycellid\s+(\S+)\s*/s)
	{
		return $1;
	}
}

# 写单行数据到导出文件
# Param1：行内容； Param2：导出文件句柄key
sub WriteLineToResultFile
{
	if (SelectResultFile($_[1]))
	{
		print $fh_result "$_[0]\n";
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

# 增加CSV列
sub AppendCSVColumn
{
	my $value =	$_[0];
	$$value .= ",";
}

# 该空口消息对应输出数据首列位移
sub AppendOffset 
{
	my $line = \$_[0];
	my $offset = $offset_csv_column{$_[1]};
	if ($offset > 0)
	{
		until($offset-- == 0)
		{
			$$line .= ",";
		}
	}
}

# 取得通用列数据(Time, PhyCellID)
sub AppendCommData
{
	my $value =	\$_[0];
	
	$$value .= $Time;
	AppendCSVColumn($value);
	
	$$value .= GetPhyCellID();
	AppendCSVColumn($value);
}

sub InsertCommData
{
	my $value =	\$_[0];
	
	my $phy_cell_id = GetPhyCellID();
	$$value = "$Time,$phy_cell_id,$$value";
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

sub ProcessMIB
{
	my $value =	\$_[0];

	#dl-Bandwidth     n100
	if ($CurPeerData =~ /.*\s*dl-Bandwidth\s*([\da-z]+)/s)
	{
		$$value .= $1;
	}
	AppendCSVColumn($value);
	
	#phich-Config     phich-Duration     normal     phich-Resource     one
	if ($CurPeerData =~ /.*\s*phich-Config\s*phich-Duration\s*([a-z]+)\s*phich-Resource\s*([a-z]+)/s)
	{
		$$value .= "$1,$2";
	}
	AppendCSVColumn($value);
}

sub ProcessSIB_1
{
	my $value =	\$_[0];
	
	#plmn-IdentityList     plmn-Identity     mcc     4     6     0     mnc     0     0     cellReservedForOperatorUse
	if ($CurPeerData =~ /.*\s+plmn-Identity\s+mcc([\s\d]+)mnc([\s\d]+)cellReservedForOperatorUse\s+(\w+).*/s)
	{
		my $mcc = trim($1);
		my $mnc = trim($2);
		$cr  = $3;
		$mcc =~ s/\s+/;/sg;
		$mnc =~ s/\s+/;/sg;
		
		$$value .= "\"($mcc)\",\"($mnc)\",$cr"; 
	}
	AppendCSVColumn($value);
	
	#trackingAreaCode     '0001100011000010'B
	if ($CurPeerData =~ /.*\s+trackingAreaCode\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#cellIdentity     '0001100100010001000100000110'B
	if ($CurPeerData =~ /.*\s+cellIdentity\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#cellBarred     notBarred
	if ($CurPeerData =~ /.*\s+cellBarred\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#intraFreqReselection     allowed
	if ($CurPeerData =~ /.*\s+intraFreqReselection\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#csg-Indication     FALSE
	if ($CurPeerData =~ /.*\s+csg-Indication\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#q-RxLevMin     -62
	if ($CurPeerData =~ /.*\s+cellSelectionInfo\s+q-RxLevMin\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#p-Max     23
	if ($CurPeerData =~ /.*\s+p-Max\s+(\d+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#freqBandIndicator     38
	if ($CurPeerData =~ /.*\s+freqBandIndicator\s+(\d+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#schedulingInfoList     si-Periodicity     rf16     sib-MappingInfo     sibType3     si-Periodicity     rf64     sib-MappingInfo     sibType6     sibType7     tdd-Config
	if ($CurPeerData =~ /.*\s+schedulingInfoList\s+(.*?)\n\s{8}\S+/s || $CurPeerData =~ /.*\s+schedulingInfoList\s+(.*)/s )
	{
		$schedulingInfoList = trim($1);
		
		my @list = split(/si-Periodicity/, $schedulingInfoList);
		my $info = "";
		my $count = scalar(@list);
		my $combine = "";
		$combine .= "\"(";
		for(my $ind = 1; $ind < scalar(@list); $ind++)
		{
			#rf64     :     sibType6     sibType7
			$info = trim($list[$ind]);
			$info =~ s/sib-MappingInfo/:/;
			$info =~ s/\s+:/:/;
			$info =~ s/:\s+/:/;
			$info =~ s/\s+\s+/,/;
			
			if ($ind == scalar(@list) - 1)
			{
				$combine .= $info;
			}
			else 
			{
				$combine .= "$info; ";
			}
			
		}
		$combine .= ")\"";
		$$value .= $combine;
	}
	AppendCSVColumn($value);
	
	#subframeAssignment     sa2
	if ($CurPeerData =~ /.*\s+subframeAssignment\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#specialSubframePatterns     ssp7
	if ($CurPeerData =~ /.*\s+specialSubframePatterns\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#si-WindowLength     ms40
	if ($CurPeerData =~ /.*\s+si-WindowLength\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	#systemInfoValueTag     26
	if ($CurPeerData =~ /.*\s+systemInfoValueTag\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
}

sub ProcessOtherSIBs
{
	my $sib_type = $_[0];
	my $sib_str = $_[1];
	
	if ($sib_type eq "2") { ProcessSIB_2($sib_str); }
	elsif ($sib_type eq "3") { ProcessSIB_3($sib_str); }
	elsif ($sib_type eq "5") { ProcessSIB_5($sib_str); }
	elsif ($sib_type eq "7") { ProcessSIB_7($sib_str); }
}

sub ProcessSIB_2
{
	my $data = $_[0];
	my $value = "";
	
	# numberOfRA-Preambles     n52
	if ($data =~ /.*\s+numberOfRA-Preambles\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# sizeOfRA-PreamblesGroupA     n28
	if ($data =~ /.*\s+sizeOfRA-PreamblesGroupA\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# messageSizeGroupA     b56
	if ($data =~ /.*\s+messageSizeGroupA\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# messagePowerOffsetGroupB     dB10
	if ($data =~ /.*\s+messagePowerOffsetGroupB\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# powerRampingStep     dB2
	if ($data =~ /.*\s+powerRampingStep\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# preambleInitialReceivedTargetPower     dBm-104
	if ($data =~ /.*\s+preambleInitialReceivedTargetPower\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# preambleTransMax     n10
	if ($data =~ /.*\s+preambleTransMax\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# ra-ResponseWindowSize     sf10
	if ($data =~ /.*\s+ra-ResponseWindowSize\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# mac-ContentionResolutionTimer     sf64
	if ($data =~ /.*\s+mac-ContentionResolutionTimer\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# maxHARQ-Msg3Tx     5
	if ($data =~ /.*\s+maxHARQ-Msg3Tx\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# modificationPeriodCoeff     n2
	if ($data =~ /.*\s+modificationPeriodCoeff\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# defaultPagingCycle     rf128
	if ($data =~ /.*\s+defaultPagingCycle\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# nB     oneT
	if ($data =~ /.*\s+nB\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# rootSequenceIndex     754
	if ($data =~ /.*\s+rootSequenceIndex\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# prach-ConfigIndex     0
	if ($data =~ /.*\s+prach-ConfigIndex\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# highSpeedFlag     FALSE
	if ($data =~ /.*\s+highSpeedFlag\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# zeroCorrelationZoneConfig     5
	if ($data =~ /.*\s+zeroCorrelationZoneConfig\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# prach-FreqOffset     12
	if ($data =~ /.*\s+prach-FreqOffset\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# referenceSignalPower     15
	if ($data =~ /.*\s+referenceSignalPower\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# p-b     0
	if ($data =~ /.*\s+p-b\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# n-SB     4
	if ($data =~ /.*\s+n-SB\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# hoppingMode     interSubFrame
	if ($data =~ /.*\s+hoppingMode\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# pusch-HoppingOffset     22
	if ($data =~ /.*\s+pusch-HoppingOffset\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# enable64QAM     FALSE
	if ($data =~ /.*\s+enable64QAM\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# groupHoppingEnabled     FALSE
	if ($data =~ /.*\s+groupHoppingEnabled\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# groupAssignmentPUSCH     0
	if ($data =~ /.*\s+groupAssignmentPUSCH\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# sequenceHoppingEnabled     FALSE
	if ($data =~ /.*\s+sequenceHoppingEnabled\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# cyclicShift     0
	if ($data =~ /.*\s+cyclicShift\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# deltaPUCCH-Shift     ds1
	if ($data =~ /.*\s+deltaPUCCH-Shift\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# nRB-CQI     2
	if ($data =~ /.*\s+nRB-CQI\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# nCS-AN     0
	if ($data =~ /.*\s+nCS-AN\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# n1PUCCH-AN     36
	if ($data =~ /.*\s+n1PUCCH-AN\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# srs-BandwidthConfig     bw0
	if ($data =~ /.*\s+srs-BandwidthConfig\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# srs-SubframeConfig     sc0
	if ($data =~ /.*\s+srs-SubframeConfig\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# ackNackSRS-SimultaneousTransmission     TRUE
	if ($data =~ /.*\s+ackNackSRS-SimultaneousTransmission\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# srs-MaxUpPts     true
	if ($data =~ /.*\s+srs-MaxUpPts\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# p0-NominalPUSCH     -87
	if ($data =~ /.*\s+p0-NominalPUSCH\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# alpha     al08
	if ($data =~ /.*\s+alpha\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# p0-NominalPUCCH     -115
	if ($data =~ /.*\s+p0-NominalPUCCH\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# deltaF-PUCCH-Format1     deltaF0
	if ($data =~ /.*\s+deltaF-PUCCH-Format1\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# deltaF-PUCCH-Format1b     deltaF3
	if ($data =~ /.*\s+deltaF-PUCCH-Format1b\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# deltaF-PUCCH-Format2     deltaF1
	if ($data =~ /.*\s+deltaF-PUCCH-Format2\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# deltaF-PUCCH-Format2a     deltaF2
	if ($data =~ /.*\s+deltaF-PUCCH-Format2a\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# deltaF-PUCCH-Format2b     deltaF2
	if ($data =~ /.*\s+deltaF-PUCCH-Format2b\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
		
	# deltaPreambleMsg3     -1
	if ($data =~ /.*\s+deltaPreambleMsg3\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# ul-CyclicPrefixLength     len1
	if ($data =~ /.*\s+ul-CyclicPrefixLength\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
		
	# enable64QAM-v1270     true
	if ($data =~ /.*\s+enable64QAM-v1270\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# t300     ms1000
	if ($data =~ /.*\s+t300\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
		
	# t301     ms600
	if ($data =~ /.*\s+t301\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
			
	# t310     ms1000
	if ($data =~ /.*\s+t310\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
				
	# n310     n20
	if ($data =~ /.*\s+n310\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
					
	# t311     ms1000
	if ($data =~ /.*\s+t311\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
						
	# n311     n1
	if ($data =~ /.*\s+n311\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
							
	# additionalSpectrumEmission     1
	if ($data =~ /.*\s+additionalSpectrumEmission\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
								
	# timeAlignmentTimerCommon     infinity
	if ($data =~ /.*\s+timeAlignmentTimerCommon\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	$sib_value_map{'SIB2'} = $value;
}

sub ProcessSIB_3
{
	my $data = $_[0];
	my $value = "";

	# q-Hyst     dB4
	if ($data =~ /.*\s+q-Hyst\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# s-NonIntraSearch     12
	if ($data =~ /.*\s+s-NonIntraSearch\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
		
	# threshServingLow     0
	if ($data =~ /.*\s+threshServingLow\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
			
	# cellReselectionPriority     6
	if ($data =~ /.*\s+cellReselectionServingFreqInfo.+cellReselectionPriority\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
				
	# q-RxLevMin     -60
	if ($data =~ /.*\s+intraFreqCellReselectionInfo.+q-RxLevMin\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
					
	# p-Max     23
	if ($data =~ /.*\s+intraFreqCellReselectionInfo.+p-Max\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
						
	# s-IntraSearch     19
	if ($data =~ /.*\s+intraFreqCellReselectionInfo.+s-IntraSearch\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
							
	# presenceAntennaPort1     FALSE
	if ($data =~ /.*\s+intraFreqCellReselectionInfo.+presenceAntennaPort1\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
								
	# neighCellConfig     '01'B
	if ($data =~ /.*\s+intraFreqCellReselectionInfo.+neighCellConfig\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
									
	# t-ReselectionEUTRA     1
	if ($data =~ /.*\s+intraFreqCellReselectionInfo.+t-ReselectionEUTRA\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
										
	# sf-Medium     lDot0
	if ($data =~ /.*\s+intraFreqCellReselectionInfo.+sf-Medium\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
											
	# sf-High     oDot75
	if ($data =~ /.*\s+intraFreqCellReselectionInfo.+sf-High\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
												
	# s-IntraSearchP-r9     19
	if ($data =~ /.*\s+s-IntraSearchP-r9\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
													
	# s-IntraSearchQ-r9     5
	if ($data =~ /.*\s+s-IntraSearchQ-r9\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
														
	# s-NonIntraSearchP-r9     5
	if ($data =~ /.*\s+s-NonIntraSearchP-r9\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
															
	# s-NonIntraSearchQ-r9     4
	if ($data =~ /.*\s+s-NonIntraSearchQ-r9\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
																
	# q-QualMin-r9     -18
	if ($data =~ /.*\s+q-QualMin-r9\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	$sib_value_map{'SIB3'} = $value;
}

sub ProcessSIB_5
{
	my $data = $_[0];
	my $value = "";

	#interFreqCarrierFreqList     (dl-CarrierFreq     37900)[1,]     lateNonCriticalExtension
	if ($data =~ /5\s+interFreqCarrierFreqList\s+(.*)/s)
	{
		$interFreqCarrierFreqList = trim($1);

		my (@arr1, @arr2, @arr3, @arr4, @arr5, @arr6, @arr7, @arr8, @arr9, @arr10) = ((), (), (), (), (), (), (), (), (), ());
		while ($interFreqCarrierFreqList =~ /dl-CarrierFreq\s+(\S+)\s+q-RxLevMin\s+(\S+)\s+t-ReselectionEUTRA\s+(\S+)\s+threshX-High\s+(\S+)\s+threshX-Low\s+(\S+)\s+allowedMeasBandwidth\s+(\S+)\s+presenceAntennaPort1\s+(\S+)\s+cellReselectionPriority\s+(\S+)\s+neighCellConfig\s+(\S+)\s+q-OffsetFreq\s+(\S+)/mgs)
		{
			push @arr1, $1;
			push @arr2, $2;
			push @arr3, $3;
			push @arr4, $4;
			push @arr5, $5;
			push @arr6, $6;
			push @arr7, $7;
			push @arr8, $8;
			push @arr9, $9;
			push @arr10, $10;
		}
		
		my ($val1, $val2, $val3, $val4, $val5, $val6, $val7, $val8, $val9, $val10) = (join(';', @arr1), join(';', @arr2), join(';', @arr3), join(';', @arr4), join(';', @arr5), join(';', @arr6), join(';', @arr7), join(';', @arr8), join(';', @arr9), join(';', @arr10));
		$value .= "\"($val1)\",\"($val2)\",\"($val3)\",\"($val4)\",\"($val5)\",\"($val6)\",\"($val7)\",\"($val8)\",\"($val9)\",\"($val10)\",";
	}
	else
	{
		$value .= ",,,,,,,,,,";
	}
	
	# multiBandInfoList     1     2
	if ($data =~ /5.*\s+multiBandInfoList\s+([\d\s]+)\s+.*/s)
	{
		my $val = trim($1);
		if ($val =~ s/\s+/;/sg)
		{
			$value .= "\"($val)\""; 
		}
		else
		{
			$value .= "$val"; 
		}
	}
	AppendCSVColumn(\$value);
	
	$sib_value_map{'SIB5'} = $value;
}

sub ProcessSIB_7
{
	my $data = $_[0];
	my $value = "";
	
	# t-ReselectionGERAN     1
	if ($data =~ /.*\s+t-ReselectionGERAN\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
		
	# startingARFCN     512
	if ($data =~ /.*\s+startingARFCN\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
			
	# bandIndicator     dcs1800
	if ($data =~ /.*\s+bandIndicator\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
				
	# explicitListOfARFCNs     43     544     550     547     80     50
	if ($data =~ /.*\s+explicitListOfARFCNs\s+([\d\s]+)\s+(\w+).*/s)
	{
		my $val = trim($1);
		$val =~ s/\s+/;/sg;
		$value .= "\"($val)\""; 
	}
	AppendCSVColumn(\$value);
				
	# cellReselectionPriority     2
	if ($data =~ /.*\s+cellReselectionPriority\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
					
	# ncc-Permitted     '11111111'B
	if ($data =~ /.*\s+ncc-Permitted\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
		
	# q-RxLevMin     -62
	if ($data =~ /.*\s+q-RxLevMin\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
			
	# threshX-High     10
	if ($data =~ /.*\s+threshX-High\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	# threshX-Low     14
	if ($data =~ /.*\s+threshX-Low\s+(\S+).*/s)
	{
		$value .= "$1"; 
	}
	AppendCSVColumn(\$value);
	
	$sib_value_map{'SIB7'} = $value;
}

sub ProcessSRB
{
	my $srb = GetSRBData($CurPeerData);
	if ($srb eq "")
	{
		return 0;
	}

	my $value =	\$_[0];
	
	my $srb_type = "";
	# srb-Identity     1
	if ($srb =~ /srb-Identity\s+(\S+)/s)
	{
		$srb_type = $1; 
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	if ($srb_type eq "2")
	{
		AppendOffset($$value, "SRB_2");
	}
	
	# t-PollRetransmit     ms45
	if ($srb =~ /.*\s+t-PollRetransmit\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
		
	# pollPDU     pInfinity
	if ($srb =~ /.*\s+pollPDU\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
			
	# pollByte     kBinfinity
	if ($srb =~ /.*\s+pollByte\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
				
	# maxRetxThreshold     t32
	if ($srb =~ /.*\s+maxRetxThreshold\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
					
	# t-Reordering     ms35
	if ($srb =~ /.*\s+t-Reordering\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
						
	# t-StatusProhibit     ms0
	if ($srb =~ /.*\s+t-StatusProhibit\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
							
	# priority     3
	if ($srb =~ /.*\s+priority\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
								
	# prioritisedBitRate     infinity
	if ($srb =~ /.*\s+prioritisedBitRate\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
									
	# bucketSizeDuration     ms300
	if ($srb =~ /.*\s+bucketSizeDuration\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
										
	# logicalChannelGroup     0
	if ($srb =~ /.*\s+logicalChannelGroup\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	return 1;
}


sub ProcessDRB
{
	my $drbs = GetDRBData($CurPeerData);
	if ($drbs eq "")
	{
		return 0;
	}
	
	my $value =	\$_[0];

	my $skipchars = 0;
	my $drb_str = "";
	my ($start, $end, $next_start) = (-1, -1, -1);
	# 以“eps-BearerIdentity”分割块区域进行抽取
	while(($next_start = index($drbs, "eps-BearerIdentity", $skipchars)) != -1)
	{
		$end = $next_start;

		if ($start != -1 and $start < $end)
		{
			$drb_str = substr($drbs, $start, $end - $start);
			$skipchars = $next_start + length("eps-BearerIdentity");
			
			$start = $next_start;
			
			ProcessDRBBranches($drb_str, $value);
		}
		else
		{
			$start = $next_start;
			$skipchars = $next_start + length("eps-BearerIdentity");
		}
	}
	
	if ($start >= 0)
	{
		$drb_str = substr($drbs, $start, length($drbs) - $start);
		
		ProcessDRBBranches($drb_str, $value);
	}
	else
	{
		# 以“drb-Identity”分割块区域进行抽取
		($start, $end, $next_start) = (-1, -1, -1);
		while(($next_start = index($drbs, "drb-Identity", $skipchars)) != -1)
		{
			$end = $next_start;

			if ($start != -1 and $start < $end)
			{
				$drb_str = substr($drbs, $start, $end - $start);
				$skipchars = $next_start + length("drb-Identity");
				
				$start = $next_start;
				
				ProcessDRBBranches($drb_str, $value);
			}
			else
			{
				$start = $next_start;
				$skipchars = $next_start + length("drb-Identity");
			}
		}
		
		if ($start >= 0)
		{
			$drb_str = substr($drbs, $start, length($drbs) - $start);
			
			ProcessDRBBranches($drb_str, $value);
		}
	}

	return 1;
}

sub ProcessDRBBranches
{
	my $drb_str = $_[0];
	my $value = $_[1];
	
	# drb-Identity     1
	if ($drb_str =~ /drb-Identity\s+(\S+)/s)
	{
		$drb_identity = $1; 
	}
	
	if ($drb_identity eq "1" or $drb_identity eq "2")
	{
		ProcessDRB_1_2($drb_str, $drb_identity, $value);
	}
	elsif ($drb_identity eq "3")
	{
		ProcessDRB_3($drb_str, $drb_identity, $value);
	}
	else
	{
		WriteLog("ERROR! (drb_identity = $drb_identity, 1 to 3 is acceptable!)");
	}
}

sub ProcessDRB_1_2
{
	my $drb = $_[0];
	my $drb_identity = $_[1];
	my $value = $_[2];

	# eps-BearerIdentity     7
	if ($drb =~ /eps-BearerIdentity\s+(\S+)/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# drb-Identity     1
	$$value .= "$drb_identity";
	AppendCSVColumn($value);
	
	# discardTimer     infinity
	if ($drb =~ /.*\s+discardTimer\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
		
	# statusReportRequired     TRUE
	if ($drb =~ /.*\s+statusReportRequired\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
			
	# headerCompression     notUsed
	if ($drb =~ /.*\s+headerCompression\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
				
	# t-PollRetransmit     ms40
	if ($drb =~ /.*\s+t-PollRetransmit\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
					
	# pollPDU     pInfinity
	if ($drb =~ /.*\s+pollPDU\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
						
	# pollByte     kBinfinity
	if ($drb =~ /.*\s+pollByte\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
							
	# maxRetxThreshold     t32
	if ($drb =~ /.*\s+maxRetxThreshold\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
								
	# t-Reordering     ms50
	if ($drb =~ /.*\s+t-Reordering\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
								
	# t-StatusProhibit     ms0
	if ($drb =~ /.*\s+t-StatusProhibit\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
								
	# logicalChannelIdentity     3
	if ($drb =~ /.*\s+logicalChannelIdentity\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
									
	# priority     4
	if ($drb =~ /.*\s+priority\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
										
	# prioritisedBitRate     kBps8
	if ($drb =~ /.*\s+prioritisedBitRate\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
											
	# bucketSizeDuration     ms100
	if ($drb =~ /.*\s+bucketSizeDuration\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
												
	# logicalChannelGroup     0
	if ($drb =~ /.*\s+logicalChannelGroup\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
}

sub ProcessDRB_3
{
	my $drb = $_[0];
	my $drb_identity = $_[1];
	my $value = $_[2];

	AppendOffset($$value, "DRB_3");
	
	# eps-BearerIdentity     7
	if ($drb =~ /eps-BearerIdentity\s+(\S+)/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# drb-Identity     3
	$$value .= "$drb_identity";
	AppendCSVColumn($value);

	# discardTimer     infinity
	if ($drb =~ /.*\s+discardTimer\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);

	# pdcp-SN-Size     len12bits
	if ($drb =~ /.*\s+pdcp-SN-Size\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);

	# maxCID     2
	if ($drb =~ /.*\s+maxCID\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);

	my @profile_arry = ();
	my @profile_val_arry = ();
	# profiles     profile0x0001     TRUE     profile0x0001     FALSE
	while ($drb =~ /(profile0x\d+)\s+(\S+)/mgs)
	{
		push @profile_arry, $1;
		push @profile_val_arry, $2;
	}
	
	if (@profile_arry > 0 and @profile_arry eq @profile_val_arry)
	{
		for(my $i = 0; $i < scalar(@profile_arry); $i++)
		{
			my $pair = "($profile_arry[$i]:$profile_val_arry[$i])";
			if ($i == scalar(@profile_arry) - 1)
			{
				$$value .= "$pair";
			}
			else
			{
				$$value .= "$pair;";
			}
		}
	}
	AppendCSVColumn($value);

	# ul-UM-RLC     sn-FieldLength     size10     dl-UM-RLC     sn-FieldLength     size10
	if ($drb =~ /\s+ul-UM-RLC\s+sn-FieldLength\s+(\S+)\s+dl-UM-RLC\s+sn-FieldLength\s+(\S+)\s+/s)
	{
		$$value .= "$1,$2";
	}
	AppendCSVColumn($value);
	
	# t-Reordering     ms50
	if ($drb =~ /.*\s+t-Reordering\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
	
	# logicalChannelIdentity     3
	if ($drb =~ /.*\s+logicalChannelIdentity\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
									
	# priority     4
	if ($drb =~ /.*\s+priority\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
										
	# prioritisedBitRate     kBps8
	if ($drb =~ /.*\s+prioritisedBitRate\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
											
	# bucketSizeDuration     ms100
	if ($drb =~ /.*\s+bucketSizeDuration\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
												
	# logicalChannelGroup     0
	if ($drb =~ /.*\s+logicalChannelGroup\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);
}

sub ProcessMAC
{
	my $value =	\$_[0];
	
	if ($CurPeerData !~ /.*\s+mac-MainConfig\s+/s)
	{
		return 0;
	}
	
	# maxHARQ-Tx     n5
	if ($CurPeerData =~ /.*\s+maxHARQ-Tx\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# periodicBSR-Timer     sf10
	if ($CurPeerData =~ /.*\s+periodicBSR-Timer\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# retxBSR-Timer     sf320
	if ($CurPeerData =~ /.*\s+retxBSR-Timer\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# ttiBundling     FALSE
	if ($CurPeerData =~ /.*\s+ttiBundling\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# timeAlignmentTimerDedicated     infinity
	if ($CurPeerData =~ /.*\s+timeAlignmentTimerDedicated\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# periodicPHR-Timer     sf1000
	if ($CurPeerData =~ /.*\s+periodicPHR-Timer\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# prohibitPHR-Timer     sf100
	if ($CurPeerData =~ /.*\s+prohibitPHR-Timer\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
		
	# dl-PathlossChange     dB3
	if ($CurPeerData =~ /.*\s+dl-PathlossChange\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
		# onDurationTimer     psf8
	if ($CurPeerData =~ /.*\s+onDurationTimer\s+(\S+).*/s)
	{
		$$value .= "$1";
	}
	AppendCSVColumn($value);

	# drx-InactivityTimer     psf60
	if ($CurPeerData =~ /.*\s+drx-InactivityTimer\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
			
	# drx-RetransmissionTimer     psf4
	if ($CurPeerData =~ /.*\s+drx-RetransmissionTimer\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	my (@sf_name_arry, @sf_val_arry) = ();
	# longDRX-CycleStartOffset     sf160     26
	while ($CurPeerData =~ /(sf\d+)\s+(\d+)/mgs)
	{
		push @sf_name_arry, $1;
		push @sf_val_arry, $2;
	}
	
	if (@sf_name_arry > 0 and @sf_name_arry eq @sf_val_arry)
	{
		for(my $i = 0; $i < scalar(@sf_name_arry); $i++)
		{
			my $pair = "($sf_name_arry[$i]:$sf_val_arry[$i])";
			if ($i == scalar(@sf_name_arry) - 1)
			{
				$$value .= "$pair";
			}
			else
			{
				$$value .= "$pair;";
			}
		}
	}
	
	AppendCSVColumn($value);
	
	# shortDRX-Cycle     sf20
	if ($CurPeerData =~ /.*\s+shortDRX-Cycle\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# drxShortCycleTimer     1
	if ($CurPeerData =~ /.*\s+drxShortCycleTimer\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
}

sub ProcessPHY
{
	my $value =	\$_[0];
	
	my $phy = GetPHYData($CurPeerData);
	if ($phy eq "")
	{
		return 0;
	}

	# pdsch-ConfigDedicated     p-a     dB-3
	if ($phy =~ /.*\s+pdsch-ConfigDedicated\s+p-a\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# pucch-ConfigDedicated     ackNackRepetition     release     NULL
	if ($phy =~ /.*\s+pucch-ConfigDedicated\s+ackNackRepetition\s+(\S+)\s+(\S+)\s+/s)
	{
		$$value .= "$1:$2"; 
	}
	AppendCSVColumn($value);
	
	# tdd-AckNackFeedbackMode     bundling
	if ($phy =~ /.*\s+tdd-AckNackFeedbackMode\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# pusch-ConfigDedicated     betaOffset-ACK-Index     9
	if ($phy =~ /.*\s+pusch-ConfigDedicated\s+betaOffset-ACK-Index\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# betaOffset-RI-Index     5
	if ($phy =~ /.*\s+betaOffset-RI-Index\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# betaOffset-CQI-Index     12
	if ($phy =~ /.*\s+betaOffset-CQI-Index\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# uplinkPowerControlDedicated     p0-UE-PUSCH     0
	if ($phy =~ /.*\s+uplinkPowerControlDedicated\s+p0-UE-PUSCH\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# deltaMCS-Enabled     en0
	if ($phy =~ /.*\s+deltaMCS-Enabled\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# accumulationEnabled     TRUE
	if ($phy =~ /.*\s+accumulationEnabled\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# p0-UE-PUCCH     0
	if ($phy =~ /.*\s+p0-UE-PUCCH\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# pSRS-Offset     5
	if ($phy =~ /.*\s+pSRS-Offset\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# filterCoefficient     fc6
	if ($phy =~ /.*\s+filterCoefficient\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# tpc-PDCCH-ConfigPUCCH     release     NULL
	if ($phy =~ /.*\s+tpc-PDCCH-ConfigPUCCH\s+(\S+)\s+(\S+)\s+/s)
	{
		$$value .= "$1:$2"; 
	}
	AppendCSVColumn($value);
	
	# tpc-PDCCH-ConfigPUSCH     release     NULL
	if ($phy =~ /.*\s+tpc-PDCCH-ConfigPUSCH\s+(\S+)\s+(\S+)\s+/s)
	{
		$$value .= "$1:$2"; 
	}
	AppendCSVColumn($value);
	
	# cqi-ReportModeAperiodic     rm30
	if ($phy =~ /.*\s+cqi-ReportModeAperiodic\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# nomPDSCH-RS-EPRE-Offset     0
	if ($phy =~ /.*\s+nomPDSCH-RS-EPRE-Offset\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
	
	# cqi-PUCCH-ResourceIndex     2
	if ($phy =~ /.*\s+cqi-PUCCH-ResourceIndex\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# cqi-pmi-ConfigIndex     18
	if ($phy =~ /.*\s+cqi-pmi-ConfigIndex\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# widebandCQI     NULL
	if ($phy =~ /.*\s+widebandCQI\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# ri-ConfigIndex     644
	if ($phy =~ /.*\s+ri-ConfigIndex\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# simultaneousAckNackAndCQI     FALSE
	if ($phy =~ /.*\s+simultaneousAckNackAndCQI\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# srs-Bandwidth     bw2
	if ($phy =~ /.*\s+srs-Bandwidth\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# srs-HoppingBandwidth     hbw0
	if ($phy =~ /.*\s+srs-HoppingBandwidth\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# freqDomainPosition     6
	if ($phy =~ /.*\s+freqDomainPosition\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# duration     TRUE
	if ($phy =~ /.*\s+duration\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# srs-ConfigIndex     10
	if ($phy =~ /.*\s+srs-ConfigIndex\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# transmissionComb     1
	if ($phy =~ /.*\s+transmissionComb\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# cyclicShift     cs4
	if ($phy =~ /.*\s+cyclicShift\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# transmissionMode     tm3
	if ($phy =~ /.*\s+transmissionMode\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# codebookSubsetRestriction     n2TxAntenna-tm3     '11'B
	if ($phy =~ /.*\s+codebookSubsetRestriction\s+(\S+)\s+(\S+).*/s)
	{
		$$value .= "$1:$2"; 
	}
	AppendCSVColumn($value);

	# ue-TransmitAntennaSelection     release     NULL
	if ($phy =~ /.*\s+ue-TransmitAntennaSelection\s+(\S+)\s+(\S+).*/s)
	{
		$$value .= "$1:$2"; 
	}
	AppendCSVColumn($value);

	# sr-PUCCH-ResourceIndex     4
	if ($phy =~ /.*\s+sr-PUCCH-ResourceIndex\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# sr-ConfigIndex     12
	if ($phy =~ /.*\s+sr-ConfigIndex\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);

	# dsr-TransMax     n64
	if ($phy =~ /.*\s+dsr-TransMax\s+(\S+).*/s)
	{
		$$value .= "$1"; 
	}
	AppendCSVColumn($value);
}

sub ProcessMEAS
{
	my $value =	\$_[0];
	
	if ($CurPeerData !~ /.*\s+measConfig\s+/s)
	{
		return 0;
	}
	
	my $meas_exists = 0;
	my $meas_obj = GetMEASObjectData($CurPeerData);
	if ($meas_obj ne "")
	{
		ProcessMEASObjects($meas_obj, $value);
		$meas_exists = 1;
	}
	else
	{
		AppendOffset($$value, "MEAS_OBJ_ID");
	}
	
	my $meas_report_configs = GetMEASReportConfigData($CurPeerData);
	if ($meas_report_configs ne "")
	{
		ProcessMEASReportConfigs($meas_report_configs, $value);
	}
	else
	{
		AppendOffset($$value, "MEAS_RPT_CFG");
	}

	# filterCoefficientRSRP     fc6
	if ($CurPeerData =~ /.*\s+filterCoefficientRSRP\s+(\S+).*/s)
	{
		$$value .= $1; 
	}
	AppendCSVColumn($value);

	# filterCoefficientRSRQ     fc6
	if ($CurPeerData =~ /.*\s+filterCoefficientRSRQ\s+(\S+).*/s)
	{
		$$value .= $1; 
	}
	AppendCSVColumn($value);

	# s-Measure     0
	if ($CurPeerData =~ /.*\s+s-Measure\s+(\S+).*/s)
	{
		$$value .= $1; 
	}
	AppendCSVColumn($value);
}

sub ProcessMEASObjects
{
	my $rpt_cfg_obj = $_[0];
	my $value =	$_[1];
	
	# measObjectId     1
	if ($rpt_cfg_obj =~ /.*\s+measObjectId\s+(\S+).*/s)
	{
		$$value .= $1; 
	}
	AppendCSVColumn($value);

	# carrierFreq     39148
	if ($rpt_cfg_obj =~ /.*\s+carrierFreq\s+(\S+).*/s)
	{
		$$value .= $1; 
	}
	AppendCSVColumn($value);

	# allowedMeasBandwidth     mbw100
	if ($rpt_cfg_obj =~ /.*\s+allowedMeasBandwidth\s+(\S+).*/s)
	{
		$$value .= $1; 
	}
	AppendCSVColumn($value);

	# presenceAntennaPort1     FALSE
	if ($rpt_cfg_obj =~ /.*\s+presenceAntennaPort1\s+(\S+).*/s)
	{
		$$value .= $1; 
	}
	AppendCSVColumn($value);

	# neighCellConfig     '01'B
	if ($rpt_cfg_obj =~ /.*\s+neighCellConfig\s+(\S+).*/s)
	{
		$$value .= $1; 
	}
	AppendCSVColumn($value);

	# offsetFreq     dB0
	if ($rpt_cfg_obj =~ /.*\s+offsetFreq\s+(\S+).*/s)
	{
		$$value .= $1; 
	}
	AppendCSVColumn($value);
}

sub ProcessMEASReportConfigs
{
	%rpt_cfg_value_map = ();
	
	my $rpt_cfg = $_[0];
	my $value = $_[1];
	my $skipchars = 0;
	my $rpt_cfg_str = "";
	my ($start, $end, $next_start) = (-1, -1, -1);

	while(($next_start = index($rpt_cfg, "reportConfigId", $skipchars)) != -1)
	{
		$end = $next_start;

		if ($start != -1 and $start < $end)
		{
			$rpt_cfg_str = substr($rpt_cfg, $start, $end - $start);
			$skipchars = $next_start + length("reportConfigId");
			
			$start = $next_start;
			
			ProcessMEASReportConfigBranches($rpt_cfg_str);
		}
		else
		{
			$start = $next_start;
			$skipchars = $next_start + length("reportConfigId");
		}
	}
	
	if ($start >= 0)
	{
		$rpt_cfg_str = substr($rpt_cfg, $start, length($rpt_cfg) - $start);
		
		ProcessMEASReportConfigBranches($rpt_cfg_str);
	}
	
	if (scalar(keys %rpt_cfg_value_map) > 0)
	{
		$$value .= GetValueFromMap("reportConfigId(A3)");
		$$value .= GetValueFromMap("a3-Offset(A3)");
		$$value .= GetValueFromMap("reportOnLeave(A3)");
		$$value .= GetValueFromMap("hysteresis(A3)");
		$$value .= GetValueFromMap("timeToTrigger(A3)");
		$$value .= GetValueFromMap("triggerQuantity(A3)");
		$$value .= GetValueFromMap("reportQuantity(A3)");
		$$value .= GetValueFromMap("maxReportCells(A3)");
		$$value .= GetValueFromMap("reportInterval(A3)");
		$$value .= GetValueFromMap("reportAmount(A3)");
		
		$$value .= GetValueFromMap("reportConfigId(A2)");
		$$value .= GetValueFromMap("threshold-RSRP(A2)");
		$$value .= GetValueFromMap("threshold-RSRQ(A2)");
		$$value .= GetValueFromMap("hysteresis(A2)");
		$$value .= GetValueFromMap("timeToTrigger(A2)");
		$$value .= GetValueFromMap("triggerQuantity(A2)");
		$$value .= GetValueFromMap("reportQuantity(A2)");
		$$value .= GetValueFromMap("maxReportCells(A2)");
		$$value .= GetValueFromMap("reportInterval(A2)");
		$$value .= GetValueFromMap("reportAmount(A2)");
	}
}

sub ProcessMEASReportConfigBranches
{
	my $rpt_cfg = $_[0];

	if ($rpt_cfg =~ /.*\s+eventA3\s+/s)
	{
		ProcessEventA3($rpt_cfg);
	}
	elsif ($rpt_cfg =~ /.*\s+eventA2\s+/s)
	{
		ProcessEventA2($rpt_cfg);
	}
	else
	{
		return;
	}
}

sub ProcessEventA2
{
	my $rpt_cfg = $_[0];
	
	# reportConfigId     2
	if ($rpt_cfg =~ /reportConfigId\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'reportConfigId(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'reportConfigId(A2)'} .= ";";

	# threshold-RSRP     19
	if ($rpt_cfg =~ /.*\s+threshold-RSRP\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'threshold-RSRP(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'threshold-RSRP(A2)'} .= ";";

	# threshold-RSRQ     19
	if ($rpt_cfg =~ /.*\s+threshold-RSRQ\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'threshold-RSRQ(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'threshold-RSRQ(A2)'} .= ";";

	# hysteresis     2
	if ($rpt_cfg =~ /.*\s+hysteresis\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'hysteresis(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'hysteresis(A2)'} .= ";";

	# timeToTrigger     ms640
	if ($rpt_cfg =~ /.*\s+timeToTrigger\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'timeToTrigger(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'timeToTrigger(A2)'} .= ";";

	# triggerQuantity     rsrp
	if ($rpt_cfg =~ /.*\s+triggerQuantity\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'triggerQuantity(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'triggerQuantity(A2)'} .= ";";

	# reportQuantity     both
	if ($rpt_cfg =~ /.*\s+reportQuantity\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'reportQuantity(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'reportQuantity(A2)'} .= ";";

	# maxReportCells     1
	if ($rpt_cfg =~ /.*\s+maxReportCells\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'maxReportCells(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'maxReportCells(A2)'} .= ";";

	# reportInterval     ms480
	if ($rpt_cfg =~ /.*\s+reportInterval\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'reportInterval(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'reportInterval(A2)'} .= ";";

	# reportAmount     r1
	if ($rpt_cfg =~ /.*\s+reportAmount\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'reportAmount(A2)'} .= "$1";
	}
	$rpt_cfg_value_map{'reportAmount(A2)'} .= ";";
}

sub ProcessEventA3
{
	my $rpt_cfg = $_[0];

	# 1     reportConfig
	#if ($rpt_cfg =~ /.*\s+reportConfigId\s+(\S+).*/s)
	if ($rpt_cfg =~ /\s+(\d+)\s+reportConfig\s+.*/s)
	{
		$rpt_cfg_value_map{'reportConfigId(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'reportConfigId(A3)'} .= ";";
	
	# a3-Offset     4
	if ($rpt_cfg =~ /.*\s+a3-Offset\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'a3-Offset(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'a3-Offset(A3)'} .= ";";

	# reportOnLeave     FALSE
	if ($rpt_cfg =~ /.*\s+reportOnLeave\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'reportOnLeave(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'reportOnLeave(A3)'} .= ";";

	# hysteresis     2
	if ($rpt_cfg =~ /.*\s+hysteresis\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'hysteresis(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'hysteresis(A3)'} .= ";";

	# timeToTrigger     ms320
	if ($rpt_cfg =~ /.*\s+timeToTrigger\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'timeToTrigger(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'timeToTrigger(A3)'} .= ";";

	# triggerQuantity     rsrp
	if ($rpt_cfg =~ /.*\s+triggerQuantity\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'triggerQuantity(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'triggerQuantity(A3)'} .= ";";

	# reportQuantity     sameAsTriggerQuantity
	if ($rpt_cfg =~ /.*\s+reportQuantity\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'reportQuantity(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'reportQuantity(A3)'} .= ";";

	# maxReportCells     8
	if ($rpt_cfg =~ /.*\s+maxReportCells\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'maxReportCells(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'maxReportCells(A3)'} .= ";";

	# reportInterval     ms240
	if ($rpt_cfg =~ /.*\s+reportInterval\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'reportInterval(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'reportInterval(A3)'} .= ";";

	# reportAmount     infinity
	if ($rpt_cfg =~ /.*\s+reportAmount\s+(\S+).*/s)
	{
		$rpt_cfg_value_map{'reportAmount(A3)'} .= "$1";
	}
	$rpt_cfg_value_map{'reportAmount(A3)'} .= ";";
}

sub GetPHYData
{
	my $data = $_[0];
	my $phy = "";
	my $phy_start = index($data, "physicalConfigDedicated");
	if ($phy_start == -1)
	{
		return "";
	}
	
	my $phy_end = index($data, "securityConfigHO");
	if ($phy_end == -1)
	{
		$phy_end = index($data, "nonCriticalExtension");
	}
	
	if ($phy_start < $phy_end)
	{
		$phy = substr($CurPeerData, $phy_start, $phy_end - $phy_start);
	}
	else
	{
		$phy = substr($CurPeerData, $phy_start);
	}
	
	return $phy;
}

sub GetSRBData
{
	my $data = $_[0];
	my $srb = "";
	my $srb_start = index($data, "srb-ToAddModList");
	if ($srb_start == -1)
	{
		return "";
	}
	
	my $srb_end = index($data, "drb-ToAddModList");
	if ($srb_end == -1)
	{
		$srb_end = index($data, "drb-ToReleaseList");
		if ($srb_end == -1)
		{
			$srb_end = index($data, "mac-MainConfig");
			if ($srb_end == -1)
			{
				$srb_end = index($data, "sps-Config");
				if ($srb_end == -1)
				{
					$srb_end = index($data, "physicalConfigDedicated");
				}
			}
		}
	}
	
	if ($srb_start < $srb_end)
	{
		$srb = substr($CurPeerData, $srb_start, $srb_end - $srb_start);
	}
	else
	{
		$srb = substr($CurPeerData, $srb_start);
	}
	
	return $srb;
}

sub GetDRBData
{
	my $data = $_[0];
	my $drb = "";
	my $drb_start = index($data, "drb-ToAddModList");
	if ($drb_start == -1)
	{
		return "";
	}

	my $drb_end = index($data, "drb-ToReleaseList");
	if ($drb_end == -1)
	{
		$drb_end = index($data, "mac-MainConfig");
		if ($drb_end == -1)
		{
			$drb_end = index($data, "sps-Config");
			if ($drb_end == -1)
			{
				$drb_end = index($data, "physicalConfigDedicated");
			}
		}
	}
	
	if ($drb_start < $drb_end)
	{
		$drb = substr($CurPeerData, $drb_start, $drb_end - $drb_start);
	}
	else
	{
		$drb = substr($CurPeerData, $drb_start);
	}
	
	return $drb;
}

sub GetMEASObjectData
{
	my $data = $_[0];
	my $rpt_cfg = "";
	my $rpt_cfg_start = index($data, "measObjectToAddModList");
	if ($rpt_cfg_start == -1)
	{
		return "";
	}

	my $rpt_cfg_end = index($data, "reportConfigToRemoveList");
	if ($rpt_cfg_end == -1)
	{
		$rpt_cfg_end = index($data, "reportConfigToAddModList");
		if ($rpt_cfg_end == -1)
		{
			$rpt_cfg_end = index($data, "measIdToRemoveList");
			if ($rpt_cfg_end == -1)
			{
				$rpt_cfg_end = index($data, "measIdToAddModList");
				if ($rpt_cfg_end == -1)
				{
					$rpt_cfg_end = index($data, "quantityConfig");
					if ($rpt_cfg_end == -1)
					{
						$rpt_cfg_end = index($data, "measGapConfig");
						if ($rpt_cfg_end == -1)
						{
							$rpt_cfg_end = index($data, "s-Measure");
							if ($rpt_cfg_end == -1)
							{
								$rpt_cfg_end = index($data, "preRegistrationInfoHRPD");
								if ($rpt_cfg_end == -1)
								{
									$rpt_cfg_end = index($data, "speedStatePars");
								}
							}
						}
					}
				}
			}
		}
	}
	
	if ($rpt_cfg_start < $rpt_cfg_end)
	{
		$rpt_cfg = substr($CurPeerData, $rpt_cfg_start, $rpt_cfg_end - $rpt_cfg_start);
	}
	else
	{
		$rpt_cfg = substr($CurPeerData, $rpt_cfg_start);
	}
	
	return $rpt_cfg;
}

sub GetMEASReportConfigData
{
	my $data = $_[0];
	my $rpt_cfg = "";
	my $rpt_cfg_start = index($data, "reportConfigToAddModList");
	if ($rpt_cfg_start == -1)
	{
		return "";
	}

	my $rpt_cfg_end = index($data, "measIdToRemoveList");
	if ($rpt_cfg_end == -1)
	{
		$rpt_cfg_end = index($data, "measIdToAddModList");
		if ($rpt_cfg_end == -1)
		{
			$rpt_cfg_end = index($data, "quantityConfig");
			if ($rpt_cfg_end == -1)
			{
				$rpt_cfg_end = index($data, "measGapConfig");
				if ($rpt_cfg_end == -1)
				{
					$rpt_cfg_end = index($data, "s-Measure");
					if ($rpt_cfg_end == -1)
					{
						$rpt_cfg_end = index($data, "preRegistrationInfoHRPD");
						if ($rpt_cfg_end == -1)
						{
							$rpt_cfg_end = index($data, "speedStatePars");
						}
					}
				}
			}
		}
	}
	
	if ($rpt_cfg_start < $rpt_cfg_end)
	{
		$rpt_cfg = substr($CurPeerData, $rpt_cfg_start, $rpt_cfg_end - $rpt_cfg_start);
	}
	else
	{
		$rpt_cfg = substr($CurPeerData, $rpt_cfg_start);
	}
	
	return $rpt_cfg;
}

sub GetValueFromMap
{
	my $value_count = GetValueCount($_[0]);
	if (0 == $value_count)
	{
		return ",";
	}
	elsif (1 == $value_count)
	{
		return RemoveTailSemicolon($rpt_cfg_value_map{$_[0]}).",";
	}
	else
	{
		return "(".RemoveTailSemicolon($rpt_cfg_value_map{$_[0]})."),";
	}
}

sub GetValueCount
{
	if (!exists($rpt_cfg_value_map{$_[0]}))
	{
		return 0;
	}
	else
	{
		my @arry = split(/;/, $rpt_cfg_value_map{$_[0]});
		return scalar(@arry);
	}
}

sub RemoveTailSemicolon
{
	my $data = $_[0];
	if (length($data) > 1)
	{
		return substr($data, 0, length($data) - 1);
	}
	
	return $data;
}

sub ProcessData
{
	$line_write = "";
	my $count = 0;

    #按行读取数据文件all.aird中的数据
    while ( $line_read = <$fh_data> ) 
    {
        #1005349-1   	14:14:18.086	--  	LTE		<- SYSTEMINFORMATIONBLOCKTYPE1		0:05:34.547
        if ($line_read =~ /\d*-\d*\s*(\d*:\d*:\d*\.\d*).*<- (\w+)\s*\d*:\d*:\d*\.\d*\s*/)    
        {
        	$line_write = "";
            $CurASName = $2;
            $Time = "\'".$1;

            # 按空口消息名称做相应处理
			if ($CurASName eq "MIB")
            {
            	GetLocalData();
            	GetPeerData();
            	
            	AppendCommData($line_write);
            	
            	AppendOffset($line_write, "MIB");
            	ProcessMIB($line_write);

            	WriteLineToResultFile($line_write, "SYS");
            }
            elsif ($CurASName eq "SYSTEMINFORMATIONBLOCKTYPE1")
            {
            	GetLocalData();
            	GetPeerData();
            	AppendCommData($line_write);
            	
            	AppendOffset($line_write, "SIB_1");
            	ProcessSIB_1($line_write);

            	WriteLineToResultFile($line_write, "SYS");
            }
            elsif ($CurASName eq "SYSTEMINFORMATION")
            {
            	GetLocalData();
            	GetPeerData();
            	
            	AppendCommData($line_write);
            	AppendOffset($line_write, "SYSTEMINFORMATION");
            	
            	%sib_value_map = ();
            	my @sibs = split(/\n\s{16}sib/, $CurPeerData);
				for (my $i = 0; $i < scalar(@sibs); $i++)
				{
					if ($sibs[$i] =~ /^(\d+).*/)
					{
						ProcessOtherSIBs($1, $sibs[$i]);
					}
				}
				
				if (exists $sib_value_map{'SIB2'})
				{
					$line_write .= $sib_value_map{'SIB2'}
				}
				else
				{
					AppendOffset($line_write, "SIB_2");
				}
				
				if (exists $sib_value_map{'SIB3'})
				{
					$line_write .= $sib_value_map{'SIB3'}
				}
				else
				{
					AppendOffset($line_write, "SIB_3");
				}
				
				if (exists $sib_value_map{'SIB5'})
				{
					$line_write .= $sib_value_map{'SIB5'}
				}
				else
				{
					AppendOffset($line_write, "SIB_5");
				}
				
				if (exists $sib_value_map{'SIB7'})
				{
					$line_write .= $sib_value_map{'SIB7'}
				}
				else
				{
					AppendOffset($line_write, "SIB_7");
				}

            	WriteLineToResultFile($line_write, "SYS");
            }
            elsif ($CurASName eq "RRCCONNECTIONSETUP")
            {
            	GetLocalData();
            	GetPeerData();

				$line_write = "";
            	if (ProcessSRB($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "SRB");
            	}
            	
            	$line_write = "";
            	if (ProcessDRB($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "DRB");
            	}
            	
            	$line_write = "";
            	if (ProcessMAC($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "MAC");
            	}
            	
            	$line_write = "";
            	if (ProcessPHY($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "PHY");
            	}
            }
            elsif ($CurASName eq "RRCCONNECTIONRECONFIGURATION")
            {
            	GetLocalData();
            	GetPeerData();
				
				$line_write = "";
            	if (ProcessSRB($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "SRB");
            	}
            	
            	$line_write = "";
            	if (ProcessDRB($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "DRB");
            	}
            	
            	$line_write = "";
            	if (ProcessMAC($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "MAC");
            	}
            	
            	$line_write = "";
            	if (ProcessPHY($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "PHY");
            	}
            	
            	$line_write = "";
            	if (ProcessMEAS($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "MEAS");
            	}
            }
            elsif ($CurASName eq "RRCCONNECTIONREESTABLISHMENT")
            {
            	GetLocalData();
            	GetPeerData();
            	
            	$line_write = "";
            	if (ProcessSRB($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "SRB");
            	}
            	
            	$line_write = "";
            	if (ProcessDRB($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "DRB");
            	}
            	
            	$line_write = "";
            	if (ProcessMAC($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "MAC");
            	}

            	$line_write = "";
            	if (ProcessPHY($line_write))
            	{
            		InsertCommData($line_write);
            		WriteLineToResultFile($line_write, "PHY");
            	}
            }
            else
            {
            	next;
            }
        }       
    }
}

Prepare();
OpenFiles();
ProcessData();
CloseFiles();

exit 0;