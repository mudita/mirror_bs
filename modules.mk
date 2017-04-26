ifndef MK_MODULES_MK
MK_MODULES_MK=					TRUE

INCLUDER_MODULES_LIST=				dirs \
						config \
						relative

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

# INFO: Base directory.
MODULES_DIR=					$(RELATIVE_ROOT_DIR)/$(DIRS_MODULES_DIR)

# INFO: Content of base directory (command).
MODULES_AVAILABLE_ALL_COMMAND=			ls \
							$(MODULES_DIR)

# INFO: Content of base directory (value).
MODULES_AVAILABLE_ALL=				$(shell \
							$(MODULES_AVAILABLE_ALL_COMMAND))

# INFO: Base directory (in foreach loop).
MODULES_ITERATOR_DIR=				$(MODULES_DIR)/$($(CONFIG_MODULE_PREFIX))

# INFO: Build system script.
MODULES_MAKEFILE_FILE=				$(MODULES_ITERATOR_DIR)/$(CONFIG_MAKEFILE_FILE_NAME)

MODULES_MAKEFILE_TEST_CONDITION=		$(wildcard \
							$(MODULES_MAKEFILE_FILE))

MODULES_MAKEFILE_TEST_TRUE=			$($(CONFIG_MODULE_PREFIX))

MODULES_MAKEFILE_TEST_FALSE=

# INFO: Test of existence for build system script.
MODULES_MAKEFILE_WILDCARD_TEST=			$(if \
							$(MODULES_MAKEFILE_TEST_CONDITION), \
							$(MODULES_MAKEFILE_TEST_TRUE), \
							$(MODULES_MAKEFILE_TEST_FALSE))

# INFO: Units with build system script (nonstandard).
MODULES_AVAILABLE_NONSTANDARD_LIST=		$(foreach \
							$(CONFIG_MODULE_PREFIX), \
							$(MODULES_AVAILABLE_ALL), \
							$(MODULES_MAKEFILE_WILDCARD_TEST))

# INFO: Units without build system script (standard).
MODULES_AVAILABLE_STANDARD_LIST=		$(filter-out \
							$(MODULES_AVAILABLE_NONSTANDARD_LIST), \
							$(MODULES_AVAILABLE_ALL))

# INFO: Nonstandard avaiable (rule list).
MODULES_NONSTANDARD_LIST=			$(addprefix \
							$(CONFIG_MODULE_PREFIX)_, \
							$(MODULES_AVAILABLE_NONSTANDARD_LIST))

# INFO: Standard avaiable (rule list).
MODULES_STANDARD_LIST=				$(addprefix \
							$(CONFIG_MODULE_PREFIX)_, \
							$(MODULES_AVAILABLE_STANDARD_LIST))

# INFO: Build system script module.
MODULES_PLATFORMS_FILE=				$(MODULES_ITERATOR_DIR)/$(CONFIG_PLATFORMS_FILE_NAME)

# INFO: Get platforms from build system script module (command).
MODULES_PLATFORMS_AVAILABLE_LIST_COMMAND=	cat \
							$(MODULES_PLATFORMS_FILE)

# INFO: Get platforms from build system script module (value).
MODULES_PLATFORMS_AVAILABLE_LIST=		$(shell \
							$(MODULES_PLATFORMS_AVAILABLE_LIST_COMMAND))

# INFO: Test of existence for supported platforms list file (condition).
MODULES_PLATFORMS_TEST_CONDITION=		$(wildcard \
							$(MODULES_PLATFORMS_FILE))

# INFO: Test of existence for supported platforms list file (true).
MODULES_PLATFORMS_TEST_TRUE=			$(MODULES_PLATFORMS_AVAILABLE_LIST)

# INFO: Test of existence for supported platforms list file (false).
MODULES_PLATFORMS_TEST_FALSE=			$(PLATFORM_HOST_ARCHITECTURE)

# INFO: Test of existence for supported platforms list file (execution).
MODULES_PLATFORMS_WILDCARD_TEST=		$(if \
							$(MODULES_PLATFORMS_TEST_CONDITION), \
							$(MODULES_PLATFORMS_TEST_TRUE), \
							$(MODULES_PLATFORMS_TEST_FALSE))

# INFO: Add prefix with unit type and suffix with platform.
MODULES_PLATFORMS_NAME=				$(patsubst \
							%, \
							$(CONFIG_MODULE_PREFIX)_%$(PLATFORM_SEPARATOR), \
							$($(CONFIG_MODULE_PREFIX)))

# INFO: Implicit foreach loop to iterate on avaiable platforms.
MODULES_PLATFORMS_FULL=				$(addprefix \
							$(MODULES_PLATFORMS_NAME), \
							$(MODULES_PLATFORMS_WILDCARD_TEST))

# INFO: Nonstandard units with platforms.
MODULES_PLATFORMS_NONSTANDARD_LIST=		$(foreach \
							$(CONFIG_MODULE_PREFIX), \
							$(MODULES_AVAILABLE_NONSTANDARD_LIST), \
							$(MODULES_PLATFORMS_FULL))

# INFO: Standard units with platforms.
MODULES_PLATFORMS_STANDARD_LIST=		$(foreach \
							$(CONFIG_MODULE_PREFIX), \
							$(MODULES_AVAILABLE_STANDARD_LIST), \
							$(MODULES_PLATFORMS_FULL))

# INFO: All avaiable with platform suffix (unsorted).
MODULES_PLATFORMS_UNSORTED_LIST=		$(MODULES_PLATFORMS_STANDARD_LIST) \
						$(MODULES_PLATFORMS_NONSTANDARD_LIST)

# INFO: All avaiable with platform suffix (rule list, sorted).
MODULES_PLATFORMS_LIST=				$(sort \
							$(MODULES_PLATFORMS_UNSORTED_LIST))

endif

