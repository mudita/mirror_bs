ifndef MK_LIBS_MK
MK_LIBS_MK=			TRUE

INCLUDER_MODULES_LIST=		dirs \
				config \
				modules \
				signature \
				alloc \
				platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

LIBS_DIRS_PREFIX=		-L
LIBS_PREFIX=			-l

##############################################################################
# INFO: Dependency mechanism.
##############################################################################
# TODO: This code is present in includes.mk, libs.mk and coverage.mk - merge it!
LIBS_DEP_GENERIC_FILE_NAME=	$(CONFIG_MODULE_DEP_FILE_NAME)
LIBS_DEP_PLATFORM_FILE_NAME=	$(CONFIG_MODULE_DEP_FILE_NAME)/$(PLATFORM)

LIBS_DEPENDENCIES_EXISTENCE=	$(wildcard \
					$(LIBS_DEP_GENERIC_FILE_NAME))

LIBS_DEPENDENCIES_PLAT_EXISTENCE=	$(wildcard \
						$(LIBS_DEP_PLATFORM_FILE_NAME))

ifneq ($(LIBS_DEPENDENCIES_PLAT_EXISTENCE), )
LIBS_DEPENDENCIES_COMMAND=	cat \
					$(INCLUDES_DEP_PLATFORM_FILE_NAME)

LIBS_MODULES_LIST=		$(shell \
					$(LIBS_DEPENDENCIES_COMMAND))
else ifneq ($(LIBS_DEPENDENCIES_EXISTENCE), )
LIBS_DEPENDENCIES_COMMAND=	cat \
					$(LIBS_DEP_GENERIC_FILE_NAME)

LIBS_MODULES_LIST=		$(shell \
					$(LIBS_DEPENDENCIES_COMMAND))
else
LIBS_MODULES_LIST=
endif

##############################################################################

# TODO: Names should be associated to alloc.mk
LIBS_MODULES_FORBIDDEN_LIST=	md_mem_std \
				md_mem_pool \
				md_mem_heap \
				md_mem_mtrace

LIBS_MODULES_REDUCED_LIST=	$(filter-out \
					$(LIBS_MODULES_FORBIDDEN_LIST), \
					$(LIBS_MODULES_LIST))

# TODO: Do nit define additional names, modules should be callet like in alloc.mk
ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_MEM_NONE))
LIBS_CONDITIONAL_MODULES=
else ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_MEM_STD))
LIBS_CONDITIONAL_MODULES=	md_mem_std \
				md_mem_mtrace
else ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_MEM_POOL))
LIBS_CONDITIONAL_MODULES=	md_mem_pool \
				md_mem_mtrace
else ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_MEM_HEAP))
LIBS_CONDITIONAL_MODULES=	md_mem_heap \
				md_mem_mtrace
else
LIBS_CONDITIONAL_MODULES=
endif

LIBS_MODULES_COND_LIST=		$(LIBS_MODULES_REDUCED_LIST) \
				$(LIBS_CONDITIONAL_MODULES)

LIBS_MODULE_ROOT_DIR=		$(DIRS_MODULES_DIR)/$($(CONFIG_MODULE_PREFIX))
LIBS_MODULE_INSTALL_DIR=	$(LIBS_MODULE_ROOT_DIR)/$(DIRS_LIB_DIR)/$(PLATFORM)
LIBS_MODULE_INSTALL_RELATIVE_DIR=	$(RELATIVE_ROOT_DIR)/$(LIBS_MODULE_INSTALL_DIR)
LIBS_MODULE_LIB_NAME=		$($(CONFIG_MODULE_PREFIX))_$(SIGNATURE_SUFFIX)
LIBS_MODULE_LIB_FILE_NAME=	$(CONFIG_LIB_PREFIX)$(LIBS_MODULE_LIB_NAME).$(CONFIG_STATIC_LIBRARY_EXT)
LIBS_MODULE_LIB_FILE=		$(LIBS_MODULE_INSTALL_RELATIVE_DIR)/$(LIBS_MODULE_LIB_FILE_NAME)

LIBS_MODULE_EXIST_TEST=		$(wildcard \
					$(LIBS_MODULE_LIB_FILE))

LIBS_MODULE_FOUND_FORMATTER=	'%s %s %s %s'

LIBS_MODULE_FOUND_COMMAND=	printf \
					$(LIBS_MODULE_FOUND_FORMATTER) \
					$(LIBS_DIRS_PREFIX) \
					$(LIBS_MODULE_INSTALL_RELATIVE_DIR) \
					$(LIBS_PREFIX) \
					$(LIBS_MODULE_LIB_NAME)

LIBS_MODULE_FOUND_SUCCESS=	$(shell \
					$(LIBS_MODULE_FOUND_COMMAND))

LIBS_MODULE_FOUND_ERROR=	$(error \
					Library $(LIBS_MODULE_LIB_FILE_NAME) not found!)

LIBS_MODULE_CHECK_EXIST=	$(if \
					$(LIBS_MODULE_EXIST_TEST), \
					$(LIBS_MODULE_FOUND_SUCCESS), \
					$(LIBS_MODULE_FOUND_ERROR))

LIBS_LIST=			$(foreach \
					$(CONFIG_MODULE_PREFIX), \
					$(LIBS_MODULES_COND_LIST), \
					$(LIBS_MODULE_CHECK_EXIST))

endif

