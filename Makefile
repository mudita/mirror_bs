INCLUDER_MODULES_LIST=		clean \
				clean_full \
				dirs \
				flags_make \
				config \
				install \
				mode \
				platform \
				tools \
				modules \
				applications \
				run \
				dependencies \
				cgdb \
				console \
				templates \
				self_test \
				launcher \
				locale \
				doc

##############################################################################
# TODO: Solve it in more clever way (if possible).
# INFO: Bootstrap code.
##############################################################################
PLATFORM_C_COMPILER=		gcc
SIGNATURE_VERSION_SWITCH=	-dumpversion
SIGNATURE_ARCHITECTURE_SWITCH=	-dumpmachine

SIGNATURE_VERSION_COMMAND=	$(PLATFORM_C_COMPILER) \
					$(SIGNATURE_VERSION_SWITCH)

SIGNATURE_ARCHITECTURE_COMMAND=	$(PLATFORM_C_COMPILER) \
					$(SIGNATURE_ARCHITECTURE_SWITCH)

SIGNATURE_COMPILER_VERSION=	$(shell \
					$(SIGNATURE_VERSION_COMMAND))

SIGNATURE_TARGET_ARCHITECTURE=	$(shell \
					$(SIGNATURE_ARCHITECTURE_COMMAND))

SIGNATURE_SUFFIX=		$(PLATFORM_C_COMPILER)_$(SIGNATURE_COMPILER_VERSION)_$(SIGNATURE_TARGET_ARCHITECTURE)

TOOLS_DIRECTORY=		$(realpath .)/tools
APPLICATIONS_DIRECTORY=		$(realpath .)/applications

MODBUILD_NAME=			modbuild
MODBUILD_BINARY_NAME=		$(MODBUILD_NAME)
MAKE_TO_GRAPH_NAME=		makefile2graph

MODBUILD_DIRECTORY=		$(TOOLS_DIRECTORY)/$(MODBUILD_NAME)
MAKE_TO_GRAPH_DIRECTORY=	$(TOOLS_DIRECTORY)/$(MAKE_TO_GRAPH_NAME)

MODBUILD_BINARY_PATH=		$(MODBUILD_DIRECTORY)/install/$(MODBUILD_BINARY_NAME)
MAKE_TO_GRAPH_BINARY_PATH=	$(MAKE_TO_GRAPH_DIRECTORY)/install/$(MAKE_TO_GRAPH_NAME)

MODBUILD_CHECK_BINARY=		$(wildcard \
					$(MODBUILD_BINARY_PATH))

ifneq ($(MODBUILD_CHECK_BINARY), )
INCLUDER_PATH=			$(MODBUILD_DIRECTORY)/install/bs/includer.mk
INCLUDER_BINARY_PATH=		$(MODBUILD_BINARY_PATH)
else
$(warning ------> WARNING - SLOW VERSION OF THE BUILD SYSTEM <------)
$(warning To speed up the build system, first run:)
$(warning make module_check-host)
$(warning make module_utils-host)
$(warning make tool_$(MODBUILD_NAME))
$(warning ------> WARNING - SLOW VERSION OF THE BUILD SYSTEM <------)

INCLUDER_PATH=			$(MODBUILD_DIRECTORY)/bs/bootstrap_includer.mk
endif

include $(INCLUDER_PATH)
##############################################################################

$(CONFIG_ALL_RULE): \
		$(APPLICATIONS_LIST)

$(CONFIG_CLEAN_RULE): \
		$(CONFIG_CLEAN_RULE)_$(DIRS_APPLICATIONS_DIR) \
		$(CONFIG_CLEAN_RULE)_$(DIRS_MODULES_DIR) \
		$(CLEAN_DOC_DEFAULT_HTML_LIST)

$(CONFIG_CLEAN_RULE)_$(DIRS_APPLICATIONS_DIR): \
		$(CLEAN_APPLICATIONS_STANDARD_LIST) \
		$(CLEAN_APPLICATIONS_NONSTANDARD_LIST)

$(CONFIG_CLEAN_RULE)_$(DIRS_MODULES_DIR): \
		$(CLEAN_MODULES_STANDARD_LIST) \
		$(CLEAN_MODULES_NONSTANDARD_LIST)

$(CONFIG_CLEAN_RULE)_$(DIRS_TOOLS_DIR): \
		$(CLEAN_TOOLS_STANDARD_LIST) \
		$(CLEAN_TOOLS_NONSTANDARD_LIST)

