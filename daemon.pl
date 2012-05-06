#!/usr/bin/perl -w

use strict;
use warnings;

use Proc::Daemon;
use FindBin;

my $bp = $FindBin::RealBin;
my $pid_file = "$bp/file.pid";
my $conf_file = "/path/to/conffile";
my $abs_executable = "/path/to/executable";
my $switches = "-f";
my $exec_string = "$abs_executable $switches $conf_file";

if (-e $pid_file) {
    my $pid_number = do { local( @ARGV, $/ ) = $pid_file ; <> } ; 
    use Proc::ProcessTable;
    my $t = new Proc::ProcessTable;
    foreach my $p ( @{$t->table} ){
        if ($p->pid == $pid_number) {
            print "$abs_executable already running, exiting\n";
            exit(0);
        }   
    }   
}

my $daemon = Proc::Daemon->new(
    work_dir => $bp,
);

my $pid = $daemon->Init({
    pid_file => $pid_file,
}); 

unless ( $pid ) { 
    # code executed only by the child ...
    system($exec_string);
}
