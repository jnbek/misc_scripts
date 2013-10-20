#!/bin/sh
# Run after the FreeBSD make world and kernel build/installs are done in makeworld.sh
# Best if run in Single User Mode.
KERNCONF='FILESERVER_8'
cd /usr/src
make installkernel KERNCONF=$KERNCONF
make installworld
cd /usr/src/usr.sbin/mergemaster
./mergemaster.sh -Ui
fastboot
