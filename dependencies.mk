ifndef MK_DEPENDENCIES_MK
MK_DEPENDENCIES_MK=		TRUE

INCLUDER_MODULES_LIST=		dirs \
				config \
				signature

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEPENDENCIES_FILE=		$(DIRS_BS_TEMP_DIR)/$(CONFIG_DEPENDENCIES_FILE_NAME)
DEPENDENCIES_APPLICATION_NAME=	smart_deps
DEPENDENCIES_APPLICATION_DIR=	$(DIRS_TOOLS_DIR)/$(DEPENDENCIES_APPLICATION_NAME)/$(DIRS_INSTALL_DIR)/$(PLATFORM_HOST_ARCHITECTURE)
DEPENDENCIES_APPLICATION_PATH=	$(DEPENDENCIES_APPLICATION_DIR)/$(DEPENDENCIES_APPLICATION_NAME)

#$(CONFIG_MODULE_PREFIX)_check-$(PLATFORM_HOST_ARCHITECTURE): \
#		$(CONFIG_MODULE_PREFIX)_stringification-$(PLATFORM_HOST_ARCHITECTURE)

#$(CONFIG_TOOL_PREFIX)_$(DEPENDENCIES_APPLICATION_NAME)-$(PLATFORM_HOST_ARCHITECTURE): \
#		$(CONFIG_MODULE_PREFIX)_check-$(PLATFORM_HOST_ARCHITECTURE)

#$(DEPENDENCIES_APPLICATION_PATH): \
#		$(CONFIG_TOOL_PREFIX)_$(DEPENDENCIES_APPLICATION_NAME)-$(PLATFORM_HOST_ARCHITECTURE)

#$(DEPENDENCIES_FILE): \
#		$(DEPENDENCIES_APPLICATION_PATH) | \
#		$(DIRS_BS_TEMP_DIR)
#	./$(DEPENDENCIES_APPLICATION_PATH) > \
#	$@

$(DEPENDENCIES_FILE): | \
		$(DIRS_BS_TEMP_DIR)
	./$(DEPENDENCIES_APPLICATION_PATH) > \
	$@

include $(DEPENDENCIES_FILE)

endif

