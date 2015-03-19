# Copyright © 2015 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Installer for drive manager

DEST=/usr/local/bin/drive-manager
TOOLS = locate-drive mount-usb umount-usb mount-drive umount-drive \
	lock-drive unlock-drive check-drive

install:
	mkdir -p $(DEST)
	for TOOL in $(TOOLS); do \
		cp $$TOOL $(DEST)/ ;\
		chmod 755 $(DEST)/$$TOOL ;\
	done
