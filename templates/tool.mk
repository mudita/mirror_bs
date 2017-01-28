INCLUDER_MODULES_LIST=		clean \
				clean_full \
				objects \
				name \
				flags_compiler \
				flags_linker \
				install \
				defines \
				config \
				includes \
				dirs \
				libs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

$(CONFIG_ALL_RULE): \
		$(INSTALL_TOOL_ELF_FILE) \
		$(INSTALL_OTHER_FILE_LIST)

$(INSTALL_OTHER_FILE_LIST): \
		$(DIRS_INSTALL_DIR)/%: \
		% \
		$(DIRS_INSTALL_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	cp \
		$* \
		$@

$(INSTALL_TOOL_ELF_FILE): \
		$(OBJECTS_C_LIST) | \
		$(DIRS_INSTALL_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		$^ \
		$(LIBS_LIST) \
		-o \
		$@ \
		$(FLAGS_LINKER)

$(CONFIG_CLEAN_FULL_RULE): \
		$(CONFIG_CLEAN_RULE)

$(CONFIG_CLEAN_RULE): \
		$(CLEAN_PREFIX)_$(DIRS_OBJECTS_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_INSTALL_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_AUX_DIR)

$(CLEAN_PREFIX)_$(DIRS_OBJECTS_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_INSTALL_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_AUX_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(OBJECTS_C_LIST): \
		$(DIRS_OBJECTS_DIR)/%.$(CONFIG_C_OBJECT_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT) | \
		$(DIRS_OBJECTS_DIR) \
		$(DIRS_AUX_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		-c \
		$< \
		-o \
		$@ \
		-aux-info \
		$(DIRS_AUX_DIR)/$*.$(CONFIG_AUX_EXT)

$(DIRS_OBJECTS_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_INSTALL_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_AUX_DIR): \
		%:
	mkdir \
		-p \
		$*

