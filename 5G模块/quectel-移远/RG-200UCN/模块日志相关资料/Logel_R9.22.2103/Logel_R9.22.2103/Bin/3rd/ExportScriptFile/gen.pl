#!user/bin/perl -w
#use strict;
#use warnings;
#use diagnostics;
#use POSIX;

if(scalar(@ARGV)!= 7)
{
    die "[gen.pl] param error, number of params at least is 7 \n";
}

for(my $pi = 0; $pi<scalar(@ARGV); $pi++)
{
   print "${ARGV[$pi]} ";
}
print "\r\n";

#接收bat文件传进来的参数
my $scriptname  = ${ARGV[0]};
my $creator     = ${ARGV[1]};
my $msg_gsm     = ','.${ARGV[2]}.',';
my $msg_3g      = ','.${ARGV[3]}.',';
my $msg_lte     = ','.${ARGV[4]}.',';
my $tcl_template= ${ARGV[5]};
my $data_file   = ${ARGV[6]};

# 定义读写文件的句柄
my $fh_data;        #读取的数据文件句柄
my $fh_gsm;         #临时GSM消息文件句柄
my $fh_3g;          #临时W消息文件句柄
my $fh_lte;         #临时LTE文件句柄
my $fh_air;         #临时MsgFlow文件句柄
my $fh_template;    #模板文件句柄

my $out_path    = $data_file;
$out_path =~ s/(.*)\\[^\\]*$/$1/g;

my $tcl_gsm     = $out_path."\\gsm.tcl";
my $tcl_3g      = $out_path."\\3g.tcl";
my $tcl_lte     = $out_path."\\lte.tcl";
my $tcl_air     = $out_path."\\air.tcl";

my $CurMsgName;         #当前从数据文件中提取出的消息名称
my $strLocalData = "";  #GSM消息PH_MAC_DATA_REQ，PH_MAC_DATA_IND，RLC_MAC_DATA_REQ local 字符串数据
my @arrLocalData = ();  #GSM消息字符串数据分割后的数据数组
my @arrPeerData  = ();
my $LocalDataLen = 0;   #GSM消息Local数据长度
my $Sender = "";

# 主函数 WriteScipteFile param
my $fh_write;
my $strMsgName="";
my $strFuncName="";
my $strLocalName="";
my $nNo = 0;     #序号
my $Time = 0;
my $strPeerName = "";
my $bHaveExtraParam = 0;
my $dwExtraParam = 0;
my $nByteIndex = 0;

my $line;

sub InitMsgParam()
{
    @arrLocalData = ();
    @arrPeerData  = ();
    $strMsgName   = "";
    
    my $keyMsg = ",$CurMsgName,";
    if(index($msg_gsm, $keyMsg) != -1)
    {
        GenGsmMsgToScriptFile();
        return 0;
    }
    elsif(index($msg_3g,$keyMsg ) != -1)
    {
        return Get3gMsgParam();      
    }
    elsif(index($msg_lte,$keyMsg ) != -1)
    {
        return GetLteMsgParam();
    }  
    
    return 0; 
}

sub DelTempTclFile()
{
   unlink $tcl_gsm;
   unlink $tcl_3g;
   unlink $tcl_lte;
   unlink $tcl_air;
}

sub OpenScriptTclFile()
{    
    DelTempTclFile();
    open $fh_data,        '<', $data_file          or die "Cannot open '$data_file' for reading: $!";    
    open $fh_template,    '<', $tcl_template       or die "Cannot open '$tcl_template' for writing: $!";
    open $fh_3g,          '>>',$tcl_3g             or die "Cannot open '$tcl_3g' for appending: $!";
    open $fh_gsm,         '>>',$tcl_gsm            or die "Cannot open '$tcl_gsm' for appending: $!";
    open $fh_lte,         '>>',$tcl_lte            or die "Cannot open '$tcl_lte' for appending: $!";
    open $fh_air,         '>>',$tcl_air            or die "Cannot open '$tcl_air' for appending: $!";
}

