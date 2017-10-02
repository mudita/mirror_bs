INCLUDER_MODULES_LIST=		clean \
				clean_full \
				clean_deep \
				dirs \
				objects \
				sources \
				flags_compiler \
				includes \
				defines \
				install \
				config \
				platform \
				deps \
				libs \
				flags_linker \
				externals \
				exec \
				wd \
				doc \
				templates \
				ctags \
				unit_test_sources \
				unit_test_objects \
				debug \
				format \
				signature \
				doxygen

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

$(CONFIG_ALL_RULE): \
		$(TEMPLATE_MOD_COMPONENT_LIST)

$(CONFIG_UNIT_TEST_GEN_RULE): \
		$(UNIT_TEST_SOURCES_C_ENTRY_FILE) \
		$(UNIT_TEST_SOURCES_C_LIST)

$(CONFIG_UNIT_TEST_BUILD_RULE): \
		$(CONFIG_UNIT_TEST_GEN_RULE) \
		$(TEMPLATE_APP_COMPONENT_TEST_LIST)

$(CONFIG_UNIT_TEST_RUN_RULE): \
		$(CONFIG_UNIT_TEST_BUILD_RULE)
ifneq ($(words $(TEMPLATE_MOD_COMPONENT_TEST_LIST)), 0)
	@echo \
		$(EXEC_LINE_LABEL)
	@echo \
		$(EXEC_BEGIN_LABEL)
	@echo \
		$(EXEC_LINE_LABEL)
	@cd \
		$(WD_DIR) && \
	$(PATH_EXPORT_COMMAND) && \
	export \
		MALLOC_TRACE=$(CONFIG_MTRACE_FILE_NAME) && \
		$(EXEC_TEST_MODULE_PATH)
	@$(MODE_MTRACE_COMMAND)
	@echo \
		$(EXEC_LINE_LABEL)
	@echo \
		$(EXEC_END_LABEL)
	@echo \
		$(EXEC_LINE_LABEL)
endif

$(CONFIG_FORMAT_RULE): \
		$(FORMAT_SOURCES_C_LIST)

$(CONFIG_DOC_RULE): \
		$(DOC_DEFAULT_HTML_LIST)

# TODO: If source and source.format is the same, source.format should be
#       removed.
# TODO: Add nex rule to merge automaticly formated sources with original
#       sources.
# TODO: Almost for sure add unit_test sources, but should be also generated
#       acording to the convention.
$(FORMAT_SOURCES_C_LIST): \
		$(DIRS_SOURCES_DIR)/%.$(FORMAT_SOURCE_C_EXT_SUFFIX): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT)
	$(FORMAT_COMMAND) \
		$(FORMAT_FLAGS) \
		$< > \
		$@

$(INSTALL_MODULE_LIB_FILE): \
		$(OBJECTS_ASM_LIST) \
		$(OBJECTS_C_LIST) \
		$(OBJECTS_CPP_LIST) \
		$(DIRS_LIB_DIR)/$(PLATFORM)
	$(PLATFORM_ARCHIVER) \
		-rcs \
		$@ \
		$(OBJECTS_LIST)

#		-Map \
#		$(DIRS_MAP_DIR)/$*.$(CONFIG_MAP_EXT) \

$(INSTALL_APPLICATION_TEST_ELF_FILE): \
		$(INSTALL_PLATFORM_DIR)/%_$(SIGNATURE_APPLICATION_TEST_SUFFIX): \
		$(UNIT_TEST_OBJECTS_C_ENTRY_FILE) \
		$(UNIT_TEST_OBJECTS_C_LIST) \
		$(OBJECTS_FOR_TEST_LIST) | \
		$(INSTALL_PLATFORM_DIR)
	echo \
		"Not implemented yet."
	false
#	$(PLATFORM_CPP_COMPILER) \
#		$(DEFINES_LIST) \
#		$(INCLUDES_LIST) \
#		-nostartfiles \
#		$(PLATFORM_FLAG_LIST) \
#		$(FLAGS_CPP_COMPILER_LIST) \
#		$^ \
#		$(LIBS_LIST) \
#		$(EXTERNALS_LIST) \
#		-o \
#		$@ \
#		$(FLAGS_LINKER)

#		-Map \
#		$(DIRS_MAP_DIR)/$*.$(CONFIG_MAP_EXT) \

$(CONFIG_CLEAN_FULL_RULE): \
		$(CONFIG_CLEAN_RULE)

$(CONFIG_CLEAN_DEEP_RULE): \
		$(CONFIG_CLEAN_RULE)

$(CONFIG_CLEAN_RULE): \
		$(CLEAN_PREFIX)_$(DIRS_PNG_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_DOC_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_OBJECTS_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_LIB_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_INSTALL_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_DEP_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_CTAGS_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_MAP_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_AUX_DIR) \
		$(CLEAN_FORMAT_SOURCES_LIST) \
		$(CLEAN_DOC_DEFAULT_HTML_LIST)

