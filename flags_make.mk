ifndef MK_FLAGS_MAKE_MK
MK_FLAGS_MAKE_MK=		TRUE

INCLUDER_MODULES_LIST=		jobs

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

FLAGS_MAKE_LIST=		--warn-undefined-variables

endif

