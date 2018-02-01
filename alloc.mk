ifndef MK_ALLOC_MK
MK_ALLOC_MK=			TRUE


INCLUDER_MODULES_LIST=		name

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

ALLOC_TYPE_NONE=		none
ALLOC_TYPE_STD=			std
ALLOC_TYPE_MEMPOOL=		mempool

ALLOC_TYPE_DEFAULT=		$(ALLOC_TYPE_NONE)

ifneq ($(wildcard $(CONFIG_ALLOC_FILE_NAME)), )
ALLOC_TYPE_COMMAND=		grep \
					-v \
					^\# \
					$(CONFIG_ALLOC_FILE_NAME)

ALLOC_TYPE=			$(shell \
					$(ALLOC_TYPE_COMMAND))
else
ALLOC_TYPE=			$(ALLOC_TYPE_DEFAULT)
endif

ALLOC_ERROR_MESSAGE=		In \
				application \
				$(NAME) \
				unknown \
				allocator \
				value \
				($(ALLOC_TYPE)) \
				was \
				defined \
				in \
				file \
				$(CONFIG_ALLOC_FILE_NAME)

ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_NONE))
# INFO: Correct
else ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_STD))
# INFO: Correct
else ifeq ($(ALLOC_TYPE), $(ALLOC_TYPE_MEMPOOL))
# INFO: Correct
else
$(error $(ALLOC_ERROR_MESSAGE))
endif

endif
