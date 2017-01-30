ifndef MK_DIRS_MK
MK_DIRS_MK=			TRUE

INCLUDER_MODULES_LIST=		config

DIRS_APPLICATIONS_DIR=		$(CONFIG_APPLICATION_PREFIX)s
DIRS_MODULES_DIR=		$(CONFIG_MODULE_PREFIX)s
DIRS_TOOLS_DIR=			$(CONFIG_TOOL_PREFIX)s
DIRS_DOTS_DIR=			$(CONFIG_DOT_PREFIX)s
DIRS_PNGS_DIR=			$(CONFIG_PNG_PREFIX)s

DIRS_MK_DIR=			bs
DIRS_TEMP_DIR=			$(DIRS_MK_DIR)/tmp
DIRS_TEMPLATES_DIR=		$(DIRS_MK_DIR)/templates

DIRS_BIN_DIR=			bin
DIRS_SOURCES_DIR=		src
DIRS_INCLUDE_DIR=		include

DIRS_GDB_DIR=			gdb

DIRS_INSTALL_DIR=		install
DIRS_DOWNLOAD_DIR=		download
DIRS_OBJECTS_DIR=		obj
DIRS_DOC_DIR=			doc
DIRS_DEP_DIR=			$(CONFIG_DEP_EXT)s
DIRS_AUX_DIR=			$(CONFIG_AUX_EXT)
DIRS_LIB_DIR=			lib

endif