$(CONFIG_CLEAN_FULL_RULE): \
		$(CONFIG_CLEAN_FULL_RULE)_$(DIRS_APPLICATIONS_DIR) \
		$(CONFIG_CLEAN_FULL_RULE)_$(DIRS_MODULES_DIR) \
		$(CONFIG_CLEAN_FULL_RULE)_$(DIRS_TOOLS_DIR) \
		$(CLEAN_DOC_DEFAULT_HTML_LIST)

$(CONFIG_CLEAN_FULL_RULE)_$(DIRS_APPLICATIONS_DIR): \
		$(CLEAN_FULL_APPLICATIONS_STANDARD_LIST) \
		$(CLEAN_FULL_APPLICATIONS_NONSTANDARD_LIST)

$(CONFIG_CLEAN_FULL_RULE)_$(DIRS_MODULES_DIR): \
		$(CLEAN_FULL_MODULES_STANDARD_LIST) \
		$(CLEAN_FULL_MODULES_NONSTANDARD_LIST)

$(CONFIG_CLEAN_FULL_RULE)_$(DIRS_TOOLS_DIR): \
		$(CLEAN_FULL_TOOLS_STANDARD_LIST) \
		$(CLEAN_FULL_TOOLS_NONSTANDARD_LIST)

# TODO: Is not able to build in parallel. Should be fixed.
# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(TOOLS_NONSTANDARD_LIST): \
		$(CONFIG_TOOL_PREFIX)_%: \
		$(DEPENDENCIES_FILE)
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_TOOLS_DIR)/$* \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_ALL_RULE)

# TODO: Is not able to build in parallel. Should be fixed.
# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(TOOLS_STANDARD_LIST): \
		$(CONFIG_TOOL_PREFIX)_%: \
		$(DEPENDENCIES_FILE)
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_TOOLS_DIR)/$* \
		-f \
		$(TEMPLATE_TOOL_FILE) \
		$(CONFIG_ALL_RULE)

# TODO: Try no to use variable PLATFORM but rule with architecture instead.
# TODO: Try to hide this command execution in variable.
$(MODULES_PLATFORMS_NONSTANDARD_LIST): \
		$(CONFIG_MODULE_PREFIX)_%: \
		$(DEPENDENCIES_FILE)
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		PLATFORM=$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			2) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_MODULES_DIR)/$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			1) \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_ALL_RULE)

