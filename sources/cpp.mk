ifndef MK_SOURCES_CPP_MK
MK_SOURCES_CPP_MK=		TRUE

INCLUDER_MODULES_LIST=		dirs \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

SOURCES_CPP_COMMAND=		find \
					$(DIRS_SOURCES_DIR) \
					-type \
					f | \
					grep \
						"\.$(CONFIG_CPP_SOURCE_FILE_EXT)$$" | \
					sort

ifneq ($(wildcard $(DIRS_SOURCES_DIR)), )
SOURCES_CPP_LIST=		$(shell \
					$(SOURCES_CPP_COMMAND))
else
SOURCES_CPP_LIST=
endif

endif

