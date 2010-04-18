#!/bin/sh
# Run after the FreeBSD make world and kernel build/installs are done in makeworld.sh
# Best if run in Single User Mode.
cd /usr/src
make -j4 installworld
cd /usr/src/usr.sbin/mergemaster
./mergemaster.sh -Ui
fastboot