# TODO: Try no to use variable PLATFORM but rule with architecture instead.
# TODO: Try to hide this command execution in variable.
$(MODULES_PLATFORMS_STANDARD_LIST): \
		$(CONFIG_MODULE_PREFIX)_%: \
		$(DEPENDENCIES_FILE)
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		PLATFORM=$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			2) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_MODULES_DIR)/$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			1) \
		-f \
		$(TEMPLATE_MODULE_FILE) \
		$(CONFIG_ALL_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(APPLICATIONS_PLATFORMS_NONSTANDARD_LIST): \
		$(CONFIG_APPLICATION_PREFIX)_%: \
		$(DEPENDENCIES_FILE)
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		PLATFORM=$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			2) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			1) \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_ALL_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(APPLICATIONS_PLATFORMS_STANDARD_LIST): \
		$(CONFIG_APPLICATION_PREFIX)_%: \
		$(DEPENDENCIES_FILE)
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		PLATFORM=$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			2) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			1) \
		-f \
		$(TEMPLATE_APPLICATION_FILE) \
		$(CONFIG_ALL_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_TOOLS_NONSTANDARD_LIST): \
		$(CLEAN_TOOLS_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_TOOLS_DIR)/$* \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_CLEAN_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_TOOLS_STANDARD_LIST): \
		$(CLEAN_TOOLS_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_TOOLS_DIR)/$* \
		-f \
		$(TEMPLATE_TOOL_FILE) \
		$(CONFIG_CLEAN_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_MODULES_NONSTANDARD_LIST): \
		$(CLEAN_MODULES_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_MODULES_DIR)/$* \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_CLEAN_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_MODULES_STANDARD_LIST): \
		$(CLEAN_MODULES_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_MODULES_DIR)/$* \
		-f \
		$(TEMPLATE_MODULE_FILE) \
		$(CONFIG_CLEAN_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_APPLICATIONS_NONSTANDARD_LIST): \
		$(CLEAN_APPLICATIONS_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$* \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_CLEAN_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_APPLICATIONS_STANDARD_LIST): \
		$(CLEAN_APPLICATIONS_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$* \
		-f \
		$(TEMPLATE_APPLICATION_FILE) \
		$(CONFIG_CLEAN_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_FULL_TOOLS_NONSTANDARD_LIST): \
		$(CLEAN_FULL_TOOLS_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_TOOLS_DIR)/$* \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_CLEAN_FULL_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_FULL_TOOLS_STANDARD_LIST): \
		$(CLEAN_FULL_TOOLS_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_TOOLS_DIR)/$* \
		-f \
		$(TEMPLATE_TOOL_FILE) \
		$(CONFIG_CLEAN_FULL_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_FULL_MODULES_NONSTANDARD_LIST): \
		$(CLEAN_FULL_MODULES_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_MODULES_DIR)/$* \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_CLEAN_FULL_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_FULL_MODULES_STANDARD_LIST): \
		$(CLEAN_FULL_MODULES_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_MODULES_DIR)/$* \
		-f \
		$(TEMPLATE_MODULE_FILE) \
		$(CONFIG_CLEAN_FULL_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_FULL_APPLICATIONS_NONSTANDARD_LIST): \
		$(CLEAN_FULL_APPLICATIONS_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$* \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_CLEAN_FULL_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
$(CLEAN_FULL_APPLICATIONS_STANDARD_LIST): \
		$(CLEAN_FULL_APPLICATIONS_PREFIX)_%:
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$* \
		-f \
		$(TEMPLATE_APPLICATION_FILE) \
		$(CONFIG_CLEAN_FULL_RULE)

$(CLEAN_DOC_DEFAULT_HTML_LIST): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CGDB_STANDARD_LIST): \
		$(CGDB_PREFIX)_%: \
		$(CONFIG_APPLICATION_PREFIX)_%
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		PLATFORM=$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			2) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			1) \
		-f \
		$(TEMPLATE_APPLICATION_FILE) \
		$(CONFIG_CGDB_RULE)

$(CGDB_NONSTANDARD_LIST): \
		$(CGDB_PREFIX)_%: \
		$(DEPENDENCIES_FILE)
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		PLATFORM=$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			2) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			1) \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_CGDB_RULE)

# TODO: Try to hide realpath via variable
$(RUN_STANDARD_LIST): \
		$(RUN_PREFIX)_%: \
		$(DEPENDENCIES_FILE)
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		ARGS=$(ARGS) \
		WD=$(realpath $(WD)) \
		PLATFORM=$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			2) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			1) \
		-f \
		$(TEMPLATE_APPLICATION_FILE) \
		$(CONFIG_RUN_RULE)

# TODO: These veriables cannot be passed here! Try solve it like in launcher.
# TODO: Try to hide realpath via variable
$(RUN_NONSTANDARD_LIST): \
		$(RUN_PREFIX)_%: \
		$(DEPENDENCIES_FILE)
	make \
		INCLUDER_PATH=$(INCLUDER_PATH) \
		INCLUDER_BINARY_PATH=$(INCLUDER_BINARY_PATH) \
		ARGS=$(ARGS) \
		WD=$(realpath $(WD)) \
		PLATFORM=$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			2) \
		$(LAUNCHER_VARIABLES) \
		$(FLAGS_MAKE_LIST) \
		-C \
		$(DIRS_APPLICATIONS_DIR)/$(shell \
			echo \
			$* | \
			cut \
			-d \
			$(PLATFORM_SEPARATOR) \
			-f \
			1) \
		-f \
		$(CONFIG_MAKEFILE_FILE_NAME) \
		$(CONFIG_RUN_RULE)

$(DOC_DEFAULT_HTML_LIST): \
		%.$(CONFIG_HTML_FILE_EXT): \
		%.$(CONFIG_ASCIIDOC_FILE_EXT)
	asciidoc \
		-o \
		$@ \
		$<

$(CONSOLE_LIST): \
		$(CONSOLE_PREFIX)_%:
	tailf \
		-n \
		$(CONFIG_WATCH_LINES) \
		$(DIRS_APPLICATIONS_DIR)/$*/$(DIRS_INSTALL_DIR)/$(CONSOLE_FILE)

