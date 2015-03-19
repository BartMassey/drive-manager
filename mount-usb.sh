#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Mount usb storage device.

PGM="`basename $0`"
USAGE="$PGM: usage: $PGM [-q] [-c] [-v] [-n] \\
 [-m <mount-point>] [-o <mount-opts>] \\
 [-d <drives-file>] <device-class>"

MOUNT_POINT=/mnt/usb
VERBOSE=false
FAKE=false
ENSURE_ONLY=false
CLASSES_ONLY=""
DRIVES_FILE=""
WANT_CLASS=""

while [ $# -gt 0 ]
do
  case "$1" in
  -q) ENSURE_ONLY=true; shift ;;
  -m) MOUNT_POINT="$2" ; shift 2 ;;
  -o) MOUNT_OPTS="$2" ; shift 2 ;;
  -d) DRIVES_FILE="-d \"$2\"" ; shift 2 ;;
  -c) CLASSES_ONLY="-c" ; shift ;;
  -v) VERBOSE=true; shift ;;
  -n) FAKE=true; shift ;;
  -*) echo "$USAGE" >&2 ; exit 1 ;;
  *)  break 2 ;;
  esac
done
case $# in
0) ;;
1) WANT_CLASS="$1" ;;
*) echo "$USAGE" >&2
   exit 1 ;;
esac

if [ ! -f "$MOUNT_POINT"/unmounted ]
then
    if $ENSURE_ONLY
    then
	exit 0
    fi
    if ! $FAKE
    then
        echo "device already mounted" >&2
        exit 1
    fi
fi

DISK_DEV="`locate-drive -q $CLASSES_ONLY $DRIVES_FILE $WANT_CLASS`"
if [ $? -ne 0 ]
then
    echo "$PGM: no device found" >&2
    exit 1
fi

if $FAKE || $VERBOSE
then
    echo mount "$RDEV_NAME ($CLASS)"
fi
( $FAKE || sudo /bin/mount -o "$MOUNT_OPTS" "$DISK_DEV" "$MOUNT_POINT" ) &&
exit 0

if [ -f "$MOUNT_POINT"/unmounted ]
then
    echo "$PGM: no device mounted" >&2
fi
exit 1
