ifndef MK_FORMAT_MK
MK_FORMAT_MK=				TRUE

INCLUDER_MODULES_LIST=			config \
					modules \
					applications

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

FORMAT_PREFIX=				$(CONFIG_FORMAT_RULE)

FORMAT_APP_PREFIX=			$(FORMAT_PREFIX)_$(CONFIG_APPLICATION_PREFIX)
FORMAT_MOD_PREFIX=			$(FORMAT_PREFIX)_$(CONFIG_MODULE_PREFIX)

FORMAT_APP_STANDARD_LIST=		$(patsubst \
						$(CONFIG_APPLICATION_PREFIX)_%, \
						$(FORMAT_APP_PREFIX)_%, \
						$(APPLICATIONS_STANDARD_LIST))


FORMAT_APP_NONSTANDARD_LIST=		$(patsubst \
						$(CONFIG_APPLICATION_PREFIX)_%, \
						$(FORMAT_APP_PREFIX)_%, \
						$(APPLICATIONS_NONSTANDARD_LIST))

FORMAT_MOD_STANDARD_LIST=		$(patsubst \
						$(CONFIG_MODULE_PREFIX)_%, \
						$(FORMAT_MOD_PREFIX)_%, \
						$(MODULES_STANDARD_LIST))


FORMAT_MOD_NONSTANDARD_LIST=		$(patsubst \
						$(CONFIG_MODULE_PREFIX)_%, \
						$(FORMAT_MOD_PREFIX)_%, \
						$(MODULES_NONSTANDARD_LIST))

endif
