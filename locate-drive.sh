#!/bin/sh
# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Locate drive in drives file.

PGM="`basename $0`"
USAGE="$PGM: usage: $PGM [-c] [-d <drives-file>] [<device-class>]"

CLASSES_ONLY=false
DRIVES_FILE=/usr/local/etc/drives
DEV_DIR=/dev
DISK_DIR="$DEV_DIR"/disk/by-id
QUIET=false

TMP=/tmp/locate-usb.$$
trap "rm -f $TMP" 0 1 2 3 15

while [ $# -gt 0 ]
do
  case "$1" in
  -d) DRIVES_FILE="$2" ; shift 2 ;;
  -c) CLASSES_ONLY=true ; shift ;;
  -q) QUIET=true ; shift ;;
  -*) echo "$USAGE" >&2 ; exit 1 ;;
  *)  break 2 ;;
  esac
done
case $# in
0) WANT_CLASS='*' ;;
1) WANT_CLASS="$1" ;;
*) echo "$USAGE" >&2
   exit 1 ;;
esac

if $CLASSES_ONLY
then
  egrep -v '^[ 	]*(#.*|)$' $DRIVES_FILE |
  awk '{print $1;}' | sort | uniq |
  sed '/^\*$/d'
  exit 0
fi

egrep -v '^[ 	]*(#.*|)$' $DRIVES_FILE >$TMP
STATUS=1
while read CLASS DEV_NAME
do
  RDEV_NAME="$DISK_DIR/$DEV_NAME"
  if [ -e "$RDEV_NAME" ]
  then
      if [ "$CLASS" = '*' ] ||
         [ "$CLASS" = "$WANT_CLASS" ] ||
         ( [ "$WANT_CLASS" = '*' ] && [ "$CLASS" != "backup" ] )
      then
          echo "$RDEV_NAME"
          exit 0
      fi
  fi
done <$TMP

if ! $QUIET
then
    echo "$PGM: no device" >&2
fi
exit 1
