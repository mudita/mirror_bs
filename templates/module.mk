INCLUDER_MODULES_LIST=		clean \
				clean_full \
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
				doc \
				templates \
				ctags \
				unit_test

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

$(CONFIG_ALL_RULE): \
		$(TEMPLATE_MOD_COMPONENT_LIST)

$(CONFIG_UNIT_TEST_GEN_RULE): \
		$(UNIT_TEST_C_ENTRY_FILE)

# TODO: Make sure, that each header modification causes re-copy - works after
#       make clean_tmp.
$(INSTALL_MODULE_LIB_FILE): \
		$(OBJECTS_ASM_LIST) \
		$(OBJECTS_C_LIST) \
		$(OBJECTS_CPP_LIST) \
		$(DIRS_LIB_DIR)/$(PLATFORM)
	$(PLATFORM_ARCHIVER) \
		-rcs \
		$@ \
		$(OBJECTS_LIST)

$(CONFIG_CLEAN_FULL_RULE): \
		$(CONFIG_CLEAN_RULE)

$(CONFIG_CLEAN_RULE): \
		$(CLEAN_PREFIX)_$(DIRS_PNG_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_DOC_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_OBJECTS_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_LIB_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_DEP_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_CTAGS_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_AUX_DIR)

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

$(CLEAN_PREFIX)_$(DIRS_AUX_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

$(CONFIG_CLEAN_FULL_RULE): \
		$(CONFIG_CLEAN_RULE)

$(DEPS_ASM_LIST): \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT) | \
		$(DIRS_DEP_DIR)
	mkdir \
		-p \
		$(dir \
			$(DIRS_DEP_DIR)/$*)
	$(PLATFORM_C_COMPILER) \
		$(DEFINES) \
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
		$(DEFINES) \
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
		$(DEFINES) \
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

# TODO: Local development hacks.
$(UNIT_TEST_C_LIST): \
		$(DIRS_UNIT_TEST_DIR)/%_$(UNIT_TEST_C_EXT_SUFFIX): \
		$(DIRS_CTAGS_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT) | \
		$(DIRS_UNIT_TEST_DIR)
	mkdir \
		-p \
		$(dir \
			$(DIRS_UNIT_TEST_DIR)/$*)
	cd \
		$(DIRS_UNIT_TEST_DIR) && \
	../$(UNIT_TEST_TCUPPA_COMMAND) \
		$*_test \
		$(shell cat $< | grep function | cut -d ' ' -f 1 | sed 's/.*/&_test/g')

$(UNIT_TEST_C_ENTRY_FILE): \
		$(DIRS_UNIT_TEST_DIR)/%_$(UNIT_TEST_C_EXT_ENTRY_SUFFIX): \
		$(UNIT_TEST_C_LIST)
	cd \
		$(DIRS_UNIT_TEST_DIR) && \
	../$(UNIT_TEST_BCUPPA_COMMAND) \
		$*_$(UNIT_TEST_C_ENTRY_SUFFIX) \
		$(UNIT_TEST_C_LIST:$(DIRS_UNIT_TEST_DIR)/%_test.c=%)

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
		$(DEFINES) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_CPP_COMPILER_LIST) \
		-c \
		$< \
		-o \
		$@ \
		-aux-info \
		$(DIRS_AUX_DIR)/$*.$(CONFIG_AUX_EXT)

$(DOC_HTML_LIST): \
		$(DIRS_DOC_DIR)/%.$(CONFIG_HTML_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASCIIDOC_FILE_EXT) \
		$(DIRS_DOC_DIR)
	asciidoc \
		-o \
		$@ \
		$<

# TODO: Finish latex generation.
$(DOC_LATEX_LIST): \
		$(DIRS_DOC_DIR)/%.$(CONFIG_LATEX_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASCIIDOC_FILE_EXT) \
		$(DIRS_DOC_DIR)
	echo \
		$@

# TODO: Finish pdf generation.
$(DOC_PDF_LIST): \
		$(DIRS_DOC_DIR)/%.$(CONFIG_PDF_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASCIIDOC_FILE_EXT) \
		$(DIRS_DOC_DIR)
	echo \
		$@

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

$(DIRS_PNG_DIR):
	mkdir \
		-p \
		$@

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

$(DIRS_AUX_DIR): \
		%:
	mkdir \
		-p \
		$*