sub CloseScriptTclFile()
{
    close $fh_data or die "cannot close '$data_file': $!";
    close $fh_template or die "cannot close '$tcl_template': $!";
    close $fh_gsm or die "cannot close '$tcl_gsm': $!";
    close $fh_3g or die "cannot close '$tcl_3g': $!";
    close $fh_lte or die "cannot close '$tcl_lte': $!";
    close $fh_air or die "cannot close '$tcl_air': $!";
}

sub Get3gMsgParam()
{
    my $result = 1;
    $strMsgName = "";
    $strFuncName = "";
    $strLocalName = "";
    $strPeerName = "";
    $bHaveExtraParam = 0;
    
    if($CurMsgName eq "MSG_ID_CPHY_RF_MEAS_IND")
    {
        $strFuncName = "bptd_ftr_rf_meas_ind";
        $strLocalName = "rf_meas_ind_local";
        $bHaveExtraParam = 0;
        $fh_write = $fh_3g;
    }
    elsif($CurMsgName eq "MSG_ID_CPHY_CELL_SEARCH_IND")
    {
        $strFuncName = "bptd_ftr_configure_cell_params";
        $strLocalName = "cell_search_ind_local";
        $bHaveExtraParam = 0;
        $fh_write = $fh_3g;
    }
    elsif($CurMsgName eq "MSG_ID_RRC_SIB_PRINT")
    {
        $strFuncName = "bptd_ftr_configure_sysinfo";
        $strLocalName = "rrc_sib_print_local";
        $bHaveExtraParam = 0;
        $fh_write = $fh_3g;
    }
    elsif($CurMsgName eq "MSG_ID_RLC_DATA_REQ")
    {
        $strFuncName = "bptd_ftr_rcv_msg";
        $strLocalName = "rlc_data_req_local";
        $strPeerName = "rlc_data_req_peer";
        $bHaveExtraParam = 0;
        $fh_write = $fh_air;
        print $fh_write  "    #SS<-UE: \n";
    }
    elsif($CurMsgName eq "MSG_ID_AS_RLC_DATA_IND")
    {
        $strFuncName = "bptd_ftr_snd_msg";
        $strLocalName = "rlc_data_ind_local";
        $strPeerName = "rlc_data_ind_peer";
        $bHaveExtraParam = 0;
        $fh_write = $fh_air;
        print $fh_write  "    #SS->UE: \n";
    }
    elsif($CurMsgName eq "MSG_ID_CHPY_CELL_MEAS_IND")
    {
        $strFuncName = "bptd_ftr_cell_meas_ind";
        $strLocalName = "cell_meas_ind_local";        
        $bHaveExtraParam = 0;
        $fh_write = $fh_air;
    }
    elsif($CurMsgName eq "MSG_ID_PHY_BCH_DATA_IND")
    {
        $strFuncName = "bptd_snd_msg MOD_RRC MOD_RRC CPHY_SAP MSG_ID_PHY_BCH_DATA_IND ";
        $strLocalName = "phy_bch_data_ind_local";
        $bHaveExtraParam = 0;
        $fh_write = $fh_air;
    }
    elsif($CurMsgName eq "WRRC_SME_DPCH_CONFIG_REQ")
    {
        $strMsgName = $CurMsgName;
        $strFuncName = "bptd_ftr_rcv_rrc_local_msg";
        $strLocalName = "rlc_data_req_local";
        $bHaveExtraParam = 0;
        $fh_write = $fh_air;
        print $fh_write  "    #WRRC->WLAYER1: DPCH_CONFIG_REQ\n";
    }
    elsif($CurMsgName eq "WRRC_SME_FACH_CONFIG_REQ")
    {
        $strMsgName = $CurMsgName;
        $strFuncName = "bptd_ftr_rcv_rrc_local_msg";
        $strLocalName = "rlc_data_req_local";
        $bHaveExtraParam = 0;
        $fh_write = $fh_air;
        print $fh_write  "    #WRRC->WLAYER1: FACH_CONFIG_REQ\n";
    }
    elsif($CurMsgName eq "WRRC_SME_RACH_CONFIG_REQ")
    {
        $strMsgName = $CurMsgName;
        $strFuncName = "bptd_ftr_rcv_rrc_local_msg";
        $strLocalName = "rlc_data_req_local";
        $bHaveExtraParam = 0;
        $fh_write = $fh_air;
        print $fh_write  "    #WRRC->WLAYER1: RACH_CONFIG_REQ\n";
    }
    elsif($CurMsgName eq "MSG_ID_WRRC_SIB_PRINT")
    {
        $strFuncName = "bptd_ftr_configure_sysinfo";
        $strLocalName = "rlc_data_req_local";
        $bHaveExtraParam = 0;
        $fh_write = $fh_3g;
    }
    elsif($CurMsgName eq "MSG_ID_3G_RRC_SIB_PRINT")
    {
        $strFuncName = "bptd_ftr_configure_sysinfo";
        $strLocalName = "rrc_sib_print_local";
        $bHaveExtraParam = 1;
        $dwExtraParam = 1;
        $fh_write = $fh_3g;
    }
    else
    {
        $result = 0;
    }
    
    return $result;
}

