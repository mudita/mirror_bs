ifndef MK_INCLUDES_MK
MK_INCLUDES_MK=			TRUE

INCLUDER_MODULES_LIST=		dirs \
				modules
				
ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

INCLUDES_DIRS_PREFIX=		-I

INCLUDES_OWN_DIR=		$(wildcard \
					$(DIRS_INCLUDE_DIR))

ifneq ($(INCLUDES_OWN_DIR),)
INCLUDES_OWN_LIST=		$(addprefix \
					$(INCLUDES_DIRS_PREFIX) , \
					$(INCLUDES_OWN_DIR))
else
INCLUDES_OWN_LIST=		
endif

INCLUDES_LIST=			$(INCLUDES_OWN_LIST)

INCLUDES_BASE_DIR=		$(DIRS_MODULES_DIR)/$($(CONFIG_MODULE_PREFIX))
INCLUDES_DIR=			$(INCLUDES_BASE_DIR)/$(DIRS_INCLUDE_DIR)

INCLUDES_RELATIVE_DIR=		$(RELATIVE_ROOT_DIR)/$(INCLUDES_DIR)

INCLUDES_CHECK=			$(wildcard \
					$(INCLUDES_RELATIVE_DIR))

##############################################################################

INCLUDES_DEPENDENCIES_EXISTENCE=	$(wildcard \
					$(CONFIG_MODULE_DEP_FILE_NAME))

ifneq ($(INCLUDES_DEPENDENCIES_EXISTENCE), )
INCLUDES_DEPENDENCIES_COMMAND=	cat \
					$(CONFIG_MODULE_DEP_FILE_NAME)

INCLUDES_MODULES_LIST=		$(shell \
					$(INCLUDES_DEPENDENCIES_COMMAND))
else
INCLUDES_MODULES_LIST=
endif

##############################################################################

INCLUDES_EXISTING=		$(foreach \
					$(CONFIG_MODULE_PREFIX), \
					$(INCLUDES_MODULES_LIST), \
					$(INCLUDES_CHECK))

INCLUDES_LIST+=			$(addprefix \
					$(INCLUDES_DIRS_PREFIX) , \
					$(INCLUDES_EXISTING))

endif

