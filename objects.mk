ifndef MK_OBJECTS_MK
MK_OBJECTS_MK=			TRUE

INCLUDER_MODULES_LIST=		objects/asm \
				objects/c \
				objects/cpp

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

OBJECTS_LIST=			$(OBJECTS_ASM_LIST) \
				$(OBJECTS_C_LIST) \
				$(OBJECTS_CPP_LIST)

OBJECTS_FOR_TEST_LIST=		$(OBJECTS_ASM_FOR_TEST_LIST) \
				$(OBJECTS_C_FOR_TEST_LIST) \
				$(OBJECTS_CPP_FOR_TEST_LIST)

endif

