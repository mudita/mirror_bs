ifndef MK_UNIT_TEST_MK
MK_UNIT_TEST_MK=			TRUE

INCLUDER_MODULES_LIST=			unit_test/gen \
					unit_test/run

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

UNIT_TEST_ENTRY_POINT=			unit_test_main

# TODO: Default platform should not be assumed!
#ifndef UNIT_TEST
#UNIT_TEST=				0
#endif

endif

