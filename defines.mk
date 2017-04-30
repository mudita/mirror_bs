ifndef MK_DEFINES_MK
MK_DEFINES_MK=			TRUE

INCLUDER_MODULES_LIST=		install \
				platform \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEFINES_PREFIX=			-D

# INFO: Do not use quotations ("), use apostrophes instead (').
#DEFINES_BARE=			BARE_DEFINE_NAME='bare_define_value'
DEFINES_BARE=

# INFO: Each bare define gets define prefix here.
DEFINES=			$(patsubst \
					%, \
					$(DEFINES_PREFIX)%, \
					$(DEFINES_BARE))

endif

