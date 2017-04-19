ifndef MK_SOURCES_DOT_MK
MK_SOURCES_DOT_MK=		TRUE

INCLUDER_MODULES_LIST=		dirs \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

SOURCES_DOT_COMMAND=	find \
					$(DIRS_SOURCES_DIR) \
					-type \
					f | \
					grep \
						"\.$(CONFIG_DOT_FILE_EXT)$$"

ifneq ($(wildcard $(DIRS_SOURCES_DIR)), )
SOURCES_DOT_LIST=		$(shell \
					$(SOURCES_DOT_COMMAND))
else
SOURCES_DOT_LIST=
endif

endif

