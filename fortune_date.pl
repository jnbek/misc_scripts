#!/usr/bin/perl -w
use strict;
use warnings;
use POSIX;
my $fortune = "";
my $nl = "\n";
my $date = strftime("%c", localtime(time));
my $time = strftime("%x", localtime(time));
foreach my $dir (split(/:/, $ENV{'PATH'})) {
    if (-x "$dir/fortune") {
        $fortune = `$dir/fortune`;
        chomp $fortune;
        last;
    }
}
chomp $date;
print qq{
    $fortune
    $nl
    $date
    $nl
    $time
};
