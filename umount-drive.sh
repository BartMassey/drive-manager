#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Unmount locked encrypted backup drive.

PATH=/local/bin/drive-manager:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

if ! [ -e /dev/mapper/backup ] ||
   ( [ -f /mnt/backup/unmounted ] && [ -f /mnt/backup-tmp/unmounted ] )
then
    echo "umount-drive: drive not mounted" >&2
    exit 1
fi

if [ ! -f /mnt/backup/unmounted ]
then
        sudo umount /mnt/backup
fi 

if [ ! -f /mnt/backup-tmp/unmounted ]
then
        sudo umount /mnt/backup-tmp
fi

exit 0
