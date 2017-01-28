ifndef MK_DEPS_MK
MK_DEPS_MK=			TRUE

INCLUDER_MODULES_LIST=		deps/asm \
				deps/c \
				deps/cpp

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEPS_FLAG_LIST=			-MM

# TODO: Try to connect dependencies
#include $(DEPS_ASM_LIST)
#include $(DEPS_C_LIST)
#include $(DEPS_CPP_LIST)

endif

