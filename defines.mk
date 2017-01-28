ifndef MK_DEFINES_MK
MK_DEFINES_MK=			TRUE

INCLUDER_MODULES_LIST=		install \
				platform \
				config \
				console

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEFINES_PREFIX=			-D

# INFO: Do not use quotations ("), use apostrophes instead (').
DEFINES_BARE=			DEBUG_PID_FILE='$(CONFIG_DEBUG_PID_FILE_NAME)' \
				CONSOLE_FILE='$(CONSOLE_FILE)'

DEFINES=			$(patsubst \
					%, \
					$(DEFINES_PREFIX)%, \
					$(DEFINES_BARE))

endif

