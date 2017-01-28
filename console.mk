ifndef MK_CONSOLE_MK
MK_CONSOLE_MK=			TRUE

INCLUDER_MODULES_LIST=		config \
				applications
				

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

CONSOLE_PREFIX=			console

CONSOLE_FILE=			$(CONSOLE_PREFIX).$(CONFIG_CONSOLE_STDOUT_EXT)

CONSOLE_LIST=			$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(CONSOLE_PREFIX)_%, \
					$(APPLICATIONS_LIST))

endif

