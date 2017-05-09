ifndef MK_UNIT_TEST_OBJECTS_MK
MK_UNIT_TEST_OBJECTS_MK=		TRUE

INCLUDER_MODULES_LIST=			unit_test_objects/c

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

endif

