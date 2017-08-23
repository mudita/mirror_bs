ifndef MK_COVERAGE_MK
MK_COVERAGE_MK=			TRUE

INCLUDER_MODULES_LIST=		config \
				dirs \
				signature \
				sources/c

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Implement analogue with install.
# TODO: Implement analogue with lib.
# TODO: Implement analogue with objects.
COVERAGE_PLATFORM_DIR=		$(DIRS_COVERAGE_DIR)/$(PLATFORM)

COVERAGE_C_LIST=		$(patsubst \
					$(DIRS_SOURCES_DIR)/%, \
					$(COVERAGE_PLATFORM_DIR)/%.$(CONFIG_GCOV_FILE_EXT), \
					$(SOURCES_C_LIST))


COVERAGE_H_LIST_COMMAND=	find \
					$(DIRS_SOURCES_DIR) \
					-type \
					f | \
					grep \
						"\.$(CONFIG_H_HEADER_FILE_EXT)$$" | \
					sort

ifneq ($(wildcard $(DIRS_SOURCES_DIR)), )
COVERAGE_H_LIST=		$(shell \
					$(COVERAGE_H_LIST_COMMAND))
else
COVERAGE_H_LIST=
endif


endif

