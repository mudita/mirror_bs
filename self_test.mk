ifndef MK_SELF_TEST_MK
MK_SELF_TEST_MK=			TRUE

INCLUDER_MODULES_LIST=			dirs \
					config \
					modules \
					applications

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

SELF_TEST_APPLICATIONS_SUFFIX=		$(CONFIG_APPLICATION_PREFIX)s
SELF_TEST_MODULES_SUFFIX=		$(CONFIG_MODULE_PREFIX)s

SELF_TEST_PREFIX=			$(CONFIG_SELF_TEST_FILE_NAME)
SELF_TEST_RULE=				$(CONFIG_SELF_TEST_FILE_NAME)
SELF_TEST_APPLICATIONS_RULE=		$(CONFIG_SELF_TEST_FILE_NAME)_$(SELF_TEST_APPLICATIONS_SUFFIX)
SELF_TEST_MODULES_RULE=			$(CONFIG_SELF_TEST_FILE_NAME)_$(SELF_TEST_MODULES_SUFFIX)

SELF_TEST_LOOP_FIRST_FORMATER=		' %s\n\t\t%s_%s\n\n'
SELF_TEST_LOOP_FORMATER=		'%s_%s: %s\n\t\t%s\n\t%s\n\t\t%s\n\t%s\n\t\t%s\n\n'
SELF_TEST_LOOP_THIRD_FORMATER=		'%s_%s:'
SELF_TEST_RULE_FORMATER=		'%s\n\t\t%s\n\n'
SELF_TEST_BASE_FORMATER=		'%s'
SELF_TEST_EOF_APPLICATIONS_FORMATER=	' \\\n\t\t%s\n\n'
SELF_TEST_EOF_MODULES_FORMATER=		'\n\n'

SELF_TEST_FILE_NAME=			$(CONFIG_SELF_TEST_FILE_NAME).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
SELF_TEST_APPLICATIONS_FILE_NAME=	$(SELF_TEST_APPLICATIONS_RULE).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
SELF_TEST_MODULES_FILE_NAME=		$(SELF_TEST_MODULES_RULE).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)

SELF_TEST_FILE=				$(DIRS_TEMP_DIR)/$(SELF_TEST_FILE_NAME)
SELF_TEST_APPLICATIONS_FILE=		$(DIRS_TEMP_DIR)/$(SELF_TEST_APPLICATIONS_FILE_NAME)
SELF_TEST_MODULES_FILE=			$(DIRS_TEMP_DIR)/$(SELF_TEST_MODULES_FILE_NAME)

ifneq ($(wildcard $(SELF_TEST_FILE)), )
$(CONFIG_ALL_RULE): \
		$(SELF_TEST_FILE)
endif

$(SELF_TEST_FILE): \
		%: \
		$(SELF_TEST_APPLICATIONS_FILE)
	cp \
		/dev/null \
		$*
	printf \
		$(SELF_TEST_RULE_FORMATER) \
		'$$(SELF_TEST_RULE): \' \
		'$$(SELF_TEST_APPLICATIONS_RULE)' \
		>> \
		$*

$(SELF_TEST_APPLICATIONS_FILE): \
		%: \
		$(SELF_TEST_MODULES_FILE)
	cp \
		/dev/null \
		$*
	printf \
		$(SELF_TEST_BASE_FORMATER) \
		'$$(SELF_TEST_APPLICATIONS_RULE):' \
		>> \
		$*
	for \
		module \
		in \
		$(APPLICATIONS_LIST); \
		do \
			printf \
				$(SELF_TEST_LOOP_FIRST_FORMATER) \
				'\' \
				'$$(SELF_TEST_PREFIX)' \
				$$module \
				>> \
				$*; \
			printf \
				$(SELF_TEST_LOOP_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$module \
				'\' \
				'$$(SELF_TEST_PREFIX)_%:' \
				'make \' \
				'$(CONFIG_CLEAN_RULE)' \
				'make \' \
				'$$*' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_LOOP_THIRD_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$module \
				>> \
				$*; \
		done
	printf \
		$(SELF_TEST_EOF_APPLICATIONS_FORMATER) \
		'$$(SELF_TEST_MODULES_RULE)' \
		>> \
		$*

$(SELF_TEST_MODULES_FILE): \
		%: \
		$(DIRS_TEMP_DIR)
	cp \
		/dev/null \
		$*
	printf \
		$(SELF_TEST_BASE_FORMATER) \
		'$$(SELF_TEST_MODULES_RULE):' \
		>> \
		$*
	for \
		module \
		in \
		$(MODULES_LIST); \
		do \
			printf \
				$(SELF_TEST_LOOP_FIRST_FORMATER) \
				'\' \
				'$$(SELF_TEST_PREFIX)' \
				$$module \
				>> \
				$*; \
			printf \
				$(SELF_TEST_LOOP_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$module \
				'\' \
				'$$(SELF_TEST_PREFIX)_%:' \
				'make \' \
				'$(CONFIG_CLEAN_RULE)' \
				'make \' \
				'$$*' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_LOOP_THIRD_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$module \
				>> \
				$*; \
		done
	printf \
		$(SELF_TEST_EOF_MODULES_FORMATER) \
		>> \
		$*

#ifneq ($(wildcard $(SELF_TEST_FILE)), )
include $(SELF_TEST_FILE)
#endif

#ifneq ($(wildcard $(SELF_TEST_APPLICATIONS_FILE)), )
include $(SELF_TEST_APPLICATIONS_FILE)
#endif

#ifneq ($(wildcard $(SELF_TEST_MODULES_FILE)), )
include $(SELF_TEST_MODULES_FILE)
#endif

endif

