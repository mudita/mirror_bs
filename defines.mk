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
#DEFINES_BARE_LIST=		BARE_DEFINE_NAME='bare_define_value'

ifeq ($(UNIT_TEST), 1)
DEFINES_BARE_LIST=		UNIT_TEST_ENTRY_POINT=$(UNIT_TEST_ENTRY_POINT)
else
DEFINES_BARE_LIST=
endif

# INFO: Each bare define gets define prefix here.
DEFINES_LIST=			$(patsubst \
					%, \
					$(DEFINES_PREFIX)%, \
					$(DEFINES_BARE_LIST))

endif

