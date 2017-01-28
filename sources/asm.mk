ifndef MK_SOURCES_ASM_MK
MK_SOURCES_ASM_MK=		TRUE

INCLUDER_MODULES_LIST=		dirs \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

SOURCES_ASM_COMMAND=		find \
					$(DIRS_SOURCES_DIR) \
					-type \
					f | \
					grep \
						"\.$(CONFIG_ASM_SOURCE_FILE_EXT)$$"

ifneq ($(wildcard $(DIRS_SOURCES_DIR)), )
SOURCES_ASM_LIST=		$(shell \
					$(SOURCES_ASM_COMMAND))
else
SOURCES_ASM_LIST=
endif

endif

