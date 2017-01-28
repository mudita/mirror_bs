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
				deps

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Try to connect dependencies
#include $(DEPS_ASM_LIST)
#include $(DEPS_C_LIST)
#include $(DEPS_CPP_LIST)

$(CONFIG_ALL_RULE): \
		$(INSTALL_MODULE_LIB_FILE)

$(CONFIG_CLEAN_FULL_RULE): \
		$(CONFIG_CLEAN_RULE)

$(CONFIG_CLEAN_RULE): \
		$(CLEAN_PREFIX)_$(DIRS_OBJECTS_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_LIB_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_DEP_DIR) \
		$(CLEAN_PREFIX)_$(DIRS_AUX_DIR)

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

$(CLEAN_PREFIX)_$(DIRS_AUX_DIR): \
		$(CLEAN_PREFIX)_%:
	rm \
		-rf \
		$*

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
		$(DIRS_DEP_DIR)
	mkdir \
		-p \
		$(dir \
			$@)
	$(PLATFORM_ASSEMBLER) \
		$(PLATFORM_FLAG_LIST) \
		$< \
		-o \
		$@

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

# TODO: Make sure, that each header modification causes re-copy - works after
#       make clean_tmp.
$(INSTALL_MODULE_LIB_FILE): \
		$(OBJECTS_ASM_LIST) \
		$(OBJECTS_C_LIST) \
		$(OBJECTS_CPP_LIST) \
		$(DIRS_LIB_DIR)
	$(PLATFORM_ARCHIVER) \
		-rcs \
		$@ \
		$(OBJECTS_LIST)

$(DIRS_OBJECTS_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_LIB_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_DEP_DIR): \
		%:
	mkdir \
		-p \
		$*

$(DIRS_AUX_DIR): \
		%:
	mkdir \
		-p \
		$*

