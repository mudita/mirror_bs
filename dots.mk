ifndef MK_DOTS_MK
MK_DOTS_MK=				TRUE

INCLUDER_MODULES_LIST=			config \
					tools \
					modules \
					applications

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

DOTS_TOOLS_NONSTANDARD_LIST=		$(addprefix \
						$(CONFIG_DOT_PREFIX)_, \
						$(TOOLS_NONSTANDARD_LIST))

DOTS_TOOLS_STANDARD_LIST=		$(addprefix \
						$(CONFIG_DOT_PREFIX)_, \
						$(TOOLS_STANDARD_LIST))

DOTS_MODULES_NONSTANDARD_LIST=		$(addprefix \
						$(CONFIG_DOT_PREFIX)_, \
						$(MODULES_NONSTANDARD_LIST))

DOTS_MODULES_STANDARD_LIST=		$(addprefix \
						$(CONFIG_DOT_PREFIX)_, \
						$(MODULES_STANDARD_LIST))

DOTS_APPLICATIONS_NONSTANDARD_LIST=	$(addprefix \
						$(CONFIG_DOT_PREFIX)_, \
						$(APPLICATIONS_NONSTANDARD_LIST))

DOTS_APPLICATIONS_STANDARD_LIST=	$(addprefix \
						$(CONFIG_DOT_PREFIX)_, \
						$(APPLICATIONS_STANDARD_LIST))

endif

