#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Check encrypted backup drive.

MODE=false
if [ $# -gt 0 ]
then
    MODE=true
fi

if [ -d /mnt/backup/dirvish ]
then
    echo "check-drive: backup directory mounted, giving up" >&2
    exit 1
fi

CDEV=`sudo unlock-drive -n` &&
if $MODE
then
    sudo /sbin/fsck.jfs "$@" $CDEV
else
    sudo /sbin/fsck.jfs -p $CDEV
fi