$(CLEAN_PREFIX)_$(DIRS_PNG_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_DOC_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_OBJECTS_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_LIB_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_INSTALL_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_DEP_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_CTAGS_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_MAP_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_PREFIX)_$(DIRS_AUX_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_FORMAT_SOURCES_LIST): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CLEAN_DOC_DEFAULT_HTML_LIST): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(DEPS_ASM_LIST): \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT) | \
		$(DIRS_DEP_DIR)
	mkdir \
		-p \
		$(dir \
			$(DIRS_DEP_DIR)/$*)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		$(DEPS_FLAG_LIST) \
		-MT \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/$*.$(CONFIG_ASM_OBJECT_FILE_EXT) \
		-MF \
		$@ \
		-c \
		$<

$(DEPS_C_LIST): \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT) | \
		$(DIRS_DEP_DIR)
	mkdir \
		-p \
		$(dir \
			$(DIRS_DEP_DIR)/$*)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		$(DEPS_FLAG_LIST) \
		-MT \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/$*.$(CONFIG_C_OBJECT_FILE_EXT) \
		-MF \
		$@ \
		-c \
		$<

$(DEPS_CPP_LIST): \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_CPP_SOURCE_FILE_EXT) | \
		$(DIRS_DEP_DIR)
	mkdir \
		-p \
		$(dir \
			$(DIRS_DEP_DIR)/$*)
	$(PLATFORM_CPP_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_CPP_COMPILER_LIST) \
		$(DEPS_FLAG_LIST) \
		-MT \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/$*.$(CONFIG_CPP_OBJECT_FILE_EXT) \
		-MF \
		$@ \
		-c \
		$<

$(UNIT_TEST_SOURCES_C_LIST): \
		$(DIRS_UNIT_TEST_DIR)/%_$(UNIT_TEST_SOURCES_C_EXT_SUFFIX): \
		$(DIRS_CTAGS_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT) | \
		$(DIRS_UNIT_TEST_DIR)
	mkdir \
		-p \
		$(dir \
			$(DIRS_UNIT_TEST_DIR)/$*)
	cd \
		$(DIRS_UNIT_TEST_DIR) && \
	../$(UNIT_TEST_SOURCES_TCUPPA_COMMAND) \
		$*_$(UNIT_TEST_SOURCES_C_SUFFIX) \
		$(UNIT_TEST_SOURCES_C_ENTRY_LIST)

$(UNIT_TEST_SOURCES_C_ENTRY_FILE): \
		$(DIRS_UNIT_TEST_DIR)/%_$(UNIT_TEST_SOURCES_C_EXT_ENTRY_SUFFIX): \
		$(UNIT_TEST_SOURCES_C_LIST)
	cd \
		$(DIRS_UNIT_TEST_DIR) && \
	../$(UNIT_TEST_SOURCES_BCUPPA_COMMAND) \
		$*_$(UNIT_TEST_SOURCES_C_ENTRY_SUFFIX) \
		$(UNIT_TEST_SOURCES_C_TEST_FILE_LIST)

