ifndef MK_DOC_MK
MK_DOC_MK=			TRUE

INCLUDER_MODULES_LIST=		doc/html \
				doc/latex \
				doc/pdf

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

endif

