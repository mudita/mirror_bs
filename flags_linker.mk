ifndef MK_FLAGS_LINKER_MK
MK_FLAGS_LINKER_MK=		TRUE

INCLUDER_MODULES_LIST=		mode

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

ifeq ($(MODE_MEMORY_LEAK_DETECTOR), MODULE_MEMORY_MTRACE)
FLAGS_LINKER=			-Wl,--wrap=main
else ifeq ($(MODE_MEMORY_LEAK_DETECTOR), MODULE_MEMORY_WRAPPER)
FLAGS_LINKER=			-Wl,--wrap=malloc \
				-Wl,--wrap=free
else
FLAGS_LINKER=
endif

endif

