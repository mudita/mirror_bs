ifndef MK_CTAGS_MK
MK_CTAGS_MK=			TRUE

INCLUDER_MODULES_LIST=		ctags/c

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

#CTAGS_LIST=			$(CTAGS_ASM_LIST) \
#				$(CTAGS_C_LIST) \
#				$(CTAGS_CPP_LIST)

CTAGS_LIST=			$(CTAGS_C_LIST)

endif

