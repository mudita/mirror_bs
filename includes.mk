ifndef MK_INCLUDES_MK
MK_INCLUDES_MK=			TRUE

INCLUDER_MODULES_LIST=		dirs \
				modules \
				platform \
				relative
				
ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Clean this build system module and make it more ordered.

INCLUDES_DIRS_PREFIX=		-I

# TODO: Add ONLY if there is any header file direct in this directory.
INCLUDES_OWN_DIR=		$(wildcard \
					$(DIRS_INCLUDE_DIR))

INCLUDES_BASE_DIR=		$(DIRS_MODULES_DIR)/$($(CONFIG_MODULE_PREFIX))
INCLUDES_DIR=			$(INCLUDES_BASE_DIR)/$(DIRS_INCLUDE_DIR)
INCLUDES_FILE=			$(INCLUDES_BASE_DIR)/$(CONFIG_INCLUDES_FILE_NAME)

INCLUDES_RELATIVE_DIR=		$(RELATIVE_ROOT_DIR)/$(INCLUDES_DIR)

INCLUDES_RELATIVE_INCLUDES_FILE=	$(RELATIVE_ROOT_DIR)/$(INCLUDES_FILE)

INCLUDES_CHECK=			$(wildcard \
					$(INCLUDES_RELATIVE_DIR))

INCLUDES_CHECK_LOCAL=		$(wildcard \
					$(INCLUDES_RELATIVE_INCLUDES_FILE))

# TODO: Change name of this variable.
INCLUDES_LOCAL_CONTENT_COMMAND_REAL=	cat \
						$(INCLUDES_RELATIVE_INCLUDES_FILE) | \
					grep \
						-v \
						^\/

INCLUDES_LOCAL_CONTENT_COMMAND=	$(if \
					$(INCLUDES_CHECK_LOCAL), \
					$(INCLUDES_LOCAL_CONTENT_COMMAND_REAL), \
					true)

INCLUDES_LOCAL_CONTENT=		$(shell \
					$(INCLUDES_LOCAL_CONTENT_COMMAND))

INCLUDES_LOCAL_CONTENT_2=	$(addprefix \
					$(RELATIVE_ROOT_DIR)/$(INCLUDES_BASE_DIR)/, \
					$(INCLUDES_LOCAL_CONTENT))

##############################################################################
# INFO: Dependency mechanism.
##############################################################################
# TODO: This code is present in includes.mk, libs.mk and coverage.mk - merge it!
INCLUDES_DEP_GENERIC_FILE_NAME=		$(CONFIG_MODULE_DEP_FILE_NAME)
INCLUDES_DEP_PLATFORM_FILE_NAME=	$(CONFIG_MODULE_PREFIX)s_$(PLATFORM).$(CONFIG_DEP_EXT)

INCLUDES_DEPENDENCIES_EXISTENCE=	$(wildcard \
						$(INCLUDES_DEP_GENERIC_FILE_NAME))

INCLUDES_DEPENDENCIES_PLAT_EXISTENCE=	$(wildcard \
						$(INCLUDES_DEP_PLATFORM_FILE_NAME))

ifneq ($(INCLUDES_DEPENDENCIES_EXISTENCE), )
INCLUDES_DEPENDENCIES_COMMAND=	cat \
					$(INCLUDES_DEP_GENERIC_FILE_NAME)

INCLUDES_MODULES_LIST=		$(shell \
					$(INCLUDES_DEPENDENCIES_COMMAND))
else ifneq ($(INCLUDES_DEPENDENCIES_PLAT_EXISTENCE), )
INCLUDES_DEPENDENCIES_COMMAND=	cat \
					$(INCLUDES_DEP_PLATFORM_FILE_NAME)

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

##############################################################################

INCLUDES_EXISTING_LOCAL=	$(foreach \
					$(CONFIG_MODULE_PREFIX), \
					$(INCLUDES_MODULES_LIST), \
					$(INCLUDES_CHECK_LOCAL))

INCLUDES_EXISTING_CONTENT=	$(foreach \
					$(CONFIG_MODULE_PREFIX), \
					$(INCLUDES_MODULES_LIST), \
					$(INCLUDES_LOCAL_CONTENT_2))

##############################################################################

INCLUDES_LOCAL_EXISTENCE=	$(wildcard \
					$(CONFIG_INCLUDES_FILE_NAME))

ifneq ($(INCLUDES_LOCAL_EXISTENCE), )
INCLUDES_LOCAL_COMMAND=		cat \
					$(CONFIG_INCLUDES_FILE_NAME)

INCLUDES_LOCAL_LIST=		$(shell \
					$(INCLUDES_LOCAL_COMMAND))
else
INCLUDES_LOCAL_LIST=
endif

##############################################################################

# TODO: Add INCLUDES_EXISTING_LOCAL to this list
INCLUDES_ALL_LIST=		$(INCLUDES_OWN_DIR) \
				$(INCLUDES_EXISTING) \
				$(INCLUDES_EXISTING_CONTENT) \
				$(INCLUDES_LOCAL_LIST)

INCLUDES_LIST+=			$(addprefix \
					$(INCLUDES_DIRS_PREFIX) , \
					$(INCLUDES_ALL_LIST))

endif

