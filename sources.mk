ifndef MK_SOURCES_MK
MK_SOURCES_MK=			TRUE

INCLUDER_MODULES_LIST=		sources/asm \
				sources/c \
				sources/cpp \
				sources/dot

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

endif

