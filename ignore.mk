ifndef MK_IGNORE_MK
MK_IGNORE_MK=				TRUE

INCLUDER_MODULES_LIST=			config \
					platform

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

IGNORE_TOOLS_LIST=			$(CONFIG_TOOL_PREFIX)_smart_deps-$(PLATFORM_HOST_ARCHITECTURE)

endif