sub GetLteMsgParam()
{
    my $result = 1;
    $strMsgName = "";
    $strFuncName = "";
    $strLocalName = "";
    $strPeerName = "";
    $bHaveExtraParam = 0;
    
    if($CurMsgName eq "MSG_ID_BCCH_BCH_MSG_TYPE")
    {
        $strFuncName = "bp4g_ftr_configure_mib";
        $strLocalName = "bcch_bch_print_local";
        $strPeerName = "bcch_bch_print_peer";
        $bHaveExtraParam = 0;
        $fh_write = $fh_lte;
    }
    elsif($CurMsgName eq "MSG_ID_BCCH_DL_SCH_MSG_TYPE")
    {
        $strFuncName = "bp4g_ftr_configure_sysinfo";
        $strLocalName = "bcch_dl_sch_print_local";
        $strPeerName = "bcch_dl_sch_print_peer";
        $bHaveExtraParam = 0;
        $fh_write = $fh_lte;
    }
    elsif($CurMsgName eq "MSG_ID_UL_CCCH_MSG_TYPE")
    {
        $strMsgName = $CurMsgName;
        $strFuncName = "bp4g_ftr_rcv_msg";
        $strLocalName = "data_req_local";
        $strPeerName = "data_req_peer";
        $bHaveExtraParam = 1;
        $dwExtraParam = 60;
        $fh_write = $fh_air;
        
    }
    elsif($CurMsgName eq "MSG_ID_UL_DCCH_MSG_TYPE")
    {
        $strMsgName = $CurMsgName;
        $strFuncName = "bp4g_ftr_rcv_msg";
        $strLocalName = "data_req_local";
        $strPeerName = "data_req_peer";
        $bHaveExtraParam = 1;
        $dwExtraParam = 60;
        $fh_write = $fh_air;
    }
    elsif($CurMsgName eq "MSG_ID_DL_DCCH_MSG_TYPE")
    {
        $strMsgName = $CurMsgName;
        $strFuncName = "bp4g_ftr_snd_msg";
        $strLocalName = "data_ind_local";
        $strPeerName = "data_ind_peer";
        $bHaveExtraParam = 0;
        $fh_write = $fh_air;
    }
    elsif($CurMsgName eq "MSG_ID_DL_CCCH_MSG_TYPE")
    {
        $strMsgName = $CurMsgName;
        $strFuncName = "bp4g_ftr_snd_msg";
        $strLocalName = "data_ind_local";
        $strPeerName = "data_ind_peer";
        $bHaveExtraParam = 0;
        $fh_write = $fh_air;
    }
    elsif($CurMsgName eq "MSG_ID_PCCH_MSG_TYPE")
    {
        $strMsgName = $CurMsgName;
        $strFuncName = "bp4g_ftr_snd_msg";
        $strLocalName = "data_ind_local";
        $strPeerName = "data_ind_peer";
        $bHaveExtraParam = 1;
        $dwExtraParam = 1;
        $fh_write = $fh_air;
    }
    else
    {
        $result = 0;
    }
    
    return $result;
}

