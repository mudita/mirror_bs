ifndef MK_UNIT_TEST_MK
MK_UNIT_TEST_MK=			TRUE

INCLUDER_MODULES_LIST=			unit_test/gen \
					unit_test/run

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

endif