# TODO: Deps for unit_test objects.
$(UNIT_TEST_OBJECTS_C_ENTRY_FILE): \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_$(UNIT_TEST_OBJECTS_C_EXT_ENTRY_SUFFIX): \
		$(DIRS_UNIT_TEST_DIR)/%_$(UNIT_TEST_SOURCES_C_EXT_ENTRY_SUFFIX) \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM) \
		$(DIRS_AUX_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	mkdir \
		-p \
		$(dir \
			$(DIRS_AUX_DIR)/$*)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		-c \
		$< \
		-o \
		$@ \
		-aux-info \
		$(DIRS_AUX_DIR)/$*.$(CONFIG_AUX_EXT)

# TODO: Deps for unit_test objects.
$(UNIT_TEST_OBJECTS_C_LIST): \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_$(UNIT_TEST_OBJECTS_C_EXT_SUFFIX): \
		$(DIRS_UNIT_TEST_DIR)/%_$(UNIT_TEST_SOURCES_C_EXT_SUFFIX) \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM) \
		$(DIRS_AUX_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	mkdir \
		-p \
		$(dir \
			$(DIRS_AUX_DIR)/$*)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		-c \
		$< \
		-o \
		$@ \
		-aux-info \
		$(DIRS_AUX_DIR)/$*.$(CONFIG_AUX_EXT)

$(CTAGS_C_LIST): \
		$(DIRS_CTAGS_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT) | \
		$(DIRS_CTAGS_DIR)
	mkdir \
		-p \
		$(dir \
			$(DIRS_CTAGS_DIR)/$*)
	ctags \
		-x \
		-u \
		$< > \
		$@

$(OBJECTS_ASM_LIST): \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_$(SIGNATURE_ASM_OBJECT_SUFFIX): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT) \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT) | \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM) \
		$(DIRS_DEP_DIR) \
		$(DIRS_AUX_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	mkdir \
		-p \
		$(dir \
			$(DIRS_AUX_DIR)/$*)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		-c \
		$< \
		-o \
		$@ \
		-aux-info \
		$(DIRS_AUX_DIR)/$*.$(CONFIG_AUX_EXT)

$(OBJECTS_C_LIST): \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_$(SIGNATURE_C_OBJECT_SUFFIX): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT) \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT) | \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM) \
		$(DIRS_AUX_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	mkdir \
		-p \
		$(dir \
			$(DIRS_AUX_DIR)/$*)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		-c \
		$< \
		-o \
		$@ \
		-aux-info \
		$(DIRS_AUX_DIR)/$*.$(CONFIG_AUX_EXT)

$(OBJECTS_CPP_LIST): \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_$(SIGNATURE_CPP_OBJECT_SUFFIX): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_CPP_SOURCE_FILE_EXT) \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT) | \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM) \
		$(DIRS_AUX_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	mkdir \
		-p \
		$(dir \
			$(DIRS_AUX_DIR)/$*)
	$(PLATFORM_CPP_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_CPP_COMPILER_LIST) \
		-c \
		$< \
		-o \
		$@ \
		-aux-info \
		$(DIRS_AUX_DIR)/$*.$(CONFIG_AUX_EXT)

$(OBJECTS_ASM_FOR_TEST_LIST): \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_for_test_$(SIGNATURE_ASM_OBJECT_SUFFIX): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT) \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT) | \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM) \
		$(DIRS_DEP_DIR) \
		$(DIRS_AUX_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	mkdir \
		-p \
		$(dir \
			$(DIRS_AUX_DIR)/$*)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		-nostdinc \
		-isystem \
		/usr/lib/gcc/arm-none-eabi/$(shell $(PLATFORM_C_COMPILER) -dumpversion)/include \
		-c \
		$< \
		-o \
		$@ \
		-aux-info \
		$(DIRS_AUX_DIR)/$*.$(CONFIG_AUX_EXT)

$(OBJECTS_C_FOR_TEST_LIST): \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_for_test_$(SIGNATURE_C_OBJECT_SUFFIX): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT) \
		$(DIRS_OBJECTS_DIR)/$(PLATFORM)
	echo \
		OBJECTS_C_FOR_TEST_LIST: \
		$(OBJECTS_C_FOR_TEST_LIST)
	mkdir \
		-p \
		$(dir \
			$@)
	mkdir \
		-p \
		$(dir \
			$(DIRS_AUX_DIR)/$*)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES_LIST) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_C_COMPILER_LIST) \
		-c \
		$< \
		-o \
		$@ \
		-aux-info \
		$(DIRS_AUX_DIR)/$*.$(CONFIG_AUX_EXT)

$(DOC_DEFAULT_HTML_LIST): \
		%.$(CONFIG_HTML_FILE_EXT): \
		%.$(CONFIG_ASCIIDOC_FILE_EXT)
	asciidoctor \
		-o \
		$@ \
		$<

$(DOC_PNG_LIST): \
		$(DIRS_PNG_DIR)/%.$(CONFIG_PNG_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_DOT_FILE_EXT) \
		$(DIRS_PNG_DIR)
	cat \
		$< | \
	dot \
		-T \
		$(CONFIG_PNG_PREFIX) \
		-o \
		$(DIRS_PNG_DIR)/$*.$(CONFIG_PNG_FILE_EXT)

$(DIRS_PNG_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_OBJECTS_DIR)/$(PLATFORM): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_LIB_DIR)/$(PLATFORM): \
		%:
	mkdir \
		-p \
		$*

$(INSTALL_PLATFORM_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_DOC_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_DEP_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_UNIT_TEST_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_CTAGS_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_MAP_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_AUX_DIR): \
		%:
	mkdir \
		-p \
		$*
# run doxygen command

$(CONFIG_DOXYGEN_RULE): \

# copy template doxygen.cfg to app/module source directory
# and substitute default configuration with proper app/mod values

ifeq ("$(wildcard $(DOXYGEN_CONFIGURATION_FILE_NAME))","")
	cp \
		$(DOXYGEN_CONFIGURATION_FILE) ./

	sed \
		-i \
		's/doxy_project/$(NAME)/g' \
		$(DOXYGEN_CONFIGURATION_FILE_NAME)

	sed \
	-i \
		's/doxy_dir/$(DOXYGEN_DOC_DIR)/g' \
		$(DOXYGEN_CONFIGURATION_FILE_NAME)

endif

	$(DOXYGEN_COMMAND) \
		$(DOXYGEN_CONFIGURATION_FILE_NAME)
