ifndef MK_UNIT_TEST_MK
MK_UNIT_TEST_MK=			TRUE

INCLUDER_MODULES_LIST=		unit_test/gen \
				unit_test/c

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

#UNIT_TEST_LIST=		$(UNIT_TEST_ASM_LIST) \
#				$(UNIT_TEST_C_LIST) \
#				$(UNIT_TEST_CPP_LIST)

UNIT_TEST_LIST=			$(UNIT_TEST_C_LIST)

endif

