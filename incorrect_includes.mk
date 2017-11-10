ifndef MK_INCORRECT_INCLUDES_MK
MK_INCORRECT_INCLUDES_MK=		TRUE

INCLUDER_MODULES_LIST=			config \
					dirs

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

INCORRECT_INCLUDES_SEARCH_DIRS_LIST=	$(DIRS_APPLICATIONS_DIR) \
					$(DIRS_MODULES_DIR) \
					$(DIRS_TOOLS_DIR)

INCORRECT_INCLUDES_GREP_PATTERN=	\\.\\.

INCORRECT_INCLUDES_FIND_LIST_COMMAND=	find \
						$(EMPTY_DIRS_SEARCH_DIRS_LIST) \
						-type \
						f \
						-name \
						$(CONFIG_INCLUDES_FILE_NAME) | \
					xargs \
						grep \
						-rn \
						$(INCORRECT_INCLUDES_GREP_PATTERN) | \
					cut \
						-d \
						: \
						-f \
						1
						

endif

