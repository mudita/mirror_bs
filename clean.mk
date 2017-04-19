ifndef MK_CLEAN_MK
MK_CLEAN_MK=				TRUE

INCLUDER_MODULES_LIST=			config \
					applications \
					modules \
					tools

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

CLEAN_PREFIX=				$(CONFIG_CLEAN_RULE)

# TODO: APPLICATIONS vs APPLICATION - fix it
CLEAN_APPLICATIONS_PREFIX=		$(CLEAN_PREFIX)_$(CONFIG_APPLICATION_PREFIX)
CLEAN_MODULES_PREFIX=			$(CLEAN_PREFIX)_$(CONFIG_MODULE_PREFIX)
CLEAN_TOOLS_PREFIX=			$(CLEAN_PREFIX)_$(CONFIG_TOOL_PREFIX)

# TODO: Dirty hack to avoid modbuild remove if exits in applications directory.
CLEAN_IGNORE_LIST=			$(CONFIG_TOOL_PREFIX)_modbuild \
					$(CONFIG_TOOL_PREFIX)_smart_deps

CLEAN_APPLICATIONS_PLATFORMS_STANDARD_LIST=	$(addprefix \
							$(CLEAN_PREFIX)_, \
							$(APPLICATIONS_PLATFORMS_STANDARD_LIST))

CLEAN_APPLICATIONS_PLATFORMS_NONSTANDARD_LIST=	$(addprefix \
							$(CLEAN_PREFIX)_, \
							$(APPLICATIONS_PLATFORMS_NONSTANDARD_LIST))

CLEAN_MODULES_STANDARD_LIST=		$(addprefix \
						$(CLEAN_PREFIX)_, \
						$(MODULES_STANDARD_LIST))

CLEAN_MODULES_NONSTANDARD_LIST=		$(addprefix \
						$(CLEAN_PREFIX)_, \
						$(MODULES_NONSTANDARD_LIST))

# TODO: Dirty hack to avoid modbuild remove if exits in tools directory.
CLEAN_TOOLS_STANDARD_MODIFIED_LIST=	$(filter-out \
						$(CLEAN_IGNORE_LIST), \
						$(TOOLS_STANDARD_LIST))

CLEAN_TOOLS_STANDARD_LIST=		$(addprefix \
						$(CLEAN_PREFIX)_, \
						$(CLEAN_TOOLS_STANDARD_MODIFIED_LIST))

CLEAN_TOOLS_NONSTANDARD_LIST=		$(addprefix \
						$(CLEAN_PREFIX)_, \
						$(TOOLS_NONSTANDARD_LIST))

CLEAN_DOC_DEFAULT_HTML_LIST=		$(addprefix \
						$(CLEAN_PREFIX)_, \
						$(DOC_DEFAULT_HTML_LIST))

endif

