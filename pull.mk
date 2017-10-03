ifndef MK_PULL_MK
MK_PULL_MK=			TRUE

INCLUDER_MODULES_LIST=		config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

PULL_REMOTE_NAME_DEFAULT=	origin
PULL_REMOTE_NAME=		external

# INFO: Read more about merge strategies: https://git-scm.com/docs/merge-strategies
PULL_STRATEGY_OURS=		ours
PULL_STRATEGY_THEIRS=		theirs

PULL_BRANCH_DEFAULT=		$(CONFIG_GITREPO_BRANCH_DEFAULT)

PULL_GITREPO_EXISTENCE=		$(wildcard \
					$(CONFIG_PULL_FILE_NAME))
ifneq ($(PULL_GITREPO_EXISTENCE), )
PULL_GITREPO_CONTENT_COMMAND=	cat \
					$(CONFIG_PULL_FILE_NAME)

PULL_GITREPO_CONTENT=		$(shell \
					$(PULL_GITREPO_CONTENT_COMMAND))

PULL_GITREPO_CONTENT_WORDS=	$(words \
					$(PULL_GITREPO_CONTENT))

ifneq ($(PULL_GITREPO_CONTENT_WORDS), 1)
ifneq ($(PULL_GITREPO_CONTENT_WORDS), 2)
$(error $(CONFIG_PULL_FILE_NAME) syntax mismatch)
else
PULL_REPO_URL=			$(word \
					1, \
					$(PULL_GITREPO_CONTENT))

PULL_REPO_BRANCH=		$(word \
					2, \
					$(PULL_GITREPO_CONTENT))
endif
else
PULL_REPO_URL=			$(PULL_GITREPO_CONTENT)
PULL_REPO_BRANCH=		$(PULL_BRANCH_DEFAULT)
endif
else
PULL_REPO_URL=
PULL_REPO_BRANCH=
endif

endif

