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

# TODO: merge into one variable: $(DIRS_OBJECTS_DIR)/$(PLATFORM)
ifeq ($(PLATFORM_COMPATIBLE_FLAG), TRUE)
OBJECTS_ASM_LIST=			$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT), \
					$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_$(SIGNATURE_ASM_OBJECT_SUFFIX), \
					$(SOURCES_ASM_LIST))

OBJECTS_ASM_FOR_TEST_LIST=	$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT), \
					$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_for_test_$(SIGNATURE_ASM_OBJECT_SUFFIX), \
					$(SOURCES_ASM_LIST))
else
OBJECTS_ASM_LIST=
endif

endif

