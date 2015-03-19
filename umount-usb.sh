#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Umount usb storage device.

if [ -f /mnt/usb/unmounted ]
then
	echo "/mnt/usb already unmounted" >&2
	exit 1
fi

sudo /bin/umount /mnt/usb
