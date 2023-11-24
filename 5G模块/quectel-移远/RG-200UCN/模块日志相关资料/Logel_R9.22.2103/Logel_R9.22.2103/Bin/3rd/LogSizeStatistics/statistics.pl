#!/usr/bin/perl

#use File::Spec;

if(scalar(@ARGV)!= 1)
{
    die "[statistics.pl] param error, number of params at least is 1\n";
}

#=head
my $pi = 0;
for($pi = 0; $pi<scalar(@ARGV); $pi++)
{
    print "${ARGV[$pi]} ";
}
print "\n";
#=cut

my $org_file = ${ARGV[0]};

my %trace_hash = (
    "ATC"          => "L4",
    "SIM"          => "L4",
    "MN_AL"        => "L4",
    "MNC"          => "L4",
    "MNM"          => "L4",
    "SIP"          => "IMS",
    "ISI"          => "IMS",
    "VPR"          => "IMS",
    "CSM"          => "IMS",
    "VE"           => "IMS",
    "SUPSRV"       => "IMS",
    "CSM_CALL"     => "IMS",
    "MC"           => "IMS",
    "SAPP"         => "IMS",
    "CC"           => "NAS",
    "SM"           => "NAS",
    "SMS"          => "NAS",
    "SS"           => "NAS",
    "MM"           => "NAS",
    "LNAS"         => "NAS",
    "PLM"          => "NAS",
    "RABM"         => "NAS",
    "NAS_SWTH"     => "NAS",
    "GAS"          => "GAS",
    "GL1"          => "GAS",
    "WPS_WRCC"     => "WAS",
    "WPS_WRRC"     => "WAS",
    "WL2"          => "WAS",
    "WL1_DRV"      => "WL1",
    "WL1_GKI"      => "WL1",
    "WL1_HAL"      => "WL1",
    "WL1_MEAS_RPT" => "WL1",
    "WL1_WL1C"     => "WL1",
    "RRCC"         => "TAS",
    "RRCD"         => "TAS",
    "RRCA"         => "TAS",
    "TL2"          => "TAS",
    "TL1"          => "TAS",
    "LRRC"         => "LAS",
    "LL2"          => "LAS",
    "ROHC"         => "LAS",
    "DSM"          => "DSM",
    "SDI"          => "SDI",
    "GLOBAL"       => "GLOBAL",
);

