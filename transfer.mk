ifndef MK_TRANSFER_MK
MK_TRANSFER_MK=				TRUE


INCLUDER_MODULES_LIST=			config \
					dirs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Should be implemented some mechanism, to watch if only h are in
#       transfer header file and only c is in transfer source file.

TRANSFER_PREFIX=			transfer

TRANSFER_ITERATOR=			$(TRANSFER_PREFIX)

TRANSFER_SRC_FILE_NAME=			$(TRANSFER_PREFIX)_$(DIRS_SOURCES_DIR).$(CONFIG_LIST_EXT)
TRANSFER_INCLUDE_FILE_NAME=		$(TRANSFER_PREFIX)_$(DIRS_INCLUDE_DIR).$(CONFIG_LIST_EXT)

TRANSFER_SRC_LIST_COMMAND=		cat \
						$(TRANSFER_SRC_FILE_NAME)

TRANSFER_INCLUDE_LIST_COMMAND=		cat \
						$(TRANSFER_INCLUDE_FILE_NAME)

TRANSFER_SRC_SED_PATTERN=		s/^.*/$(DIRS_SOURCES_DIR)\\/\&/

TRANSFER_INCLUDE_SED_PATTERN=		s/^.*/$(DIRS_INCLUDE_DIR)\\/\&/

TRANSFER_SRC_SED_COMMAND=		sed \
						$(TRANSFER_SRC_SED_PATTERN)

TRANSFER_INCLUDE_SED_COMMAND=		sed \
						$(TRANSFER_INCLUDE_SED_PATTERN)

TRANSFER_ERROR_MESSAGE=			File \
						$(REPO_DIR)/$$line \
						from \
						$(TRANSFER_SRC_FILE_NAME) \
						was \
						not \
						found \
						to \
						transfer

endif
