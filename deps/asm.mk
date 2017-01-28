ifndef MK_DEPS_ASM_MK
MK_DEPS_ASM_MK=			TRUE

INCLUDER_MODULES_LIST=		sources/asm \
				dirs \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEPS_ASM_LIST=			$(patsubst \
					$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT), \
					$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT), \
					$(SOURCES_ASM_LIST))

endif

