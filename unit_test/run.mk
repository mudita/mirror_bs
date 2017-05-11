ifndef MK_UNIT_TEST_RUN_MK
MK_UNIT_TEST_RUN_MK=			TRUE

INCLUDER_MODULES_LIST=			config \
					modules \
					applications

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

UNIT_TEST_RUN_PREFIX=			$(CONFIG_UNIT_TEST_RUN_RULE)

UNIT_TEST_RUN_APP_PREFIX=		$(UNIT_TEST_RUN_PREFIX)_$(CONFIG_APPLICATION_PREFIX)
UNIT_TEST_RUN_MOD_PREFIX=		$(UNIT_TEST_RUN_PREFIX)_$(CONFIG_MODULE_PREFIX)

UNIT_TEST_RUN_APP_STANDARD_LIST=	$(patsubst \
						$(CONFIG_APPLICATION_PREFIX)_%, \
						$(UNIT_TEST_RUN_APP_PREFIX)_%, \
						$(APPLICATIONS_PLATFORMS_STANDARD_LIST))


UNIT_TEST_RUN_APP_NONSTANDARD_LIST=	$(patsubst \
						$(CONFIG_APPLICATION_PREFIX)_%, \
						$(UNIT_TEST_RUN_APP_PREFIX)_%, \
						$(APPLICATIONS_PLATFORMS_NONSTANDARD_LIST))

UNIT_TEST_RUN_MOD_STANDARD_LIST=	$(patsubst \
						$(CONFIG_MODULE_PREFIX)_%, \
						$(UNIT_TEST_RUN_MOD_PREFIX)_%, \
						$(MODULES_PLATFORMS_STANDARD_LIST))


UNIT_TEST_RUN_MOD_NONSTANDARD_LIST=	$(patsubst \
						$(CONFIG_MODULE_PREFIX)_%, \
						$(UNIT_TEST_RUN_MOD_PREFIX)_%, \
						$(MODULES_PLATFORMS_NONSTANDARD_LIST))

endif

