INCLUDER_MODULES_LIST=		clean \
				clean_full \
				dirs \
				objects \
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
				mode \
				exec \
				wd \
				doc/html \
				doc/latex \
				doc/pdf

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Try to connect dependencies
#include $(DEPS_ASM_LIST)
#include $(DEPS_C_LIST)
#include $(DEPS_CPP_LIST)

# TODO: This variable should be hidden in some build system script module.
TEMPLATE_APP_COMPONENT_LIST=	$(INSTALL_OTHER_FILE_LIST) \
				$(DOC_HTML_LIST) \
				$(DOC_LATEX_LIST) \
				$(DOC_PDF_LIST)

# TODO: This variable should be hidden in some build system script module.
# INFO: If C/C++ sources are not present/not present
ifneq ($(words $(OBJECTS_LIST)), 0)
TEMPLATE_APP_COMPONENT_LIST+=	$(INSTALL_APPLICATION_ELF_FILE)
endif

$(CONFIG_ALL_RULE): \
		$(TEMPLATE_APP_COMPONENT_LIST)

# TODO: If application fails, there is no end of execution information.
$(CONFIG_RUN_RULE):
	@echo \
		$(EXEC_LINE_LABEL)
	@echo \
		$(EXEC_BEGIN_LABEL)
	@echo \
		$(EXEC_LINE_LABEL)
ifdef ARGS
	@cd \
		$(WD_DIR) && \
	export \
		MALLOC_TRACE=$(CONFIG_MTRACE_FILE_NAME) && \
	$(EXEC_APPLICATION_PATH) \
		$(ARGS)
else
ifneq ($(wildcard $(CONFIG_ARGS_FILE_NAME)), )
	@cd \
		$(WD_DIR) && \
	export \
		MALLOC_TRACE=$(CONFIG_MTRACE_FILE_NAME) && \
	$(EXEC_APPLICATION_PATH) \
		$(shell \
			cat \
			$(CONFIG_ARGS_FILE_NAME))
else
	@cd \
		$(WD_DIR) && \
	export \
		MALLOC_TRACE=$(CONFIG_MTRACE_FILE_NAME) && \
	$(EXEC_APPLICATION_PATH)
endif
endif
	@$(MODE_MTRACE_COMMAND)
	@echo \
		$(EXEC_LINE_LABEL)
	@echo \
		$(EXEC_END_LABEL)
	@echo \
		$(EXEC_LINE_LABEL)

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

$(INSTALL_APPLICATION_ELF_FILE): \
		$(DIRS_INSTALL_DIR)/%: \
		$(OBJECTS_LIST) | \
		$(DIRS_INSTALL_DIR) \
		$(DIRS_MAP_DIR)
	$(PLATFORM_CPP_COMPILER) \
		$(DEFINES) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_CPP_COMPILER_LIST) \
		$^ \
		$(LIBS_LIST) \
		$(EXTERNALS_LIST) \
		-o \
		$@ \
		-Map \
		$(DIRS_MAP_DIR)/$*.$(CONFIG_MAP_EXT)
		$(FLAGS_LINKER)

$(CONFIG_CLEAN_FULL_RULE): \
		$(CONFIG_CLEAN_RULE)

$(CONFIG_CLEAN_RULE): \
		$(CLEAN_PREFIX)_$(DIRS_DOC_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_OBJECTS_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_INSTALL_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_DEP_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_MAP_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_AUX_DIR)

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

$(CONFIG_CLEAN_FULL_RULE): \
		$(CONFIG_CLEAN_RULE)

$(DEPS_ASM_LIST): \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT) | \
		$(DIRS_DEP_DIR)

# TODO: Remove mkdir -p $(dir $@) trick from this rule
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
		$(DIRS_OBJECTS_DIR)/$*.$(CONFIG_C_OBJECT_FILE_EXT) \
		-MF \
		$@ \
		-c \
		$<

# TODO: Remove mkdir -p $(dir $@) trick from this rule
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
		$(DIRS_OBJECTS_DIR)/$*.$(CONFIG_CPP_OBJECT_FILE_EXT) \
		-MF \
		$@ \
		-c \
		$<

# TODO: Remove mkdir -p $(dir $@) trick from this rule
$(OBJECTS_ASM_LIST): \
		$(DIRS_OBJECTS_DIR)/%.$(CONFIG_ASM_OBJECT_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASM_SOURCE_FILE_EXT) \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT) | \
		$(DIRS_OBJECTS_DIR) \
		$(DIRS_DEP_DIR) \
		$(DIRS_AUX_DIR)
	echo not implemented - check template of module.
	false
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

# TODO: Add headers to dependencies system.
# TODO: Remove mkdir -p $(dir $@) trick from this rule
$(OBJECTS_C_LIST): \
		$(DIRS_OBJECTS_DIR)/%.$(CONFIG_C_OBJECT_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT) \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT) | \
		$(DIRS_OBJECTS_DIR) \
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

# TODO: Remove mkdir -p $(dir $@) trick from this rule
$(OBJECTS_CPP_LIST): \
		$(DIRS_OBJECTS_DIR)/%.$(CONFIG_CPP_OBJECT_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_CPP_SOURCE_FILE_EXT) \
		$(DIRS_DEP_DIR)/%.$(CONFIG_DEP_EXT) | \
		$(DIRS_OBJECTS_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	$(PLATFORM_CPP_COMPILER) \
		$(DEFINES) \
		$(INCLUDES_LIST) \
		$(PLATFORM_FLAG_LIST) \
		$(FLAGS_CPP_COMPILER_LIST) \
		-c \
		$< \
		-o \
		$@

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
	false

# TODO: Finish pdf generation.
$(DOC_PDF_LIST): \
		$(DIRS_DOC_DIR)/%.$(CONFIG_PDF_FILE_EXT): \
		$(DIRS_SOURCES_DIR)/%.$(CONFIG_ASCIIDOC_FILE_EXT) \
		$(DIRS_DOC_DIR)
	echo \
		$@
	false

$(DIRS_DOC_DIR): \
		%:
	mkdir \
		-p \
		$*

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

$(DIRS_DEP_DIR): \
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

