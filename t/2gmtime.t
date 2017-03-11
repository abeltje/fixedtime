#! perl
use warnings;
use strict;
use Data::Dumper; $Data::Dumper::Indent = 1;

use Test::More tests => 5;

use constant EPOCHOFFSET => 1204286400; # 29 Feb 2008 12:00:00 GMT

my @cgtime = gmtime;
my @fgtime = ( 0, 0, 12, 29, 1, 108, 5, 59, 0 );
{
    use fixedtime epoch_offset => EPOCHOFFSET;
    my @ftime = gmtime;
    is_deeply \@ftime, \@fgtime, "gmtime() is fixed (@{[ scalar gmtime ]})"
        or diag Dumper \@ftime;

    { # nested calls should update the fixed stamp
        use fixedtime epoch_offset => 1204286400 + 60 * 60;
        my @fltime = @fgtime; $fltime[2] += 1;
        my @ltime = gmtime;
        is_deeply \@ltime, \@fltime, "gmtime() in scope (@{[ scalar gmtime ]})"
            or diag Dumper \@ltime;
    }

    @ftime = gmtime;
    is_deeply \@ftime, \@fgtime, "gmtime() is back  (@{[ scalar gmtime ]})"
        or diag Dumper \@ftime;


    no fixedtime;
    use Time::Local;
    my $gtime = timegm(gmtime());
    my $cgtime = timegm(@cgtime);
    cmp_ok($gtime - $cgtime, '<=', 1, "test should't take longer than 1 sec");
}
my @gtime = gmtime;
my $gsec = shift @gtime;
my $cgsec = shift @cgtime;

is_deeply \@gtime, \@cgtime, "times compare (@{[ scalar gmtime ]})"
    or diag Dumper \@gtime;
