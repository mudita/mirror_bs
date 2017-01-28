ifndef MK_SOURCES_ASCIIDOC_MK
MK_SOURCES_ASCIIDOC_MK=		TRUE

INCLUDER_MODULES_LIST=		dirs \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

SOURCES_ASCIIDOC_COMMAND=	find \
					$(DIRS_SOURCES_DIR) \
					-type \
					f | \
					grep \
						"\.$(CONFIG_ASCIIDOC_FILE_EXT)$$"

ifneq ($(wildcard $(DIRS_SOURCES_DIR)), )
SOURCES_ASCIIDOC_LIST=		$(shell \
					$(SOURCES_ASCIIDOC_COMMAND))
else
SOURCES_ASCIIDOC_LIST=
endif

endif