my %msg_hash=(
    "MOD_CC_1"            => "NAS",
    "MOD_CC_2"            => "NAS",
    "MOD_SS_1"            => "NAS",
    "MOD_SS_2"            => "NAS",
    "MOD_SMS_1"           => "NAS",
    "MOD_SMS_2"           => "NAS",
    "MOD_CBMC"            => "WAS",
    "MOD_SM"              => "NAS",
    "MOD_GMM_1"           => "NAS",
    "MOD_GMM_2"           => "NAS",
    "MOD_MM_1"            => "NAS",
    "MOD_MM_2"            => "NAS",
    "MOD_EMM"             => "NAS",
    "MOD_EMM_1"           => "NAS",
    "MOD_EMM_2"           => "NAS",
    "MOD_PLM_1"           => "NAS",
    "MOD_PLM_2"           => "NAS",
    "MOD_NAS_SWTH"        => "NAS",
    "MOD_NAS_SWTH_1"      => "NAS",
    "MOD_NAS_SWTH_2"      => "NAS",
    "MOD_MN_AL_1"         => "L4",
    "MOD_MN_AL_2"         => "L4",
    "MOD_SIM_1"           => "L4",
    "MOD_SIM_2"           => "L4",
    "MOD_MMI"             => "L4",
    "MOD_MNM_1"           => "L4",
    "MOD_MNM_2"           => "L4",
    "MOD_APP_1"           => "L4",
    "MOD_APP_2"           => "L4",
    "MOD_MNMGPRS_1"       => "L4",
    "MOD_MNMGPRS_2"       => "L4",
    "MOD_MNMSMS_1"        => "L4",
    "MOD_MNMSMS_2"        => "L4",
    "MOD_MNMCALL_1"       => "L4",
    "MOD_MNMCALL_2"       => "L4",
    "MOD_MNMPHONE_1"      => "L4",
    "MOD_MNMPHONE_2"      => "L4",
    "MOD_RAC_1"           => "L4",
    "MOD_RAC_2"           => "L4",
    "MOD_MNC_1"           => "L4",
    "MOD_MNC_2"           => "L4",
    "MOD_ATPP"            => "L4",
    "MOD_AL"              => "L4",
    "MOD_DUMMY_MMI"       => "L4",
    "MOD_SSI_1"           => "L4",
    "MOD_SSI_2"           => "L4",
    "MOD_SAT"             => "L4",
    "MOD_APP_READER"      => "L4",
    "MOD_RR_1"            => "GAS",
    "MOD_RR_2"            => "GAS",
    "MOD_GMAC"            => "GAS",
    "MOD_LAPDM"           => "GAS",
    "MOD_GSM_GPRS"        => "GAS",
    "MOD_GRR_1"           => "GAS",
    "MOD_GRR_2"           => "GAS",
    "MOD_GRRLP_1"         => "GAS",
    "MOD_GRRLP_2"         => "GAS",
    "MOD_GRLC"            => "GAS",
    "MOD_RRM"             => "GAS",
    "MOD_REASM"           => "GAS",
    "MOD_GLLC"            => "GAS",
    "MOD_MPAL"            => "GAS",
    "MOD_MPAL_READER"     => "GAS",
    "LAST_GPRS_MOD_ID"    => "GAS",
    "MOD_GDL"             => "GAS",
    "MOD_GSCT"            => "GAS",
    "MOD_GLAYER1"         => "GAS",
    "MOD_GL1SIM"          => "GAS",
    "MOD_GRRA"            => "GAS",
    "MOD_RABM"            => "TAS",
    "MOD_RLC"             => "TAS",
    "MOD_PDCP"            => "TAS",
    "MOD_MAC"             => "TAS",
    "MOD_RRC_ADAPTER"     => "TAS",
    "MOD_RRCC"            => "TAS",
    "MOD_RRCD"            => "TAS",
    "MOD_RRC"             => "TAS",
    "MOD_RRC_1"           => "TAS",
    "MOD_RRC_2"           => "TAS",
    "MOD_L1C"             => "TAS",
    "MOD_LTE"             => "LAS",
    "MOD_LASM"            => "LAS",
	"MOD_LASM_1"          => "LAS",
    "MOD_LASM_2"          => "LAS",
    "MOD_LCONTROL"        => "LAS",
    "MOD_LDATA"           => "LAS",
    "MOD_LGRANT"          => "LAS",
    "MOD_LHAL_SERVE"      => "LAS",
    "MOD_LLAYER1_ADX"     => "LAS",
    "MOD_LL1SIM"          => "LAS",
    "MOD_LDUMMYPS"        => "LAS",
    "MOD_LCS_1"           => "LAS",
    "MOD_LCS_2"           => "LAS",
    "MOD_LRRCA"           => "LAS",
    "MOD_WRRCA"           => "WAS",
    "MOD_WL2"             => "WAS",
    "MOD_WL2TX"           => "WAS",
    "MOD_WRRC_1"          => "WAS",
    "MOD_WRRC_2"          => "WAS",
    "MOD_WDUMMYPS"        => "WAS",
    "MOD_WTC"             => "WAS",
    "MOD_WPDCP"           => "WAS",
    "MOD_WPXY0"           => "WAS",
    "MOD_WPXY1"           => "WAS",
    "MOD_WPXY2"           => "WAS",
    "MOD_WPXY3"           => "WAS",
    "MOD_WPXY4"           => "WAS",
    "MOD_WPXYT"           => "WAS",
    "MOD_WRX"             => "WAS",
    "MOD_WTX"             => "WAS",
    "MOD_WNS"             => "WAS",
    "MOD_WCHAN"           => "WAS",
    "MOD_WLB"             => "WAS",
    "MOD_WSRCH"           => "WAS",
    "MOD_WFNG"            => "WAS",
    "MOD_WXDSP"           => "WAS",
    "MOD_WRFCL"           => "WAS",
    "MOD_WFAKEWPS"        => "WAS",
    "MOD_WFAKEWL1"        => "WAS",
    "MOD_WRCC_1"          => "WAS",
    "MOD_WRCC_2"          => "WAS",
    "MOD_WOP"             => "WAS",
    "MOD_DUMMY_IMS"       => "IMS",
    "MOD_CSM"             => "IMS",
    "MOD_CSM_PRI"         => "IMS",
    "MOD_ISI_APP"         => "IMS",
    "MOD_ISI_PRO"         => "IMS",
    "MOD_SAPP_IPC"        => "IMS",
    "MOD_SAPP_EVT"        => "IMS",
    "MOD_SAPP_TMR"        => "IMS",
    "MOD_SUPSRV"          => "IMS",
    "MOD_SIP_NIC"         => "IMS",
    "MOD_MC_EVT_GLOBAL"   => "IMS",
    "MOD_MC_EVT_VIDEO"    => "IMS",
    "MOD_MC_EVT_INFCO"    => "IMS",
    "MOD_MC_CMD"          => "IMS",
    "MOD_RIR"             => "IMS",
    "MOD_ISIM"            => "IMS",
    "MOD_MGT"             => "IMS",
    "MOD_ISI_CSM_EVT"     => "IMS",
    "MOD_ISI_SRV"         => "IMS",
    "MOD_ISI_EVT"         => "IMS",
    "MOD_LPP_1"           => "LPP",
    "MOD_LPP_2"           => "LPP",
    "MOD_WL1"             => "WL1",
    "MOD_WL1Meas"         => "WL1",
    "MOD_WL1SIM"          => "WL1",
    "MOD_DSM"             => "DSM",
    "MOD_NVM"             => "NV",
    "MOD_LTWOH"           => "OTHER",
    "MOD_CDH"             => "OTHER",
    "MOD_CL"              => "OTHER",
    "MOD_SDB"             => "OTHER",
    "MOD_DRIVER"          => "OTHER",
    "MOD_CL_READER"       => "OTHER",
    "MOD_TIMER"           => "TIMER",
    "MOD_LINK_READER"     => "OTHER",
    "MOD_LINK"            => "OTHER",
    "MOD_RMPC_1"          => "OTHER",
    "MOD_RMPC_2"          => "OTHER",
    "MOD_CSRR"            => "OTHER",
    "MOD_GSNDCP"          => "OTHER",
    "MOD_DATA"            => "OTHER",
    "MOD_TDT"             => "OTHER",
    "MOD_RLP"             => "OTHER",
    "MOD_L2R"             => "OTHER",
    "MOD_L1SIM"           => "OTHER",
    "MOD_L1SIM_READER"    => "OTHER",
    "MOD_SIM_SIMU_HW"     => "OTHER",
    "MOD_TC_RLC"          => "OTHER",
    "MOD_TC_RLC_TM"       => "OTHER",
    "MOD_DUMY_SPCH_APP"   => "OTHER",
    "MOD_TC_PDCP"         => "OTHER",
    "MOD_PAL"             => "OTHER",
    "MOD_XCAP"            => "OTHER",
    "MOD_GBA"             => "OTHER",
    "MOD_GBAM"            => "OTHER",
    "MOD_HTTP_DAPS"       => "OTHER",
    "MOD_TXAPC"           => "OTHER",
    "LAST_3G_MOD_ID"      => "OTHER",
    "LAST_MOD_ID"         => "OTHER",
    "MOD_AS"              => "OTHER"
);

