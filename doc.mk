ifndef MK_DOC_MK
MK_DOC_MK=			TRUE

INCLUDER_MODULES_LIST=		config \
				doc/html \
				doc/latex \
				doc/pdf

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DOC_DEFAULT_ASCIIDOC_LIST=	README.$(CONFIG_ASCIIDOC_FILE_EXT) \
				TODO.$(CONFIG_ASCIIDOC_FILE_EXT)

DOC_DEFAULT_HTML_LIST=		$(patsubst \
					%.$(CONFIG_ASCIIDOC_FILE_EXT), \
					%.$(CONFIG_HTML_FILE_EXT), \
					$(DOC_DEFAULT_ASCIIDOC_LIST))

endif

