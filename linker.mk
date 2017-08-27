ifndef MK_LINKER_MK
MK_LINKER_MK=			TRUE

#INCLUDER_MODULES_LIST=		install \
#				platform \
#				config \
#				unit_test

INCLUDER_MODULES_LIST=		config \
				platform \
				dirs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

LINKER_PREFIX=			-T

LINKER_PLATFORM_FILE=		$(DIRS_LINKER_DIR)/$(PLATFORM).$(CONFIG_LD_EXT)

LINKER_PLATFORM_FILE_EXISTENCE=	$(wildcard \
					$(LINKER_PLATFORM_FILE))

ifneq ($(LINKER_PLATFORM_FILE_EXISTENCE), )
LINKER_SCRIPT_FLAGS=		$(addprefix \
					$(LINKER_PREFIX) , \
					$(LINKER_PLATFORM_FILE))
else
LINKER_SCRIPT_FLAGS=
endif

endif

