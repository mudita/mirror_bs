ifndef MK_OBJECTS_C_MK
MK_OBJECTS_C_MK=		TRUE

INCLUDER_MODULES_LIST=		sources/c \
				dirs \
				config \
				platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

ifeq ($(PLATFORM_COMPATIBLE_FLAG), TRUE)
OBJECTS_C_LIST=			$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT), \
					$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%.$(CONFIG_C_OBJECT_FILE_EXT), \
					$(SOURCES_C_LIST))
else
OBJECTS_C_LIST=
endif

endif

