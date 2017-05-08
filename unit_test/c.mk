ifndef MK_UNIT_TEST_C_MK
MK_UNIT_TEST_C_MK=		TRUE

INCLUDER_MODULES_LIST=		sources/c \
				dirs \
				config \
				platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

UNIT_TEST_C_SUFFIX=		test.$(CONFIG_C_SOURCE_FILE_EXT)

ifeq ($(PLATFORM_COMPATIBLE_FLAG), TRUE)
UNIT_TEST_C_LIST=		$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT), \
					$(DIRS_UNIT_TEST_DIR)/%_$(UNIT_TEST_C_SUFFIX), \
					$(SOURCES_C_LIST))
else
UNIT_TEST_C_LIST=
endif

endif

