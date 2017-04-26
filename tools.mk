ifndef MK_TOOLS_MK
MK_TOOLS_MK=					TRUE

INCLUDER_MODULES_LIST=				dirs \
						config \
						relative

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

TOOLS_DIR=					$(RELATIVE_ROOT_DIR)/$(DIRS_TOOLS_DIR)

TOOLS_ALL_COMMAND=				ls \
							$(TOOLS_DIR)

TOOLS_ALL=					$(shell \
							$(TOOLS_ALL_COMMAND))

TOOLS_MAKEFILE_DIR=				$(DIRS_TOOLS_DIR)/$($(CONFIG_TOOL_PREFIX))

TOOLS_MAKEFILE_FILE=				$(TOOLS_MAKEFILE_DIR)/$(CONFIG_MAKEFILE_FILE_NAME)

TOOLS_MAKEFILE_WILDCARD_TEST=			$(wildcard \
							$(TOOLS_MAKEFILE_FILE))

TOOLS_MAKEFILE_FILES_LIST=			$(foreach \
							$(CONFIG_TOOL_PREFIX), \
							$(TOOLS_ALL), \
							$(TOOLS_MAKEFILE_WILDCARD_TEST))

TOOLS_AVAILABLE_NONSTANDARD=			$(patsubst \
							$(DIRS_TOOLS_DIR)/%/$(CONFIG_MAKEFILE_FILE_NAME), \
							%, \
							$(TOOLS_MAKEFILE_FILES_LIST))

TOOLS_AVAILABLE_STANDARD=			$(filter-out \
							$(TOOLS_AVAILABLE_NONSTANDARD), \
							$(TOOLS_ALL))

TOOLS_STANDARD_LIST=				$(addprefix \
							$(CONFIG_TOOL_PREFIX)_, \
							$(TOOLS_AVAILABLE_STANDARD))

TOOLS_NONSTANDARD_LIST=				$(addprefix \
							$(CONFIG_TOOL_PREFIX)_, \
							$(TOOLS_AVAILABLE_NONSTANDARD))

# INFO: All avaiable with platform suffix (unsorted).
TOOLS_UNSORTED_LIST=				$(TOOLS_STANDARD_LIST) \
						$(TOOLS_NONSTANDARD_LIST)

# INFO: All avaiable with platform suffix (rule list, sorted).
TOOLS_LIST=					$(sort \
							$(TOOLS_UNSORTED_LIST))

endif

