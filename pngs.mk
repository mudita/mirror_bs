ifndef MK_PNGS_MK
MK_PNGS_MK=				TRUE

#INCLUDER_MODULES_LIST=			config \
#					dots

#ifndef INCLUDER_PATH
#$(error aosmake package is not installed in your OS!)
#else
#include $(INCLUDER_PATH)
#endif

#PNGS_DOTS_LIST=				$(DOTS_TOOLS_NONSTANDARD_LIST) \
#					$(DOTS_TOOLS_STANDARD_LIST) \
#					$(DOTS_MODULES_NONSTANDARD_LIST) \
#					$(DOTS_MODULES_STANDARD_LIST) \
#					$(DOTS_APPLICATIONS_NONSTANDARD_LIST) \
#					$(DOTS_APPLICATIONS_STANDARD_LIST)

#PNGS_LIST=				$(patsubst \
#						$(CONFIG_DOT_PREFIX)_%, \
#						$(CONFIG_PNG_PREFIX)_%, \
#						$(PNGS_DOTS_LIST))

endif

