#!/usr/bin/env perl
#

use strict;
use warnings;

use Data::Printer;

use BZ::Client;
use BZ::Client::Bug;
use BZ::Client::Bug::Comment;

use Net::SSLeay;
use IO::Socket::SSL;

use Encode;

# verify argument number
if(scalar(@ARGV) eq 0)
{
    die "[bugzilla_helper.pl] exec script with no params!\n";
}

# obtain oper type
my $op_type = ${ARGV[0]};
SWITCH: {
   $op_type == 1 && do { &add_comment(); last SWITCH; };
   print "Operation type is not supported!";
}

##################################################################
#
# bugzilla - add comment
#
##################################################################

sub add_comment {

  if(scalar(@ARGV) < 7)
  {
    print "Not enough params for add_comment operation!";
    return;
  }
  
  # set url
  my $url = ${ARGV[1]};
  
  # set user
  my $user = ${ARGV[2]};
  
  # set pwd
  my $pwd = ${ARGV[3]};
    
  # set bug id
  my $bug_id = ${ARGV[4]};

  # set comment file path
  my $comment_file = ${ARGV[5]};
  my $comment_text;

  # 1. read file data in raw mode
  # 2. decode data to utf-8 format
  open READ, "<:raw", $comment_file;
  my @linelist = <READ>;
  my $eachline;  
  foreach $eachline(@linelist){
	  $comment_text .= decode('utf-8', $eachline);
  }
  close READ;

  # set private
  my $private = ${ARGV[6]};

  # new BZ Client
  my $bz = BZ::Client->new(
   #'api_key' => 'tJjrPNK8KcJBuwY9m5IHvVIX7B51CregdRDVoMUE',
   url => $url,
   'user' => $user,
   'password' => $pwd,
   #logDirectory => '.\\',
  );

  eval {  
      my $comment_id = BZ::Client::Bug::Comment->add( $bz,
      {
        id => $bug_id,
        comment => $comment_text,
        is_private => $private
      } );

      #p $comment_id;
  };

  if ($@) {
    print $@->message();
    # say 'An Error Occured';
    # say 'Message: ', $@->message();
    # say 'HTTP Code: ', $@->http_code() if $@->http_code();
    # say 'XMLrpc Code: ', $@->xmlrpc_code() if $@->xmlrpc_code();
  }
  else
  {
    print "Operation successed!";
  }
}