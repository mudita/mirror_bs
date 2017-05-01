ifndef MK_APPLICATIONS_MK
MK_APPLICATIONS_MK=				TRUE

INCLUDER_MODULES_LIST=				dirs \
						config \
						relative

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

# INFO: Base directory.
APPLICATIONS_DIR=				$(RELATIVE_ROOT_DIR)/$(DIRS_APPLICATIONS_DIR)

# INFO: Content of base directory (command).
APPLICATIONS_AVAILABLE_ALL_COMMAND=		ls \
							$(APPLICATIONS_DIR)

# INFO: Content of base directory (value).
APPLICATIONS_AVAILABLE_ALL=			$(shell \
							$(APPLICATIONS_AVAILABLE_ALL_COMMAND))

# INFO: Base directory (in foreach loop).
APPLICATIONS_ITERATOR_DIR=			$(APPLICATIONS_DIR)/$($(CONFIG_APPLICATION_PREFIX))

# INFO: Build system script.
APPLICATIONS_MAKEFILE_FILE=			$(APPLICATIONS_ITERATOR_DIR)/$(CONFIG_MAKEFILE_FILE_NAME)

APPLICATIONS_MAKEFILE_TEST_CONDITION=		$(wildcard \
							$(APPLICATIONS_MAKEFILE_FILE))

APPLICATIONS_MAKEFILE_TEST_TRUE=		$($(CONFIG_APPLICATION_PREFIX))

APPLICATIONS_MAKEFILE_TEST_FALSE=

# INFO: Test of existence for build system script.
APPLICATIONS_MAKEFILE_WILDCARD_TEST=		$(if \
							$(APPLICATIONS_MAKEFILE_TEST_CONDITION), \
							$(APPLICATIONS_MAKEFILE_TEST_TRUE), \
							$(APPLICATIONS_MAKEFILE_TEST_FALSE))

# INFO: Units with build system script (nonstandard).
APPLICATIONS_AVAILABLE_NONSTANDARD_LIST=	$(foreach \
							$(CONFIG_APPLICATION_PREFIX), \
							$(APPLICATIONS_AVAILABLE_ALL), \
							$(APPLICATIONS_MAKEFILE_WILDCARD_TEST))

# INFO: Units without build system script (standard).
APPLICATIONS_AVAILABLE_STANDARD_LIST=		$(filter-out \
							$(APPLICATIONS_AVAILABLE_NONSTANDARD_LIST), \
							$(APPLICATIONS_AVAILABLE_ALL))

# INFO: Nonstandard avaiable (rule list).
APPLICATIONS_NONSTANDARD_LIST=			$(addprefix \
							$(CONFIG_APPLICATION_PREFIX)_, \
							$(APPLICATIONS_AVAILABLE_NONSTANDARD_LIST))

# INFO: Standard avaiable (rule list).
APPLICATIONS_STANDARD_LIST=			$(addprefix \
							$(CONFIG_APPLICATION_PREFIX)_, \
							$(APPLICATIONS_AVAILABLE_STANDARD_LIST))

# INFO: Build system script application.
APPLICATIONS_PLATFORMS_FILE=			$(APPLICATIONS_ITERATOR_DIR)/$(CONFIG_PLATFORMS_FILE_NAME)

# INFO: Get platforms from build system script application (command).
APPLICATIONS_PLATFORMS_AVAILABLE_LIST_COMMAND=	cat \
							$(APPLICATIONS_PLATFORMS_FILE)

# INFO: Get platforms from build system script application (value).
APPLICATIONS_PLATFORMS_AVAILABLE_LIST=		$(shell \
							$(APPLICATIONS_PLATFORMS_AVAILABLE_LIST_COMMAND))

# INFO: Test of existence for supported platforms list file (condition).
APPLICATIONS_PLATFORMS_TEST_CONDITION=		$(wildcard \
							$(APPLICATIONS_PLATFORMS_FILE))

# INFO: Test of existence for supported platforms list file (true).
APPLICATIONS_PLATFORMS_TEST_TRUE=		$(APPLICATIONS_PLATFORMS_AVAILABLE_LIST)

# INFO: Test of existence for supported platforms list file (false).
APPLICATIONS_PLATFORMS_TEST_FALSE=		$(PLATFORM_HOST_ARCHITECTURE)

# INFO: Test of existence for supported platforms list file (execution).
APPLICATIONS_PLATFORMS_WILDCARD_TEST=		$(if \
							$(APPLICATIONS_PLATFORMS_TEST_CONDITION), \
							$(APPLICATIONS_PLATFORMS_TEST_TRUE), \
							$(APPLICATIONS_PLATFORMS_TEST_FALSE))

# INFO: Add prefix with unit type and suffix with platform.
APPLICATIONS_PLATFORMS_NAME=			$(patsubst \
							%, \
							$(CONFIG_APPLICATION_PREFIX)_%$(PLATFORM_SEPARATOR), \
							$($(CONFIG_APPLICATION_PREFIX)))

# INFO: Implicit foreach loop to iterate on avaiable platforms.
APPLICATIONS_PLATFORMS_FULL=			$(addprefix \
							$(APPLICATIONS_PLATFORMS_NAME), \
							$(APPLICATIONS_PLATFORMS_WILDCARD_TEST))

# INFO: Nonstandard units with platforms.
APPLICATIONS_PLATFORMS_NONSTANDARD_LIST=	$(foreach \
							$(CONFIG_APPLICATION_PREFIX), \
							$(APPLICATIONS_AVAILABLE_NONSTANDARD_LIST), \
							$(APPLICATIONS_PLATFORMS_FULL))

# INFO: Standard units with platforms.
APPLICATIONS_PLATFORMS_STANDARD_LIST=		$(foreach \
							$(CONFIG_APPLICATION_PREFIX), \
							$(APPLICATIONS_AVAILABLE_STANDARD_LIST), \
							$(APPLICATIONS_PLATFORMS_FULL))

# INFO: All avaiable with platform suffix (unsorted).
APPLICATIONS_PLATFORMS_UNSORTED_LIST=		$(APPLICATIONS_PLATFORMS_STANDARD_LIST) \
						$(APPLICATIONS_PLATFORMS_NONSTANDARD_LIST)

# INFO: All avaiable with platform suffix (rule list, sorted).
APPLICATIONS_PLATFORMS_LIST=			$(sort \
							$(APPLICATIONS_PLATFORMS_UNSORTED_LIST))

endif

