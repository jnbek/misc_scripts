#!/bin/zsh
mkdir /tmp/makepsx
cd /tmp
cdrdao read-cd --read-raw --datafile my_game_rip.bin --device /dev/sr0 --driver generic-mmc-raw my_game_rip.toc
toc2cue my_game_rip.toc my_game_rip.cue
bin2iso my_game_rip.cue
echo "Copy /tmp/makepsx/my_game_rip-01.iso to your desired location and rm -rfv /tmp/makepsx."
