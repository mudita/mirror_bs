ifndef MK_FLAGS_LINKER_MK
MK_FLAGS_LINKER_MK=		TRUE

INCLUDER_MODULES_LIST=		alloc

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_MEM_NONE))
FLAGS_LINKER=
else ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_MEM_STD))
FLAGS_LINKER=			-Wl,--wrap=malloc \
				-Wl,--wrap=free
else ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_MEM_POOL))
FLAGS_LINKER=			-Wl,--wrap=malloc \
				-Wl,--wrap=free
else ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_MEM_HEAP))
FLAGS_LINKER=			-Wl,--wrap=malloc \
				-Wl,--wrap=free
else
FLAGS_LINKER=
endif

endif

