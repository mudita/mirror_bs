ifndef MK_EMPTY_DIRS_MK
MK_EMPTY_DIRS_MK=			TRUE

INCLUDER_MODULES_LIST=			dirs

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

EMPTY_DIRS_SEARCH_DIRS_LIST=		$(DIRS_APPLICATIONS_DIR) \
					$(DIRS_MODULES_DIR) \
					$(DIRS_TOOLS_DIR) \
					$(DIRS_MK_DIR)

EMPTY_DIRS_FIND_LIST_COMMAND=		find \
						$(EMPTY_DIRS_SEARCH_DIRS_LIST) \
						-type \
						d \
						-empty

endif

