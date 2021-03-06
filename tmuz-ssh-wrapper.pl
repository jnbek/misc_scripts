#!/usr/bin/perl -w
# SSH Wrapper script for tmux.
# Installation: Copy to $HOME/bin and chmod 755.
# Usage: Fill the $hosts hashref with desired ssh hosts. 
# In tmux, press Ctrl+X then s. At the prompt enter the 
# hashref key of the host your wish to connect to.
# Example: ^Xs
# Enter host: fqdn
# will ssh to my.fqdn.com

use strict;
use warnings;
my $hosts = { 
    fqdn => 'my.fqdn.com',
    nextfqdn => 'next.fqdn.com',
    lastfqdn => 'last.fqdn.com',
};
my $host = $hosts->{$ARGV[0]};
system("/usr/bin/ssh $host");
exit;