my %statistics_hash = ();
my %group_hash = ();

$org_file=~s/\\/\//g;

open(ORGFILE, "<$org_file") or die "Can not open $org_file\n" ;

while($line = <ORGFILE>)
{
    $line =~ s/\s*//g; #remove space
    my @cols = split "," , $line;
    my $cur_type = $cols[0];
    my $cur_mode = $cols[1];
    my $cur_size = $cols[2];
    chomp $cur_size;
    
    if(($cur_type eq "MSG" || $cur_type eq "TRACE") && !($cur_mode eq "Total") )
    {
        my $group = "UNKNOWN";
        if($cur_type eq "MSG")
        {
            if(exists $msg_hash{$cur_mode})
            {
                $group = $msg_hash{$cur_mode};              
            }
        }
        else
        {
            if(exists $trace_hash{$cur_mode})
            {
                $group = $trace_hash{$cur_mode};                
            }     
        }
      
        if(exists $statistics_hash{$cur_type}{$group})
        {
            $statistics_hash{$cur_type}{$group} += $cur_size + 0;
        }
        else
        {
            $statistics_hash{$cur_type}{$group} = $cur_size + 0;
        }         
        
        if(exists $group_hash{$group})
        {
            $group_hash{$group} += $cur_size + 0;
        }
        else
        {
            $group_hash{$group} = $cur_size + 0;
        }  
    }   
}   

close(ORGFILE); 


open(ORGFILE, ">>$org_file") or die "Can not open $org_file\n" ;

print ORGFILE ",,\r\n";


foreach my $type (keys %statistics_hash)
{
    next if $type eq "";        
    my $subhash = $statistics_hash{$type};
    foreach my $group (keys %$subhash)
    {
        next if $group eq "";
        
        print ORGFILE $type."_GROUP,".$group.",".$statistics_hash{$type}{$group}."\n";
        
        print $type."_GROUP,".$group.",".$statistics_hash{$type}{$group}."\n";
    }
}

print ORGFILE ",,\r\n";


foreach my $group (keys %group_hash)
{
    next if $group eq "";
    
    print ORGFILE "MSG&TRACE_GROUP,".$group.",".$group_hash{$group}."\n";
    
    print "MSG&TRACE_GROUP,".$group.",".$group_hash{$group}."\n";
}


close(ORGFILE);