sub GetLocalData()
{
    # 把LocalData中数据提取到数组中
    my $nIndex = 0;        
    my $bLocalStart = 0;
    $LocalDataLen = 0;
    @arrLocalData = ();
    while ( $line = <$fh_data> )
    {
        if ($line =~ /\s*.*\[local_msg_data_start\]\s*.*/)
        {
            $bLocalStart = 1;    
        }
        elsif ($line =~ /\s*.*\[local_msg_data_end\]\s*.*/)
        {      
            $line = "";
            last;                
        }
        elsif ($bLocalStart)
        {
            my @arrLine = split(' ',$line);
            for(my $i = 0; $i<scalar(@arrLine); $i++)
            {
                $arrLocalData[$nIndex] = $arrLine[$i];
                #print $arrLocalData[$nIndex];
                $nIndex++;
            }     
        }
    }
    $LocalDataLen = scalar(@arrLocalData);
}
sub GetPeerData()
{
    # 把LocalData中数据提取到数组中
    my $nIndex = 0;        
    my $bPeerStart = 0;
    @arrPeerData = ();
    while ( $line = <$fh_data> )
    {
        if ($line =~ /\s*.*\[peer_msg_data_start\]\s*.*/)
        {
            $bPeerStart = 1;    
        }
        elsif ($line =~ /\s*.*\[peer_msg_data_end\]\s*.*/)
        {
            $line = "";
            last;                
        }
        elsif ($bPeerStart)
        {
            my @arrLine = split(' ',$line);
            for(my $i = 0; $i<scalar(@arrLine); $i++)
            {
                $arrPeerData[$nIndex] = $arrLine[$i];
                #print $arrPeerData[$nIndex];
                $nIndex++;
            }     
        }
    }
}
sub GenGsmMsgToScriptFile()
{
    $nByteIndex = 0;   
    GetLocalData();    
   
    if($CurMsgName eq "MPH_BCCH_INFO_IND")
    {
        if ($Sender ne "P_LAYER1" && $Sender ne "MOD_GLAYER1")
        {         
            return;
        }
        else
        {
            $strMsgName = $CurMsgName;
            $strFuncName = "bp2g_ftr_configure_sysinfo";
            $strLocalName = "mph_bcch_info_ind_local";
            $strPeerName = "mph_bcch_info_ind_peer";
            $bHaveExtraParam = 0;
            $dwExtraParam = 0;
            @arrPeerData=();
            for(my $i = 0; $i<23; $i++)
            {
                $arrPeerData[$i] = $arrLocalData[14+$i];
            }
            $fh_write = $fh_gsm;
            WriteScriptFile();
            return;
        }
    }
    elsif ($CurMsgName eq "MPH_DATA_IND")
    {
        if (($Sender ne "P_LAYER1" && $Sender ne "MOD_GLAYER1") || $arrLocalData[34] eq "00")
        {
            return;            
        }
        $nByteIndex = 34;        
    }
    elsif ($CurMsgName eq "DL_UNIT_DATA_IND")
    {
        $strMsgName = $CurMsgName;
        $strFuncName = "bp2g_ftr_configure_sysinfo";
        $strLocalName = "dl_unit_data_ind_local";
        $strPeerName = "dl_unit_data_ind_peer";
        $bHaveExtraParam = 0;
        $dwExtraParam = 0;
        @arrPeerData=();
        for(my $i = 0; $i<23; $i++)
        {
            $arrPeerData[$i] = $arrLocalData[16+$i];
        }
        $fh_write = $fh_gsm;
        WriteScriptFile();
        return;
    }
    elsif ($CurMsgName eq "DL_DATA_IND")
    {
        $nByteIndex = 29;
    }
    elsif($CurMsgName eq "DL_ESTABLISH_IND" ||
          $CurMsgName eq "MPH_IMMED_ASSIGN_REQ" ||
          $CurMsgName eq "MPH_ERROR_IND" )
    {
        $nByteIndex = -1;
    }
    elsif($CurMsgName eq "MPH_RANDOM_ACCESS_REQ")
    {
        $nByteIndex = 16;
    }
    elsif($CurMsgName eq "DL_DATA_REQ")
    {
        $nByteIndex = 28;
    }
    elsif( $CurMsgName eq "DL_UNIT_DATA_REQ" ||
           $CurMsgName eq "DL_ESTABLISH_REQ" ||
           $CurMsgName eq "DL_RESUME_REQ" ||
           $CurMsgName eq "DL_RECONNECT_REQ" ||
           $CurMsgName eq "PH_MAC_DATA_REQ" ||
           $CurMsgName eq "PH_MAC_DATA_IND" ||
           $CurMsgName eq "RLC_MAC_DATA_REQ" )
    {
        $nByteIndex = 33;
    }
   
    $fh_write = $fh_air;
    
    my $rcvtype = "";    
    if($CurMsgName eq "PH_MAC_DATA_REQ" ||
       $CurMsgName eq "PH_MAC_DATA_IND" ||
       $CurMsgName eq "RLC_MAC_DATA_REQ" )
    {
        $rcvtype = GetGPRSMsgType();
    }
    
    my $strStructname = "";
    
    if(!$rcvtype)
    {
        if ($nByteIndex != -1)
        {
            $strStructname = "$CurMsgName 0x".$arrLocalData[$nByteIndex];
        }
        else
        {
            $strStructname = $CurMsgName;
        }
    }
    else
    {
        $strStructname = "$CurMsgName $rcvtype";
    }
    
    my $strText = "";
    
    if(index($CurMsgName,"REQ") == -1)
    {
        $strText = "    #SS->UE: $strStructname\n";
        $strFuncName = "bp2g_ftr_snd_msg";
    }
    else
    {
        $strText = "    #SS<-UE: $strStructname\n";
        $strFuncName = "bp2g_ftr_rcv_msg";
    }    
    
    print $fh_write $strText;
    
    $strMsgName  = $CurMsgName;
    $strLocalName = lc($CurMsgName)."_local";
    $strPeerName = "";
    $bHaveExtraParam = 0;
    $dwExtraParam = 0;
    @arrPeerData=();
    WriteScriptFile();
}

