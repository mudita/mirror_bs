ifndef MK_DOC_MK
MK_DOC_MK=			TRUE

INCLUDER_MODULES_LIST=		config \
				doc/html \
				doc/latex \
				doc/pdf \
				doc/png

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DOC_PREFIX=				$(CONFIG_DOC_RULE)

DOC_APP_PREFIX=				$(DOC_PREFIX)_$(CONFIG_APPLICATION_PREFIX)
DOC_MOD_PREFIX=				$(DOC_PREFIX)_$(CONFIG_MODULE_PREFIX)

DOC_APP_STANDARD_LIST=			$(patsubst \
						$(CONFIG_APPLICATION_PREFIX)_%, \
						$(DOC_APP_PREFIX)_%, \
						$(APPLICATIONS_STANDARD_LIST))


DOC_APP_NONSTANDARD_LIST=		$(patsubst \
						$(CONFIG_APPLICATION_PREFIX)_%, \
						$(DOC_APP_PREFIX)_%, \
						$(APPLICATIONS_NONSTANDARD_LIST))

DOC_MOD_STANDARD_LIST=			$(patsubst \
						$(CONFIG_MODULE_PREFIX)_%, \
						$(DOC_MOD_PREFIX)_%, \
						$(MODULES_STANDARD_LIST))


DOC_MOD_NONSTANDARD_LIST=		$(patsubst \
						$(CONFIG_MODULE_PREFIX)_%, \
						$(DOC_MOD_PREFIX)_%, \
						$(MODULES_NONSTANDARD_LIST))

# TODO: Should be moved to config.
DOC_DEFAULT_ASCIIDOC_LIST=		README.$(CONFIG_ASCIIDOC_FILE_EXT) \
					TODO.$(CONFIG_ASCIIDOC_FILE_EXT)

DOC_DEFAULT_HTML_LIST=			$(patsubst \
						%.$(CONFIG_ASCIIDOC_FILE_EXT), \
						%.$(CONFIG_HTML_FILE_EXT), \
						$(DOC_DEFAULT_ASCIIDOC_LIST))

endif

