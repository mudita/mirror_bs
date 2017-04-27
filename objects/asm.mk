ifndef MK_OBJECTS_ASM_MK
MK_OBJECTS_ASM_MK=		TRUE

INCLUDER_MODULES_LIST=		sources/asm \
				dirs \
				config \
				platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

ifeq ($(PLATFORM_COMPATIBLE_FLAG), TRUE)
OBJECTS_ASM_LIST=		$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT), \
					$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%.$(CONFIG_ASM_OBJECT_FILE_EXT), \
					$(SOURCES_ASM_LIST))
else
OBJECTS_ASM_LIST=
endif

endif

