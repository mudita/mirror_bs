ifndef MK_DOWNLOAD_MK
MK_DOWNLOAD_MK=				TRUE

INCLUDER_MODULES_LIST=			dirs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Default platform should not be assumed!
ifndef AUTO_SYNC
AUTO_SYNC=				0
endif

# TODO: Remove - download dir should be the same for pull and push.
ifeq ($(AUTO_SYNC), 1)
DOWNLOAD_DIR=				$(DIRS_PUSH_DIR)
else
DOWNLOAD_DIR=				$(DIRS_PULL_DIR)
endif

endif

