ifndef MK_OBJECTS_CPP_MK
MK_OBJECTS_CPP_MK=		TRUE

INCLUDER_MODULES_LIST=		sources/cpp \
				dirs \
				config \
				platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

ifeq ($(PLATFORM_COMPATIBLE_FLAG), TRUE)
OBJECTS_CPP_LIST=		$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_CPP_SOURCE_FILE_EXT), \
					$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%.$(CONFIG_CPP_OBJECT_FILE_EXT), \
					$(SOURCES_CPP_LIST))
else
OBJECTS_CPP_LIST=
endif

endif