sub WriteScriptFile()
{
    if( scalar(@arrLocalData) != 0 )
    {
        print  $fh_write  "    set $strLocalName\_$nNo \"{\n        ";
        my $nLocalSize = scalar(@arrLocalData);
        for( my $i = 0; $i < $nLocalSize - 1 ;  $i++ )
        {
            print  $fh_write "0x".$arrLocalData[$i].",";
            if( $i > 0 && ($i + 1) % 15 == 0 )
            {
                print $fh_write "\n        "; 
            }
        }
        print  $fh_write "0x".$arrLocalData[$nLocalSize - 1]."\n    }\";\n";
    }
    else
    {
        print  $fh_write  "    set $strLocalName\_$nNo \"{\n";
        print  $fh_write  "    }\";\n";
    }
        
    if( $strPeerName )
    {
        if(scalar(@arrPeerData) != 0 )
        {
            print  $fh_write  "    set $strPeerName\_$nNo \"{\n        ";
            my $nPeerSize = scalar(@arrPeerData);
            for( my $i = 0; $i < $nPeerSize - 1 ;  $i++ )
            {
                print  $fh_write "0x".$arrPeerData[$i].",";
                if( $i > 0 && ($i + 1) % 15 == 0 )
                {
                    print $fh_write "\n        "; 
                }
            }
            print  $fh_write "0x".$arrPeerData[$nPeerSize - 1]."\n    }\";\n";
        }
        else
        {
            print  $fh_write  "    set $strPeerName\_$nNo \"{\n";
            print  $fh_write  "    }\";\n";
        }
        
        if ($strMsgName)
        {
            print $fh_write "    $strFuncName $strMsgName \$$strLocalName\_$nNo \$$strPeerName\_$nNo $Time";
        }
        else
        {
            print $fh_write "    $strFuncName \$$strLocalName\_$nNo \$$strPeerName\_$nNo $Time";
        }
        
        if ($bHaveExtraParam != 0)
        {
            print $fh_write " $dwExtraParam;\n"
        }
        else
        {
            print $fh_write ";\n"
        }
             
        print $fh_write "    unset $strPeerName\_$nNo;\n";
    }
    else
    {
        if ($strMsgName)
        {
            print $fh_write "    $strFuncName $strMsgName \$$strLocalName\_$nNo $Time";
        }
        else
        {
            print $fh_write "    $strFuncName \$$strLocalName\_$nNo $Time";
        }
        
        if ($bHaveExtraParam != 0)
        {
            print $fh_write " $dwExtraParam;\n";
        }
        else
        {
            print $fh_write ";\n";
        }
    }
    print $fh_write "    unset $strLocalName\_$nNo;\n";
}

