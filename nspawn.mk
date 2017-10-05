ifndef MK_NSPAWN_MK
MK_NSPAWN_MK=				TRUE

INCLUDER_MODULES_LIST=			config

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

NSPAWN_PREFIX=				nspawn

NSPAWN_SANITY_TEST_RULE=		$(NSPAWN_PREFIX)_$(CONFIG_SANITY_TEST_RULE)

NSPAWN_BIN=				systemd-nspawn

endif

