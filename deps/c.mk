ifndef MK_DEPS_C_MK
MK_DEPS_C_MK=			TRUE

INCLUDER_MODULES_LIST=		sources/c \
				dirs \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEPS_C_LIST=			$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT), \
					$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT), \
					$(SOURCES_C_LIST))

endif

