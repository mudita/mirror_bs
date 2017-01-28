ifndef MK_PATH_MK
MK_PATH_MK=			TRUE

INCLUDER_MODULES_LIST=		relative \
				dirs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

PATH_TOOLS_DIR_PREFIX=		$(RELATIVE_ROOT_DIR)/$(DIRS_TOOLS_DIR)

# TODO: Make list of bare module names
PATH_TOOLS_ENABLED_LIST=	or1k_toolchain_newlib/$(DIRS_INSTALL_DIR)/$(DIRS_BIN_DIR)

PATH_TOOLS_PATH_LIST=		$(addprefix \
					$(PATH_TOOLS_DIR_PREFIX)/, \
					$(PATH_TOOLS_ENABLED_LIST))

PATH_EXPORT_COMMAND=		export \
					PATH=$(PATH_TOOLS_PATH_LIST):$(PATH)

endif

