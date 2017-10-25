ifndef MK_AUTO_SYNC_MK
MK_AUTO_SYNC_MK=			TRUE

INCLUDER_MODULES_LIST=			config \
					dirs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

AUTO_SYNC_PREFIX=			$(CONFIG_AUTO_SYNC_RULE)

AUTO_SYNC_APPLICATION_PREFIX=		$(AUTO_SYNC_PREFIX)_$(CONFIG_APPLICATION_PREFIX)
AUTO_SYNC_MODULE_PREFIX=		$(AUTO_SYNC_PREFIX)_$(CONFIG_MODULE_PREFIX)
AUTO_SYNC_TOOL_PREFIX=			$(AUTO_SYNC_PREFIX)_$(CONFIG_TOOL_PREFIX)

AUTO_SYNC_APPLICATIONS_INTERNAL_COMMAND=	find \
							$(DIRS_APPLICATIONS_DIR) \
							-type \
							f \
							-name \
							$(CONFIG_INTERNAL_GITREPO_FILE_NAME)

AUTO_SYNC_MODULES_INTERNAL_COMMAND=	find \
						$(DIRS_MODULES_DIR) \
						-type \
						f \
						-name \
						$(CONFIG_INTERNAL_GITREPO_FILE_NAME)

AUTO_SYNC_TOOLS_INTERNAL_COMMAND=	find \
						$(DIRS_TOOLS_DIR) \
						-type \
						f \
						-name \
						$(CONFIG_INTERNAL_GITREPO_FILE_NAME)

AUTO_SYNC_APPLICATIONS_INTERNAL_FILE_LIST=	$(shell \
							$(AUTO_SYNC_APPLICATIONS_INTERNAL_COMMAND))

AUTO_SYNC_MODULES_INTERNAL_FILE_LIST=	$(shell \
						$(AUTO_SYNC_MODULES_INTERNAL_COMMAND))

AUTO_SYNC_TOOLS_INTERNAL_FILE_LIST=	$(shell \
						$(AUTO_SYNC_TOOLS_INTERNAL_COMMAND))

AUTO_SYNC_APPLICATIONS_EXTERNAL_COMMAND=	find \
							$(DIRS_APPLICATIONS_DIR) \
							-type \
							f \
							-name \
							$(CONFIG_EXTERNAL_GITREPO_FILE_NAME)

AUTO_SYNC_MODULES_EXTERNAL_COMMAND=	find \
						$(DIRS_MODULES_DIR) \
						-type \
						f \
						-name \
						$(CONFIG_EXTERNAL_GITREPO_FILE_NAME)

AUTO_SYNC_TOOLS_EXTERNAL_COMMAND=	find \
						$(DIRS_TOOLS_DIR) \
						-type \
						f \
						-name \
						$(CONFIG_EXTERNAL_GITREPO_FILE_NAME)

AUTO_SYNC_APPLICATIONS_EXTERNAL_FILE_LIST=	$(shell \
							$(AUTO_SYNC_APPLICATIONS_EXTERNAL_COMMAND))

AUTO_SYNC_MODULES_EXTERNAL_FILE_LIST=	$(shell \
						$(AUTO_SYNC_MODULES_EXTERNAL_COMMAND))

AUTO_SYNC_TOOLS_EXTERNAL_FILE_LIST=	$(shell \
						$(AUTO_SYNC_TOOLS_EXTERNAL_COMMAND))

AUTO_SYNC_APPLICATIONS_FOUND_INTERNAL_LIST=	$(patsubst \
							$(DIRS_APPLICATIONS_DIR)/%/$(CONFIG_INTERNAL_GITREPO_FILE_NAME), \
							%, \
							$(AUTO_SYNC_APPLICATIONS_INTERNAL_FILE_LIST))

AUTO_SYNC_MODULES_FOUND_INTERNAL_LIST=	$(patsubst \
						$(DIRS_MODULES_DIR)/%/$(CONFIG_INTERNAL_GITREPO_FILE_NAME), \
						%, \
						$(AUTO_SYNC_MODULES_INTERNAL_FILE_LIST))

AUTO_SYNC_TOOLS_FOUND_INTERNAL_LIST=	$(patsubst \
						$(DIRS_TOOLS_DIR)/%/$(CONFIG_INTERNAL_GITREPO_FILE_NAME), \
						%, \
						$(AUTO_SYNC_TOOLS_INTERNAL_FILE_LIST))

AUTO_SYNC_APPLICATIONS_FOUND_EXTERNAL_LIST=	$(patsubst \
							$(DIRS_APPLICATIONS_DIR)/%/$(CONFIG_EXTERNAL_GITREPO_FILE_NAME), \
							%, \
							$(AUTO_SYNC_APPLICATIONS_EXTERNAL_FILE_LIST))

AUTO_SYNC_MODULES_FOUND_EXTERNAL_LIST=	$(patsubst \
						$(DIRS_MODULES_DIR)/%/$(CONFIG_EXTERNAL_GITREPO_FILE_NAME), \
						%, \
						$(AUTO_SYNC_MODULES_EXTERNAL_FILE_LIST))

