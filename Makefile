SRC_IMG ?= $(CURDIR)//boot.bin
RAMDISK = $(CURDIR)/ramdisk
PARTS = $(CURDIR)/parts

all: pack

help:
	@echo "make <clean pack|unpack>"

clean:
	rm -rf ramdisk parts boot.img
pack:
	./mkinitramfs ramdisk parts/boot.bin-ramdisk
	./mkimage

unpack:
	mkdir -p $(RAMDISK) $(PARTS)
	cd $(PARTS) && unpackbootimg -i $(SRC_IMG)
	cd $(RAMDISK) && zcat $(PARTS)/`basename $(SRC_IMG)`-ramdisk | cpio -i -d -H newc --no-absolute-filenames
