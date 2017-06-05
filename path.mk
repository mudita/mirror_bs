ifndef MK_PATH_MK
MK_PATH_MK=			TRUE

INCLUDER_MODULES_LIST=		relative \
				dirs \
				root \
				install

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: If added, this should be checked if tool or app exists.

PATH_ALL_BARE_LIST=		xterm_rw \
				fb_viewer

PATH_APPLICATIONS_PREFIX=	$(ROOT_DIR)/$(DIRS_APPLICATIONS_DIR)
PATH_APPLICATIONS_SUFFIX=	$(INSTALL_PLATFORM_DIR)

# INFO: Has to be without breakline!
PATH_ALL_SPACE_LIST=		$(patsubst \
					%,$(PATH_APPLICATIONS_PREFIX)/%/$(PATH_APPLICATIONS_SUFFIX), \
					$(PATH_ALL_BARE_LIST))

PATH_COLON_CHAR=		:
PATH_EMPTY=
PATH_SPACE=			$(PATH_EMPTY) $(PATH_EMPTY)

# INFO: Has to be without breakline!
PATH_ALL_COLON_LIST=		$(subst \
					$(PATH_SPACE),$(PATH_COLON_CHAR), \
					$(PATH_ALL_SPACE_LIST))

PATH_EXPORT_COMMAND=		export \
					PATH=$(PATH)$(PATH_ALL_COLON_LIST)

endif

