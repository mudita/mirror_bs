ifndef MK_DEBUG_MK
MK_DEBUG_MK=			TRUE

INCLUDER_MODULES_LIST=		applications \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEBUG_PREFIX=			$(CONFIG_DEBUG_RULE)

DEBUG_STANDARD_LIST=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(DEBUG_PREFIX)_%, \
					$(APPLICATIONS_PLATFORMS_STANDARD_LIST))


DEBUG_NONSTANDARD_LIST=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(DEBUG_PREFIX)_%, \
					$(APPLICATIONS_PLATFORMS_NONSTANDARD_LIST))

DEBUG_GDBSERVER_FLAGS=		:$(CONFIG_GDB_PORT)

endif

