ifndef MK_SOURCES_C_MK
MK_SOURCES_C_MK=		TRUE

INCLUDER_MODULES_LIST=		dirs \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

SOURCES_C_COMMAND=		find \
					$(DIRS_SOURCES_DIR) \
					-type \
					f | \
					grep \
						"\.$(CONFIG_C_SOURCE_FILE_EXT)$$" | \
				sort

ifneq ($(wildcard $(DIRS_SOURCES_DIR)), )
SOURCES_C_LIST=			$(shell \
					$(SOURCES_C_COMMAND))
else
SOURCES_C_LIST=
endif

endif

