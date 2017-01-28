ifndef MK_DEPS_CPP_MK
MK_DEPS_CPP_MK=			TRUE

INCLUDER_MODULES_LIST=		sources/cpp \
				dirs \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEPS_CPP_LIST=			$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_CPP_SOURCE_FILE_EXT), \
					$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT), \
					$(SOURCES_CPP_LIST))

endif

