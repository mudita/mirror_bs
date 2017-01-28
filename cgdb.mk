ifndef MK_CGDB_MK
MK_CGDB_MK=			TRUE

INCLUDER_MODULES_LIST=		applications \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

CGDB_PREFIX=			cgdb

CGDB_STANDARD_SUFFIX=		$(CGDB_PREFIX)_standard
CGDB_ATTACHED_SUFFIX=		$(CGDB_PREFIX)_attached

CGDB_LIST_STANDARD=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(CGDB_STANDARD_SUFFIX)_%, \
					$(APPLICATIONS_LIST))

CGDB_LIST_ATTACHED=		$(patsubst \
					$(CONFIG_APPLICATION_PREFIX)_%, \
					$(CGDB_ATTACHED_SUFFIX)_%, \
					$(APPLICATIONS_LIST))

endif

