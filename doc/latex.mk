ifndef MK_DOC_LATEX_MK
MK_DOC_LATEX_MK=		TRUE

INCLUDER_MODULES_LIST=		sources/asciidoc \
				dirs \
				config \
				platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

ifeq ($(PLATFORM_COMPATIBLE_FLAG), TRUE)
DOC_LATEX_LIST=		$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASCIIDOC_FILE_EXT), \
					$(DIRS_DOC_DIR)/%.$(CONFIG_LATEX_FILE_EXT), \
					$(SOURCES_ASCIIDOC_LIST))
else
DOC_LATEX_LIST=
endif

endif

