ifndef MK_DEFINES_MK
MK_DEFINES_MK=			TRUE

INCLUDER_MODULES_LIST=		install \
				platform \
				config \
				unit_test

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEFINES_PREFIX=			-D

# INFO: Do not use quotations ("), use apostrophes instead (').
#DEFINES_DEFAULT_LIST=		BARE_DEFINE_NAME='bare_define_value'

# TODO: Add defines from files with metaprograming ability (makefile variables
#       enabled in defines file). Currently compiler version cannot be
#       generated or taken from build system script.
DEFINES_DEFAULT_LIST=		ETRACE_IF_CHRONOGRAPH_COMMAND='chronograph_gcc_7_1_1_x86_64_pc_linux_gnu' \
				CPU_LOGS_CHRONOGRAPH_COMMAND='chronograph_gcc_7_1_1_x86_64_pc_linux_gnu' \
				USE_STDPERIPH_DRIVER \
				OS_USE_SEMIHOSTING

ifeq ($(UNIT_TEST), 1)
DEFINES_DEFAULT_LIST+=		UNIT_TEST_ENTRY_POINT=$(UNIT_TEST_ENTRY_POINT)
endif

DEFINES_SPECYFIC_EXISTENCE=	$(wildcard \
					$(CONFIG_DEFINES_FILE_NAME))

ifneq ($(DEFINES_SPECYFIC_EXISTENCE), )
DEFINES_SPECYFIC_LIST_COMMAND=	cat \
					$(CONFIG_DEFINES_FILE_NAME)

DEFINES_SPECYFIC_LIST=		$(shell \
					$(DEFINES_SPECYFIC_LIST_COMMAND))

DEFINES_DEFAULT_LIST+=		$(DEFINES_SPECYFIC_LIST)
endif

# INFO: Each bare define gets define prefix here.
DEFINES_LIST=			$(patsubst \
					%, \
					$(DEFINES_PREFIX) %, \
					$(DEFINES_DEFAULT_LIST))

endif

