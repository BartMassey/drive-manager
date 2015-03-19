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
