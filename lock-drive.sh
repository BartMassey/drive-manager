#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Lock encrypted backup drive.

PATH=/local/bin/drive-manager:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

if ! [ -f /mnt/backup/unmounted ] || ! [ -f /mnt/backup-tmp/unmounted ]
then
    echo "refusing to remove probably-mounted drive" >&2
    exit 1
fi

if ! [ -e /dev/mapper/backup ]
then
    echo "drive not unlocked" >&2
    exit 1
fi

sudo cryptsetup remove "/dev/mapper/backup"
