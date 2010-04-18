#!/bin/sh
# Performs a Handbook make world:
# http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/makeworld.html
KERNCONF='FILESERVER_7'
cd /usr/src/usr.sbin/mergemaster
./mergemaster.sh -p
adjkerntz -i
cd /usr/src
make -j4 buildworld
make buildkernel KERNCONF=$KERNCONF
make installkernel KERNCONF=$KERNCONF
echo "Build World, and Kernel Rebuilds Complete"
echo "Boot into Single User Mode Now, and run $HOME/bin/installworld.sh to complete upgrade"
# shutdown now
