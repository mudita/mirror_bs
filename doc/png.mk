ifndef MK_DOC_PNG_MK
MK_DOC_PNG_MK=		TRUE

INCLUDER_MODULES_LIST=		sources \
				dirs \
				config \
				platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

#ifeq ($(PLATFORM_COMPATIBLE_FLAG), TRUE)
DOC_PNG_LIST=			$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_DOT_FILE_EXT), \
					$(DIRS_PNG_DIR)/%.$(CONFIG_PNG_FILE_EXT), \
					$(SOURCES_DOT_LIST))
#else
#DOC_PNG_LIST=
#endif

endif

