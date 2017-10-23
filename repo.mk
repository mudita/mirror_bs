ifndef MK_REPO_MK
MK_REPO_MK=				TRUE

INCLUDER_MODULES_LIST=			dirs \
					repo/external \
					repo/internal \

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

REPO_REMOTE_NAME_DEFAULT=		origin

# INFO: Read more about merge strategies: https://git-scm.com/docs/merge-strategies
REPO_STRATEGY_OURS=			ours
REPO_STRATEGY_THEIRS=			theirs

# TODO: Default platform should not be assumed!
ifndef AUTO_SYNC
AUTO_SYNC=				0
endif

# TODO: Remove - download dir should be the same for pull and push.
ifeq ($(AUTO_SYNC), 1)
REPO_DIR=				$(DIRS_PUSH_DIR)
else
REPO_DIR=				$(DIRS_PULL_DIR)
endif

endif

