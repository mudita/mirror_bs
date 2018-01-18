ifndef MK_MODE_MK
MK_MODE_MK=			TRUE

INCLUDER_MODULES_LIST=		install

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Not sure if needed.
# INFO: The architecture of the output binaries.
#MODE_OUTPUT_ARCHITECTURE=	32_BIT
MODE_OUTPUT_ARCHITECTURE=	64_BIT

# TODO: Some options are not clever if sanitizers are used.
# TODO: Change name from memroy leak detectors to memory wrapper
# INFO: The memory leak detection method.
MODE_MEMORY_LEAK_DETECTOR=	NONE
#MODE_MEMORY_LEAK_DETECTOR=	MODULE_MEMORY_MTRACE
#MODE_MEMORY_LEAK_DETECTOR=	MODULE_MEMORY_WRAPPER

# INFO: Sanitizers.
# INFO: Symbols used in the exclusion table:
#       A - address sanitizer
#       T - thread sanitizer
#       L - leak sanitizer
#       M - memory sanitizer
#       - - not applicable
#       x - illegal combination
#       o - legal combination
#
#           +---+---+---+---
#           | A | T | L | M
#       +---+---+---+---+---
#       | A | - | x | o | x
#       +---+---+---+---+---
#       | T | - | - | x | x
#       +---+---+---+---+---
#       | L | - | - | - | x
#       +---+---+---+---+---
#       | M | - | - | - | -
#       +---+---+---+---+---
#
#           +--------+--------+
#           | 32_BIT | 64_BIT |
#       +---+--------+--------+
#       | A |    o   |    o   | # TODO: Make sure of it!
#       +---+--------+--------+
#       | T |    x   |    o   |
#       +---+--------+--------+
#       | L |    x   |    o   |
#       +---+--------+--------+
#       | M |    x   |    o   |
#       +---+--------+--------+
#
MODE_SANITIZER_ADDRESS=		ENABLE
#MODE_SANITIZER_THREAD=		ENABLE
MODE_SANITIZER_LEAK=		ENABLE
#MODE_SANITIZER_MEMORY=		ENABLE
# TODO: Data Flow Sanitizer
# TODO: Coverage sanitizer


# INFO: Sanity check for the architecture of the output binaries.
ifndef MODE_OUTPUT_ARCHITECTURE
$(error MODE_OUTPUT_ARCHITECTURE was not specified!)
endif

# INFO: Sanity check for the memory leak detection method.
ifndef MODE_MEMORY_LEAK_DETECTOR
$(error MODE_MEMORY_LEAK_DETECTOR was not specified!)
endif

MODE_APPLICATION_MTRACE_FILE=		$(DIRS_INSTALL_DIR)/$(CONFIG_MTRACE_FILE_NAME)
MODE_APPLICATION_OS_LOG_FILE=		$(DIRS_INSTALL_DIR)/$(CONFIG_OS_LOG_FILE_NAME)
MODE_APPLICATION_OS_STATS_FILE=		$(DIRS_INSTALL_DIR)/$(CONFIG_OS_STATS_FILE_NAME)

MODE_MTRACE_COMMAND=			test \
						-f \
					$(MODE_APPLICATION_MTRACE_FILE) && \
					mtrace \
						$(INSTALL_APPLICATION_ELF_FILE) \
						$(MODE_APPLICATION_MTRACE_FILE) || \
					true

# INFO: Sanity check to find out incompatible architecture combinations.
ifeq ($(MODE_OUTPUT_ARCHITECTURE), 32_BIT)
# TODO: address sanitizer - both 32 bit and 64 bit
#ifdef MODE_SANITIZER_ADDRESS
#ifeq ($(MODE_SANITIZER_ADDRESS), ENABLE)
#$(error MODE_SANITIZER_ADDRESS cannot be used with 32_BIT architecture!)
#endif
#endif

ifdef MODE_SANITIZER_THREAD
ifeq ($(MODE_SANITIZER_THREAD), ENABLE)
$(error MODE_SANITIZER_THREAD cannot be used with 32_BIT architecture!)
endif
endif

ifdef MODE_SANITIZER_LEAK
ifeq ($(MODE_SANITIZER_LEAK), ENABLE)
$(error MODE_SANITIZER_LEAK cannot be used with 32_BIT architecture!)
endif
endif

ifdef MODE_SANITIZER_MEMORY
ifeq ($(MODE_SANITIZER_MEMORY), ENABLE)
$(error MODE_SANITIZER_MEMORY cannot be used with 32_BIT architecture!)
endif
endif

# TODO: data flow sanitizer - only with 64 bit
# TODO: coverage sanitizer - no information

endif

# INFO: Sanity check to find out incompatible address sanitizer combinations.
ifdef MODE_SANITIZER_ADDRESS
ifeq ($(MODE_SANITIZER_ADDRESS), ENABLE)
ifdef MODE_SANITIZER_THREAD
ifeq ($(MODE_SANITIZER_THREAD), ENABLE)
$(error MODE_SANITIZER_ADDRESS and MODE_SANITIZER_THREAD cannot be used at once!)
endif
endif

ifdef MODE_SANITIZER_MEMORY
ifeq ($(MODE_SANITIZER_MEMORY), ENABLE)
$(error MODE_SANITIZER_ADDRESS and MODE_SANITIZER_MEMORY cannot be used at once!)
endif
endif
endif
endif

# INFO: Sanity check to find out incompatible thread sanitizer combinations.
ifdef MODE_SANITIZER_THREAD
ifeq ($(MODE_SANITIZER_THREAD), ENABLE)
ifdef MODE_SANITIZER_LEAK
ifeq ($(MODE_SANITIZER_LEAK), ENABLE)
$(error MODE_SANITIZER_THREAD and MODE_SANITIZER_LEAK cannot be used at once!)
endif
endif

ifdef MODE_SANITIZER_MEMORY
ifeq ($(MODE_SANITIZER_MEMORY), ENABLE)
$(error MODE_SANITIZER_THREAD and MODE_SANITIZER_MEMORY cannot be used at once!)
endif
endif
endif
endif

# INFO: Sanity check to find out incompatible leak sanitizer combinations.
ifdef MODE_SANITIZER_LEAK
ifeq ($(MODE_SANITIZER_LEAK), ENABLE)
ifdef MODE_SANITIZER_MEMORY
ifeq ($(MODE_SANITIZER_MEMORY), ENABLE)
$(error MODE_SANITIZER_LEAK and MODE_SANITIZER_MEMORY cannot be used at once!)
endif
endif
endif
endif

endif

