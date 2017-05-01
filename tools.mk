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

# INFO: Base directory.
TOOLS_DIR=					$(RELATIVE_ROOT_DIR)/$(DIRS_TOOLS_DIR)

# INFO: Content of base directory (command).
TOOLS_AVAILABLE_ALL_COMMAND=			ls \
							$(TOOLS_DIR)

# INFO: Content of base directory (value).
TOOLS_AVAILABLE_ALL=				$(shell \
							$(TOOLS_AVAILABLE_ALL_COMMAND))

# INFO: Base directory (in foreach loop).
TOOLS_ITERATOR_DIR=				$(TOOLS_DIR)/$($(CONFIG_TOOL_PREFIX))

# INFO: Build system script.
TOOLS_MAKEFILE_FILE=				$(TOOLS_ITERATOR_DIR)/$(CONFIG_MAKEFILE_FILE_NAME)

TOOLS_MAKEFILE_TEST_CONDITION=			$(wildcard \
							$(TOOLS_MAKEFILE_FILE))

TOOLS_MAKEFILE_TEST_TRUE=			$($(CONFIG_TOOL_PREFIX))

TOOLS_MAKEFILE_TEST_FALSE=

# INFO: Test of existence for build system script.
TOOLS_MAKEFILE_WILDCARD_TEST=			$(if \
							$(TOOLS_MAKEFILE_TEST_CONDITION), \
							$(TOOLS_MAKEFILE_TEST_TRUE), \
							$(TOOLS_MAKEFILE_TEST_FALSE))

# INFO: Units with build system script (nonstandard).
TOOLS_AVAILABLE_NONSTANDARD_LIST=		$(foreach \
							$(CONFIG_TOOL_PREFIX), \
							$(TOOLS_AVAILABLE_ALL), \
							$(TOOLS_MAKEFILE_WILDCARD_TEST))

# INFO: Units without build system script (standard).
TOOLS_AVAILABLE_STANDARD_LIST=			$(filter-out \
							$(TOOLS_AVAILABLE_NONSTANDARD_LIST), \
							$(TOOLS_AVAILABLE_ALL))

# INFO: Nonstandard avaiable (rule list).
TOOLS_NONSTANDARD_LIST=				$(addprefix \
							$(CONFIG_TOOL_PREFIX)_, \
							$(TOOLS_AVAILABLE_NONSTANDARD_LIST))

# INFO: Standard avaiable (rule list).
TOOLS_STANDARD_LIST=				$(addprefix \
							$(CONFIG_TOOL_PREFIX)_, \
							$(TOOLS_AVAILABLE_STANDARD_LIST))

# INFO: Build system script application.
TOOLS_PLATFORMS_FILE=				$(TOOLS_ITERATOR_DIR)/$(CONFIG_PLATFORMS_FILE_NAME)

# INFO: Get platforms from build system script application (command).
TOOLS_PLATFORMS_AVAILABLE_LIST_COMMAND=		cat \
							$(TOOLS_PLATFORMS_FILE)

# INFO: Get platforms from build system script application (value).
TOOLS_PLATFORMS_AVAILABLE_LIST=			$(shell \
							$(TOOLS_PLATFORMS_AVAILABLE_LIST_COMMAND))

# INFO: Test of existence for supported platforms list file (condition).
TOOLS_PLATFORMS_TEST_CONDITION=			$(wildcard \
							$(TOOLS_PLATFORMS_FILE))

# INFO: Test of existence for supported platforms list file (true).
TOOLS_PLATFORMS_TEST_TRUE=			$(TOOLS_PLATFORMS_AVAILABLE_LIST)

# INFO: Test of existence for supported platforms list file (false).
TOOLS_PLATFORMS_TEST_FALSE=			$(PLATFORM_HOST_ARCHITECTURE)

# INFO: Test of existence for supported platforms list file (execution).
TOOLS_PLATFORMS_WILDCARD_TEST=			$(if \
							$(TOOLS_PLATFORMS_TEST_CONDITION), \
							$(TOOLS_PLATFORMS_TEST_TRUE), \
							$(TOOLS_PLATFORMS_TEST_FALSE))

# INFO: Add prefix with unit type and suffix with platform.
TOOLS_PLATFORMS_NAME=				$(patsubst \
							%, \
							$(CONFIG_TOOL_PREFIX)_%$(PLATFORM_SEPARATOR), \
							$($(CONFIG_TOOL_PREFIX)))

# INFO: Implicit foreach loop to iterate on avaiable platforms.
TOOLS_PLATFORMS_FULL=				$(addprefix \
							$(TOOLS_PLATFORMS_NAME), \
							$(TOOLS_PLATFORMS_WILDCARD_TEST))

# INFO: Nonstandard units with platforms.
TOOLS_PLATFORMS_NONSTANDARD_LIST=		$(foreach \
							$(CONFIG_TOOL_PREFIX), \
							$(TOOLS_AVAILABLE_NONSTANDARD_LIST), \
							$(TOOLS_PLATFORMS_FULL))

# INFO: Standard units with platforms.
TOOLS_PLATFORMS_STANDARD_LIST=			$(foreach \
							$(CONFIG_TOOL_PREFIX), \
							$(TOOLS_AVAILABLE_STANDARD_LIST), \
							$(TOOLS_PLATFORMS_FULL))

# INFO: All avaiable with platform suffix (unsorted).
TOOLS_PLATFORMS_UNSORTED_LIST=			$(TOOLS_PLATFORMS_STANDARD_LIST) \
						$(TOOLS_PLATFORMS_NONSTANDARD_LIST)

# INFO: All avaiable with platform suffix (rule list, sorted).
TOOLS_PLATFORMS_LIST=				$(sort \
							$(TOOLS_PLATFORMS_UNSORTED_LIST))

endif

