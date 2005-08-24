use strict;
use Test;

BEGIN { plan tests => 5 }
use Log::SimpleLog;

  # First, we will test to make sure that the
  # object can even be instantiated
my $logger = new Log::SimpleLog ( 'test.log' );
my $test = ( defined ( $logger ) ) ? 1 : 0;
ok ( $test );  # Should be '1'

  # Now, we will attempt to write to the log, interpret
  # and test the data 
my $test_data = 'testtestsetes';
$logger->log_message ( $test_data );
$logger = undef;
open FILE , './test.log';
while ( <FILE> ) {
    ok ( $_ , qr/$test_data/ );
    last;
}
close FILE;

  # Next, we will try to see if we can append that data with
  # an invalid portion of data
my $new_test = undef;
$logger = new Log::SimpleLog ( 'test.log' );
$logger->log_message ( $new_test );
$logger = undef;
open FILE , './test.log';
my @lines = <FILE>;
close FILE;
$test = ( scalar ( @lines ) == 2 ) ? 1 : 0;
ok ( $test );

  # Now we will remove the log, destroy the log object 
  # and test for all of the above
$test = ( -r './test.log' ) ? 1 : 0;
ok ( $test );
unlink ( './test.log' );
$test = ( -r './test.log' ) ? 0 : 1;
ok ( $test );
