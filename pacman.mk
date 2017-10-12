ifndef MK_PACMAN_MK
MK_PACMAN_MK=			TRUE

INCLUDER_MODULES_LIST=		config \
				dirs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

PACMAN_PKGBUILD_FILE_NAME=	PKGBUILD

PACMAN_EXT=			pkg.tar.xz

PACMAN_WHOAMI_USER_ID_COMMAND=	id \
					-u

PACMAN_WHOAMI_USER_ID=		$(shell \
					$(PACMAN_WHOAMI_USER_ID_COMMAND))

PACMAN_PLATFORM_DIR=		$(DIRS_PACMAN_DIR)/$(PLATFORM)

PACMAN_PKGBUILD_FILE=		$(PACMAN_PLATFORM_DIR)/$(PACMAN_PKGBUILD_FILE_NAME)

PACMAN_TOOL_ARCHIVE_FILE=	$(PACMAN_PLATFORM_DIR)/$(SIGNATURE_TOOL_FILE_NAME).$(CONFIG_TAR_GZ_EXT)

PACMAN_PACK_LIST_COMMAND=	ls \
					$(INSTALL_PLATFORM_DIR)

PACMAN_PACK_LIST=		$(shell \
					$(PACMAN_PACK_LIST_COMMAND))

PACMAN_SUMS_LIST_COMMAND=	sha256sum \
					$(PACMAN_PLATFORM_DIR)/$* | \
				cut \
					-c-64

PACMAN_NAME_SED_PATTERN=	s\|\%PKGNAME\%\|$(SIGNATURE_TOOL_FILE_NAME)\|g
PACMAN_SOURCES_SED_PATTERN=	s\|\%SOURCE\%\|\"$*\"\|g
PACMAN_SUMS_SED_PATTERN=	\"s\|\%%SHA256SUMS\%%\|%s\|g\"\ -i\ $(PACMAN_PKGBUILD_FILE)

PACMAN_GEN_NAME_COMMAND=	sed \
					$(PACMAN_NAME_SED_PATTERN) \
					-i \
					$(PACMAN_PKGBUILD_FILE)

PACMAN_GEN_SOURCES_COMMAND=	sed \
					$(PACMAN_SOURCES_SED_PATTERN) \
					-i \
					$(PACMAN_PKGBUILD_FILE)

PACMAN_GEN_SUMS_COMMAND=	$(PACMAN_SUMS_LIST_COMMAND) | \
					xargs \
					printf \
					$(PACMAN_SUMS_SED_PATTERN) | \
					xargs \
					sed

ifneq ($(PACMAN_WHOAMI_USER_ID), 0)
PACMAN_MAKEPKG_COMMAND=		cd \
					$(PACMAN_PLATFORM_DIR) && \
				makepkg
else
PACMAN_MAKEPKG_COMMAND=
endif

endif

