ifndef MK_INSTALL_MK
MK_INSTALL_MK=			TRUE

INCLUDER_MODULES_LIST=		config \
				dirs \
				signature \
				includes

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

INSTALL_PLATFORM_DIR=		$(DIRS_INSTALL_DIR)/$(PLATFORM)

INSTALL_APPLICATION_ELF_FILE=	$(INSTALL_PLATFORM_DIR)/$(SIGNATURE_APPLICATION_FILE_NAME)
INSTALL_APPLICATION_TEST_ELF_FILE=	$(INSTALL_PLATFORM_DIR)/$(SIGNATURE_APPLICATION_TEST_FILE_NAME)

INSTALL_MODULE_LIB_FILE=	$(DIRS_LIB_DIR)/$(PLATFORM)/$(SIGNATURE_MODULE_FILE_NAME)
INSTALL_TOOL_ELF_FILE=		$(INSTALL_PLATFORM_DIR)/$(SIGNATURE_TOOL_FILE_NAME)

INSTALL_AVAILABLE_ALL_COMMAND=	ls

INSTALL_AVAILABLE_ALL=		$(shell \
					$(INSTALL_AVAILABLE_ALL_COMMAND))

INSTALL_IGNORE_LIST=		$(DIRS_INSTALL_DIR) \
				$(CONFIG_MAKEFILE_FILE_NAME) \
				$(CONFIG_DEPENDENCIES_FILE_NAME) \
				$(CONFIG_EXTERNALS_FILE_NAME) \
				$(CONFIG_PLATFORMS_FILE_NAME) \
				$(CONFIG_GDB_SCRIPT_FILE_NAME) \
				$(CONFIG_ARGS_FILE_NAME) \
				$(CONFIG_IN_FLAGS_FILE_NAME) \
				$(CONFIG_OUT_FLAGS_FILE_NAME) \
				$(CONFIG_MODULE_DEP_FILE_NAME) \
				$(CONFIG_APPLICATION_DEP_FILE_NAME) \
				$(CONFIG_TOOL_DEP_FILE_NAME) \
				$(DIRS_SOURCES_DIR) \
				$(DIRS_INCLUDE_DIR) \
				$(DIRS_OBJECTS_DIR) \
				$(DIRS_LINKER_DIR) \
				$(DIRS_DOC_DIR) \
				$(DIRS_PNG_DIR) \
				$(DIRS_AUX_DIR) \
				$(DIRS_DEP_DIR) \
				$(DIRS_GDB_DIR)

INSTALL_TO_COPY_DIR_LIST=	$(filter-out \
					$(INSTALL_IGNORE_LIST), \
					$(INSTALL_AVAILABLE_ALL))

ifneq ($(INSTALL_TO_COPY_DIR_LIST), )
INSTALL_TO_COPY_FILE_LIST_COMMAND=	find \
						$(INSTALL_TO_COPY_DIR_LIST) \
						-type \
						f

INSTALL_TO_COPY_FILE_LIST=	$(shell \
					$(INSTALL_TO_COPY_FILE_LIST_COMMAND))

INSTALL_OTHER_FILE_LIST=	$(addprefix \
					$(INSTALL_PLATFORM_DIR)/, \
					$(INSTALL_TO_COPY_FILE_LIST))
else
INSTALL_OTHER_FILE_LIST=
endif

endif

