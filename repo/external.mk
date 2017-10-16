ifndef MK_REPO_EXTERNAL_MK
MK_REPO_EXTERNAL_MK=			TRUE

INCLUDER_MODULES_LIST=			config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

REPO_EXTERNAL_REMOTE_NAME=		external

# INFO: Read more about merge strategies: https://git-scm.com/docs/merge-strategies
REPO_EXTERNAL_STRATEGY_OURS=		ours
REPO_EXTERNAL_STRATEGY_THEIRS=		theirs

REPO_EXTERNAL_BRANCH_DEFAULT=		$(CONFIG_GITREPO_BRANCH_DEFAULT)

REPO_EXTERNAL_GITREPO_EXISTENCE=	$(wildcard \
						$(CONFIG_PULL_FILE_NAME))
ifneq ($(REPO_EXTERNAL_GITREPO_EXISTENCE), )
REPO_EXTERNAL_GITREPO_CONTENT_COMMAND=	cat \
						$(CONFIG_PULL_FILE_NAME)

REPO_EXTERNAL_GITREPO_CONTENT=		$(shell \
						$(REPO_EXTERNAL_GITREPO_CONTENT_COMMAND))

REPO_EXTERNAL_GITREPO_CONTENT_WORDS=	$(words \
						$(REPO_EXTERNAL_GITREPO_CONTENT))

ifneq ($(REPO_EXTERNAL_GITREPO_CONTENT_WORDS), 1)
ifneq ($(REPO_EXTERNAL_GITREPO_CONTENT_WORDS), 2)
$(error $(CONFIG_PULL_FILE_NAME) syntax mismatch)
else
REPO_EXTERNAL_REPO_URL=			$(word \
						1, \
						$(REPO_EXTERNAL_GITREPO_CONTENT))

REPO_EXTERNAL_REPO_BRANCH=		$(word \
						2, \
						$(REPO_EXTERNAL_GITREPO_CONTENT))
endif
else
REPO_EXTERNAL_REPO_URL=			$(REPO_EXTERNAL_GITREPO_CONTENT)
REPO_EXTERNAL_REPO_BRANCH=		$(REPO_EXTERNAL_BRANCH_DEFAULT)
endif
else
REPO_EXTERNAL_REPO_URL=
REPO_EXTERNAL_REPO_BRANCH=
endif

endif

