ifndef MK_RUN_MK
MK_RUN_MK=			TRUE

INCLUDER_MODULES_LIST=		applications \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

RUN_PREFIX=			run

RUN_STANDARD_LIST=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(RUN_PREFIX)_%, \
					$(APPLICATIONS_PLATFORMS_STANDARD_LIST))


RUN_NONSTANDARD_LIST=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(RUN_PREFIX)_%, \
					$(APPLICATIONS_PLATFORMS_NONSTANDARD_LIST))

endif

