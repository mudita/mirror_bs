ifndef MK_CGDB_MK
MK_CGDB_MK=			TRUE

INCLUDER_MODULES_LIST=		applications \
				config \
				platform \
				dirs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

CGDB_PREFIX=			$(CONFIG_CGDB_RULE)

# INFO: Host related.
CGDB_STANDARD_SUFFIX=		$(CGDB_PREFIX)_standard
CGDB_ATTACHED_SUFFIX=		$(CGDB_PREFIX)_attached

CGDB_LIST_STANDARD=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(CGDB_STANDARD_SUFFIX)_%, \
					$(APPLICATIONS_PLATFORMS_LIST))

CGDB_LIST_ATTACHED=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(CGDB_ATTACHED_SUFFIX)_%, \
					$(APPLICATIONS_PLATFORMS_LIST))

# INFO: Qemu related.
CGDB_STANDARD_LIST=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(CGDB_PREFIX)_%, \
					$(APPLICATIONS_PLATFORMS_STANDARD_LIST))
CGDB_NONSTANDARD_LIST=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(CGDB_PREFIX)_%, \
					$(APPLICATIONS_PLATFORMS_NONSTANDARD_LIST))

CGDB_GDB_COMMAND=		target\ \
				remote\ \
				$(CONFIG_GDB_HOST):$(CONFIG_GDB_PORT)

CGDB_FLAGS=			-d \
				$(PLATFORM_GDB) \
				-x \
				$(DIRS_GDB_DIR)/$(PLATFORM).$(CONFIG_GDB_SCRIPT_EXT) \
				-ex \
				$(CGDB_GDB_COMMAND) \

CGDB_FLAGS_HARD=         -d \
                $(PLATFORM_GDB) \
                -x \
                $(DIRS_GDB_DIR)/$(PLATFORM)_hard.$(CONFIG_GDB_SCRIPT_EXT) \
#                -ex \
#                $(CGDB_GDB_COMMAND) \

CGDB_FLAGS_HARD_AUTO=         -d \
                $(PLATFORM_GDB) \
                -x \
                $(DIRS_GDB_DIR)/$(PLATFORM)_hard_auto.$(CONFIG_GDB_SCRIPT_EXT) \
#                -ex \
#                $(CGDB_GDB_COMMAND) \

endif