AUTO_SYNC_TOOLS_FOUND_EXTERNAL_LIST=	$(patsubst \
						$(DIRS_TOOLS_DIR)/%/$(CONFIG_EXTERNAL_GITREPO_FILE_NAME), \
						%, \
						$(AUTO_SYNC_TOOLS_EXTERNAL_FILE_LIST))

AUTO_SYNC_APPLICATIONS_FILE_LIST=	$(filter \
						$(AUTO_SYNC_APPLICATIONS_FOUND_INTERNAL_LIST), \
						$(AUTO_SYNC_APPLICATIONS_FOUND_EXTERNAL_LIST))

AUTO_SYNC_MODULES_FILE_LIST=		$(filter \
						$(AUTO_SYNC_MODULES_FOUND_INTERNAL_LIST), \
						$(AUTO_SYNC_MODULES_FOUND_EXTERNAL_LIST))

AUTO_SYNC_TOOLS_FILE_LIST=		$(filter \
						$(AUTO_SYNC_TOOLS_FOUND_INTERNAL_LIST), \
						$(AUTO_SYNC_TOOLS_FOUND_EXTERNAL_LIST))

AUTO_SYNC_APPLICATIONS_FOUND_LIST=	$(patsubst \
						%, \
						$(CONFIG_APPLICATION_PREFIX)_%-%, \
						$(AUTO_SYNC_APPLICATIONS_FILE_LIST))

AUTO_SYNC_MODULES_FOUND_LIST=		$(patsubst \
						%, \
						$(CONFIG_MODULE_PREFIX)_%-%, \
						$(AUTO_SYNC_MODULES_FILE_LIST))

AUTO_SYNC_TOOLS_FOUND_LIST=		$(patsubst \
						%, \
						$(CONFIG_TOOL_PREFIX)_%-%, \
						$(AUTO_SYNC_TOOLS_FILE_LIST))

AUTO_SYNC_APPLICATIONS_BARE_STANDARD_LIST=	$(filter \
							$(AUTO_SYNC_APPLICATIONS_FOUND_LIST), \
							$(APPLICATIONS_PLATFORMS_STANDARD_LIST))

AUTO_SYNC_APPLICATIONS_BARE_NONSTANDARD_LIST=	$(filter \
							$(AUTO_SYNC_APPLICATIONS_FOUND_LIST), \
							$(APPLICATIONS_PLATFORMS_NONSTANDARD_LIST))

AUTO_SYNC_MODULES_BARE_STANDARD_LIST=		$(filter \
							$(AUTO_SYNC_MODULES_FOUND_LIST), \
							$(MODULES_PLATFORMS_STANDARD_LIST))

AUTO_SYNC_MODULES_BARE_NONSTANDARD_LIST=	$(filter \
							$(AUTO_SYNC_MODULES_FOUND_LIST), \
							$(MODULES_PLATFORMS_NONSTANDARD_LIST))

AUTO_SYNC_TOOLS_BARE_STANDARD_LIST=		$(filter \
							$(AUTO_SYNC_TOOLS_FOUND_LIST), \
							$(TOOLS_PLATFORMS_STANDARD_LIST))

AUTO_SYNC_TOOLS_BARE_NONSTANDARD_LIST=		$(filter \
							$(AUTO_SYNC_TOOLS_FOUND_LIST), \
							$(TOOLS_PLATFORMS_NONSTANDARD_LIST))

AUTO_SYNC_APPLICATIONS_PLATFORMS_STANDARD_LIST=		$(addprefix \
								$(AUTO_SYNC_PREFIX)_, \
								$(AUTO_SYNC_APPLICATIONS_BARE_STANDARD_LIST))

AUTO_SYNC_APPLICATIONS_PLATFORMS_NONSTANDARD_LIST=	$(addprefix \
								$(AUTO_SYNC_PREFIX)_, \
								$(AUTO_SYNC_APPLICATIONS_BARE_NONSTANDARD_LIST))

AUTO_SYNC_MODULES_PLATFORMS_STANDARD_LIST=		$(addprefix \
								$(AUTO_SYNC_PREFIX)_, \
								$(AUTO_SYNC_MODULES_BARE_STANDARD_LIST))

AUTO_SYNC_MODULES_PLATFORMS_NONSTANDARD_LIST=		$(addprefix \
								$(AUTO_SYNC_PREFIX)_, \
								$(AUTO_SYNC_MODULES_BARE_NONSTANDARD_LIST))

AUTO_SYNC_TOOLS_PLATFORMS_STANDARD_LIST=		$(addprefix \
								$(AUTO_SYNC_PREFIX)_, \
								$(AUTO_SYNC_TOOLS_BARE_STANDARD_LIST))

AUTO_SYNC_TOOLS_PLATFORMS_NONSTANDARD_LIST=		$(addprefix \
								$(AUTO_SYNC_PREFIX)_, \
								$(AUTO_SYNC_TOOLS_BARE_NONSTANDARD_LIST))

endif

