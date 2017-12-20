ifndef MK_DEPLOY_MK
MK_DEPLOY_MK=				TRUE

INCLUDER_MODULES_LIST=			config \
					dirs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEPLOY_TOOLS_COMMAND=			find \
						$(DIRS_TOOLS_DIR) \
						-type \
						f \
						-name \
						$(CONFIG_DEPLOY_DNS_FILE_NAME)

DEPLOY_TOOLS_FILE_LIST=			$(shell \
						$(DEPLOY_TOOLS_COMMAND))

DEPLOY_TOOLS_FOUND_LIST=		$(patsubst \
						$(DIRS_TOOLS_DIR)/%/$(CONFIG_DEPLOY_DNS_FILE_NAME), \
						%, \
						$(DEPLOY_TOOLS_FILE_LIST))

endif

