#!/usr/bin/perl

#use File::Spec;

if(scalar(@ARGV)!= 6)
{
	die "[ndecode.pl] param error, number of params at least is 6\n";
}

#=head
my $pi = 0;
for($pi = 0; $pi<scalar(@ARGV); $pi++)
{
	print "${ARGV[$pi]} ";
}
print "\n";
#=cut

my $protocol_type = ${ARGV[0]};
my $key_str = ${ARGV[1]};
my $pp_file = ${ARGV[2]};
my $tshark_path = ${ARGV[3]};
my $peer_data = ${ARGV[4]};
my $out_file = ${ARGV[5]};

my %hash = ();
my $tag="";

CreateHash();

#if($protocol_type == "TD")
#{
#	$protocol_type = "WCDMA";
#}

print "$protocol_type";
print "$key_str";

if( exists $hash{$protocol_type}{$key_str} )
{	
	$tag =  $hash{$protocol_type}{$key_str};
	$tag = $tag;
	print "\n";
	print "find tag: $tag";
	print "\n";
}
else
{
	print "\nnot found!\n";
	exit 1;
}

print "\n\"$tshark_path\" -o \"uat:user_dlts:\\\"User 15 (DLT=162)\\\",\\\"$tag\\\",\\\"0\\\",\\\"\\\",\\\"0\\\",\\\"\\\"\" -r \"$peer_data\" -V > \"$out_file\"\n";
system "\"$tshark_path\" -o \"uat:user_dlts:\\\"User 15 (DLT=162)\\\",\\\"$tag\\\",\\\"0\\\",\\\"\\\",\\\"0\\\",\\\"\\\"\" -r \"$peer_data\" -V > \"$out_file\"";

exit 0;


sub CreateHash
{	
	#$key_str = uc($key_str );
	$protocol_type = uc($protocol_type);
	
	#my $pp_file = File::Spec->rel2abs($0);
	$pp_file=~s/\\/\//g;
	#$pp_file=~s/(.*\/)[^\/]*/$1src_3gpp.txt/g;
	
	open(DEF, "<$pp_file") or die "Can not open $pp_file\n" ;
	
	my $cur_type = "WCDMA";
	my $cur_tag = "";
	my $cur_str = "";
	
	while($line = <DEF>)
	{
		my @fields = split "," , $line;
		$cur_type = $fields[0];
		$cur_str = $fields[1];
		$cur_tag = $fields[2];
		chomp $cur_tag;
		
		print "$cur_type,$cur_str,$cur_tag \n" ;
		
		
		$line =~ s/ //g; #remove space
			
		$line =~ s/[^:]*:([^:]*)/$1/g; #remove space
			
		$hash{$cur_type}{$cur_str} = $cur_tag;
	}	
	close(DEF);	
}


sub Usage
{
	print "\ndecode.pl protocol_type key_str src_3gpp tshark_path peer_data outfile\n";
	print "protocol_type: LTE, WCDMA, GSM, TD\n";
}