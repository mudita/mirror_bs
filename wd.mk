ifndef MK_WD_MK
MK_WD_MK=			TRUE

INCLUDER_MODULES_LIST=		dirs \
				platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

ifdef WD
WD_DIR=				$(WD)
else
WD_DIR=				$(DIRS_INSTALL_DIR)/$(PLATFORM)
endif

endif