my %uplink_msg = (
    0 => "gprs_packet_cell_change_failure",
    1 => "gprs_packet_control_acknowledgement",
    2 => "gprs_packet_downlink_ack_nack",
    3 => "gprs_packet_uplink_dummy_control_block",
    4 => "gprs_packet_measurement_report",
    5 => "gprs_packet_resource_request",
    6 => "gprs_packet_mobile_tbf_Status",
    7 => "gprs_packet_psi_status_message",
    8 => "gprs_egprs_packet_downlink_ack_nack",
    9 => "gprs_packet_pause_message",
    10 => "packet_enhanced_measurement_report",
    12 => "gprs_packet_cell_change_notification",
    13 => "gprs_packet_si_status_message"
    );

my %downlink_msg = (
    33 => "gprs_packet_access_reject",
    1 => "gprs_packet_cell_change_order",
    2 => "gprs_packet_downlink_assignment",
    3 => "gprs_packet_measurement_order",
    34 => "gprs_packet_paging_request",
    35 => "gprs_packet_pdch_release",
    4 => "gprs_packet_polling_request",
    5 => "gprs_packet_power_control/timing_advance",
    36 => "gprs_packet_prach_parameters",
    6 => "gprs_packet_queueing_notification",
    7 => "gprs_packet_timeslot_reconfigure",
    8 => "gprs_packet_tbf_release",
    9 => "gprs_packet_uplink_ack_nack",
    10 => "gprs_packet_uplink_assignment",
    37 => "gprs_packet_downlink_dummy_control_block"
    );

my %msgtype_g = (
    "PH_MAC_DATA_REQ" => 0, 
    "RLC_MAC_DATA_REQ" => 1,
    "PH_MAC_DATA_IND" => 2
    #"DATA_BLOCK" => 3
    );

sub GetGPRSMsgType()
{   
    #my $GPRS_MSG_NUM = 64;
    my $i = 0;
    my $retVal = "";
    my $temp = "";
    my $value = 0;   
     
    if( $LocalDataLen == 0 || !exists $msgtype_g{$CurMsgName})
    {
        return $retVal;
    }
    
    $i = $msgtype_g{$CurMsgName};

    if (0 == $i) #PH_MAC_DATA_REQ
    {
        if ($LocalDataLen < 38)
        {
            return $retVal;
        }
        
        $temp = $arrLocalData[37];
        $value = hex($temp);
        $value = $value >> 2;
        
        if( !exists $uplink_msg{$value} )   
        {
            return $retVal;
        }        
        $retVal = $uplink_msg{$value};       
    }
    elsif(1 == $i) #RLC_MAC_DATA_REQ
    {
        $retVal = "DATA_BLOCK";
    }
    elsif(2 == $i) #PH_MAC_DATA_IND
    {
        if ($LocalDataLen < 68)
        {
            return $retVal;
        }
      
        $temp = $arrLocalData[64];
        $value = hex($temp);
        $value = $value >> 6;
      
        if(0 == $value)
        {
            $retVal = "DATA_BLOCK";
        }
        elsif(1 == $value)
        {
            $temp = $arrLocalData[65];
            $value = hex($temp);
            $value = $value >> 2;
           
            if( !exists $downlink_msg{$value} )   
            {
                return $retVal;
            }        
            $retVal = $downlink_msg{$value};           
        }
        elsif(2 == $value)
        {
            $temp = $arrLocalData[65];
            $value = hex($temp);
            $value = $value & 0x01;
         
            if (0 == $value)
            {
                $temp = $arrLocalData[66];
            }
            else
            {
                $temp = $arrLocalData[67];
            }   
            $value = hex($temp);      
            $value = $value >> 2;            
            
            if( !exists $downlink_msg{$value} )   
            {
                return $retVal;
            }        
            $retVal = $downlink_msg{$value};  
        }
   }
   return $retVal;
}

