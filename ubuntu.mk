ifndef MK_UBUNTU_MK
MK_UBUNTU_MK=		TRUE

INCLUDER_MODULES_LIST=		platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Supported Long Term Support (LTS) versions (currently not tested):
#       * Ubuntu Server 10.04 LTS: lucid
#       * Ubuntu Server 12.04 LTS: precise
#       * Ubuntu Server 14.04 LTS: trusty
#       * Ubuntu Server 16.04 LTS: xenial

UBUNTU_VERSION=			xenial
UBUNTU_SQUASHFS_EXT=		squashfs

# TODO: Should be standarized and moved to configuration file od dirs.
UBUNTU_KERNEL_DIR=		$(PLATFORM_QEMU)/kernel
UBUNTU_INITRD_DIR=		$(PLATFORM_QEMU)/initrd
UBUNTU_SQUASHFS_DIR=		$(PLATFORM_QEMU)/squashfs

UBUNTU_SERVER=			https://cloud-images.ubuntu.com
UBUNTU_BASE_URL=		$(UBUNTU_SERVER)/$(UBUNTU_VERSION)/current
UBUNTU_URL=			$(UBUNTU_BASE_URL)/unpacked

UBUNTU_KERNEL_FILE=		$(UBUNTU_VERSION)-server-cloudimg-$(PLATFORM_UBUNTU)-vmlinuz-$(PLATFORM_UBUNTU_KERNEL_SUFFIX)
UBUNTU_KERNEL_URL=		$(UBUNTU_URL)/$(UBUNTU_KERNEL_FILE)
# TODO: Should be standarized and moved to configuration file od dirs.
UBUNTU_KERNEL_PATH=		$(UBUNTU_KERNEL_DIR)/$(UBUNTU_KERNEL_FILE)

UBUNTU_INITRD_FILE=		$(UBUNTU_VERSION)-server-cloudimg-$(PLATFORM_UBUNTU)-initrd-$(PLATFORM_UBUNTU_INITRD_SUFFIX)
UBUNTU_INITRD_URL=		$(UBUNTU_URL)/$(UBUNTU_INITRD_FILE)
# TODO: Should be standarized and moved to configuration file od dirs.
UBUNTU_INITRD_PATH=		$(UBUNTU_INITRD_DIR)/$(UBUNTU_INITRD_FILE)

UBUNTU_SQUASHFS_FILE=		xenial-server-cloudimg-$(PLATFORM_UBUNTU).$(UBUNTU_SQUASHFS_EXT)
UBUNTU_SQUASHFS_URL=		$(UBUNTU_BASE_URL)/$(UBUNTU_SQUASHFS_FILE)
# TODO: Should be standarized and moved to configuration file od dirs.
UBUNTU_SQUASHFS_PATH=		$(UBUNTU_SQUASHFS_DIR)/$(UBUNTU_SQUASHFS_FILE)

endif

