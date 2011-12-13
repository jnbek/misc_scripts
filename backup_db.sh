#!/usr/bin/env bash
#===============================================================================
#
#          FILE:  backup_db.sh
# 
#         USAGE:  ./backup_db.sh password
# 
#   DESCRIPTION:  Backup all my databases one by one :)
# 
#       VERSION:  1.3-STABLE
#       CREATED:  11/28/08 11:42:00 MST
#===============================================================================
if [[ `uname` = "Linux" ]];
then
    expath="/usr/bin";
    mystat="stat -c %Y";
fi;
if [[ `uname` = "FreeBSD" ]];
then
    expath="/usr/local/bin";
    mystat="stat -f %B";
fi;
ts=`date +%s`;              # For the file timestamps
d=`date +%Y%m%d-%H%M`;      # For other uses
user="superuser";           # A Database User with Privliges on all dbs
pass="CHANGEME";            # CHANGEME
month=2592000;              # One month
#month=178200;              # 2 days For testing
dir="/files/backup/mysql/"; # Directory to store the backups
if [[ ! -d $dir ]];         # Make sure the dir exists and create if not.
then
    mkdir -p $dir;
fi;
# First let's prune the backup dir of files over a month old
cd $dir;
for l in `ls $dir`;
    do mt=`$mystat $l`;result=$(($ts-$mt));
    #echo $result;
    if  (("$result" >= "$month")); then
        echo "Deleting: $l";rm -f $l;  
    fi;     
done;
#Let's Optimize and Repair The DBs first
echo "Running Optimize and Repair";
$expath/mysqlcheck --auto-repair -u$user -p$pass -A -o
# Let's do this
echo "Creating Backups of each DataBase into $dir";
for i in `echo "show databases" | $expath/mysql -u$user -p$pass | grep -v Database`;
    do var=${i}${d};$expath/mysqldump -R -p$pass -u$user $i > $var.sql && echo $i backed up on $d; 
done;
