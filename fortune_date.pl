#!/usr/bin/perl -w

use strict;
use warnings;

use POSIX;
use Sys::Hostname;

my $fortune = ""; 
my $hostname = hostname;
my $nl = "\n";
my $date = strftime("%c", localtime(time));
my $time = strftime("%X", localtime(time));
foreach my $dir (split(/:/, $ENV{'PATH'})) {
    if (-x "$dir/fortune") {
        $fortune = `$dir/fortune`;
        chomp $fortune;
        last;
    }   
}
chomp $date;
chomp $time;
my $text = [ $date, $time, $fortune, $hostname ];
my $index   = rand @{$text};
print qq{ 
    $text->[$index]
};
__END__
print qq{
    $fortune
    $nl
    $date
    $nl
   $time
}