sub OpenFileForRead()
{
   #关闭文件为了获取读的文件句柄
   close $fh_gsm or die "cannot close '$tcl_gsm': $!";
   close $fh_3g or die "cannot close '$tcl_3g': $!";
   close $fh_lte or die "cannot close '$tcl_lte': $!";
   close $fh_air or die "cannot close '$tcl_air': $!";
   
   open $fh_3g ,'<' ,$tcl_3g   or die "Cannot open '$tcl_3g' for appending: $!";
   open $fh_gsm ,'<' ,$tcl_gsm   or die "Cannot open '$tcl_gsm' for appending: $!";
   open $fh_lte ,'<' ,$tcl_lte   or die "Cannot open '$tcl_lte' for appending: $!";
   open $fh_air ,'<' ,$tcl_air   or die "Cannot open '$tcl_air' for appending: $!";
}

sub MergeScriptTclFile()
{     
    OpenFileForRead();
    
    #如果存在目标脚本文件则删除
    my $scriptFile = $out_path."\\".$scriptname.".tcl";
    unlink $scriptFile;
    
    my $fh_script;
    open $fh_script, '>', $scriptFile  or die "Cannot open '$scriptFile' for writing: $!";
    
    #按行读取case_template.tcl内容然后合并其他已写的文件为目标脚本文件  
    while ( my $line = <$fh_template> )
    {
        my ($sec,$min,$hour,$mday,$mon,$year) = (localtime)[0..5];

        ($sec,$min,$hour,$mday,$mon,$year) = (
                sprintf("%02d", $sec),
                sprintf("%02d", $min),
                sprintf("%02d", $hour),
                sprintf("%02d", $mday),
                sprintf("%02d", $mon + 1),
                $year + 1900);
                
        #my $strTime = strftime("%Y-%m-%d",localtime);
        my $strTime = "$year-$mon-$mday";
        $line =~s/xxxx-xx-xx/$strTime/;
        $line =~s/xxxxxxxx/$scriptname/;
        $line =~s/xxxx.xx/$creator/;
 
        print $fh_script $line;
      
        if ($line =~/\s*.*TD_system_information_part: begin\s*.*/)
        {
            while (my $TDLine = <$fh_3g> )
            {
                print $fh_script $TDLine;
            }        
        }
        elsif($line =~/\s*.*GSM_system_information_part: begin\s*.*/)
        {
            while (my $GSMLine = <$fh_gsm> )
            {
                print $fh_script $GSMLine;
            }      
        }
        elsif($line =~/\s*.*LTE_system_information_part: begin\s*.*/)
        {
            while (my $LTELine = <$fh_lte> )
            {
                print $fh_script $LTELine;
            }      
        }
        elsif($line =~/\s*.*Message Flow\s*.*/)
        {
            while (my $MsgFlowLine = <$fh_air> )
            {
                print $fh_script $MsgFlowLine;
            }      
        }    
    }
   
    close $fh_script;
}

sub ProcessData()
{    
    #按行读取数据文件MsgScript.txt中的数据首先提取出消息名称，如果是选中的消息则判断RAT然后写到相应的文件中去
    while ( $line = <$fh_data> ) 
    {
        #print $line;        
        #283442-1       MSG_ID_BCCH_BCH_MSG_TYPE                                MOD_LDATA->MOD_LCONTROL                         4:18:46.840     
        if ($line =~ s/\s*\d*-\d*\s*([^\s]*)\s*([^\s]*)->([^\s]*)\s*(\d*):(\d*):(\d*)\.(\d*)\s*/$1,$2,$3,$4,$5,$6,$7/)    
        {            
            $CurMsgName = $1;
            $nNo++;          
            $Sender = $2;
            $Time = ($4 * 3600 + $5*60 + $6) * 1000 + $7*1;
              
            print $CurMsgName."\r\n";
            my $result = InitMsgParam();
            if($result == 0)
            {
                next;
            }           
            
            if ($strLocalName)
            {
                GetLocalData();
            }
              
            if ($strPeerName)
            {
                GetPeerData();                
            }            
            WriteScriptFile();
        }       
    }
}


OpenScriptTclFile();
ProcessData();
MergeScriptTclFile();
CloseScriptTclFile();
DelTempTclFile();

exit 0;
