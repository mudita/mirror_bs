ifndef MK_FLAGS_COMPILER_MK
MK_FLAGS_COMPILER_MK=		TRUE

INCLUDER_MODULES_LIST=		flags_compiler/warnings \
				flags_compiler/gdb \
				flags_compiler/sanitize \
				flags_compiler/dialect \
				flags_compiler/coverage \
				flags_compiler/optimization

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Flags should be parsed and checked it there is no conflicting options.
# TODO: There should be sanity checking for flags options. Also, there should
#       be the database to check if flag is compatible with both gcc and clang.
# TODO: Compile with both clang and gcc compilers. Developed code will be fully
#       portable this way.
# TODO: Sanitizer currently does not cooperate with memory allocator module.
FLAGS_C_COMPILER_TEMP_LIST=

# INFO: Check if warnings options were specified.
ifndef FLAGS_COMPILER_WARNINGS
$(warning FLAGS_COMPILER_WARNINGS was not specified!)
#else
# TODO: Not sure if it is working.
FLAGS_C_COMPILER_TEMP_LIST+=	-Wunreachable-code
FLAGS_CPP_COMPILER_TEMP_LIST+=	-Wunreachable-code
FLAGS_C_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_WARNINGS)
FLAGS_CPP_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_WARNINGS)
endif

# INFO: Check if debug options were specified.
ifndef FLAGS_COMPILER_GDB
$(warning FLAGS_COMPILER_GDB was not specified!)
else
FLAGS_C_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_GDB)
FLAGS_CPP_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_GDB)
endif

# INFO: Check if sanitize options were specified.
# TODO: Variable CC is not used any more
#ifeq ($(CC), clang)
ifndef FLAGS_COMPILER_SANITIZE
$(warning FLAGS_COMPILER_SANITIZE was not specified!)
else
FLAGS_C_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_SANITIZE)
FLAGS_CPP_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_SANITIZE)
endif
#endif

# INFO: Check if dialect options were specified.
ifndef FLAGS_C_COMPILER_DIALECT
$(warning FLAGS_C_COMPILER_DIALECT was not specified!)
else
FLAGS_C_COMPILER_TEMP_LIST+=	$(FLAGS_C_COMPILER_DIALECT)
endif

# INFO: Check if dialect options were specified.
ifndef FLAGS_CPP_COMPILER_DIALECT
$(warning FLAGS_CPP_COMPILER_DIALECT was not specified!)
else
FLAGS_CPP_COMPILER_TEMP_LIST+=	$(FLAGS_CPP_COMPILER_DIALECT)
endif

# INFO: Check if coverage options were specified.
ifndef FLAGS_COMPILER_COVERAGE
$(warning FLAGS_COMPILER_COVERAGE was not specified!)
#else
#FLAGS_C_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_COVERAGE)
#FLAGS_CPP_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_COVERAGE)
endif

# INFO: Check if optimization options were specified.
ifndef FLAGS_COMPILER_OPTIMIZATION
$(warning FLAGS_COMPILER_OPTIMIZATION was not specified!)
else
FLAGS_C_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_OPTIMIZATION)
FLAGS_CPP_COMPILER_TEMP_LIST+=	$(FLAGS_COMPILER_OPTIMIZATION)
endif

# TODO: Not sure if needed.
ifeq ($(MODE_OUTPUT_ARCHITECTURE), 32_BIT)
FLAGS_32_BIT_VERSION_FLAG=	-m32
FLAGS_C_COMPILER_TEMP_LIST+=	$(FLAGS_32_BIT_VERSION_FLAG)
FLAGS_CPP_COMPILER_TEMP_LIST+=	$(FLAGS_32_BIT_VERSION_FLAG)
else
# TODO: Check if variable is needed.
FLAGS_32_BIT_VERSION_FLAG=
endif

# INFO: Add flags from unit local file.
FLAGS_IN_LIST_EXISTENCE=	$(wildcard \
					$(CONFIG_IN_FLAGS_FILE_NAME))

ifneq ($(FLAGS_IN_LIST_EXISTENCE), )
FLAGS_IN_LIST_COMMAND=		cat \
					$(CONFIG_IN_FLAGS_FILE_NAME)

FLAGS_IN_LIST=			$(shell \
					$(FLAGS_IN_LIST_COMMAND))
else
FLAGS_IN_LIST=
endif

# INFO: Add to flag list.
FLAGS_C_COMPILER_TEMP_LIST+=	$(FLAGS_IN_LIST)
FLAGS_CPP_COMPILER_TEMP_LIST+=	$(FLAGS_IN_LIST)

# INFO: Filter-out not wanted.
FLAGS_DEPENDENCIES_EXISTENCE=	$(wildcard \
					$(CONFIG_OUT_FLAGS_FILE_NAME))

ifneq ($(FLAGS_DEPENDENCIES_EXISTENCE), )
FLAGS_DEPENDENCIES_COMMAND=	cat \
					$(CONFIG_OUT_FLAGS_FILE_NAME)

FLAGS_FILTER_OUT_LIST=		$(shell \
					$(FLAGS_DEPENDENCIES_COMMAND))
else
FLAGS_FILTER_OUT_LIST=
endif

FLAGS_C_COMPILER_LIST=		$(filter-out \
					$(FLAGS_FILTER_OUT_LIST), \
					$(FLAGS_C_COMPILER_TEMP_LIST))

FLAGS_CPP_COMPILER_LIST=	$(filter-out \
					$(FLAGS_FILTER_OUT_LIST), \
					$(FLAGS_CPP_COMPILER_TEMP_LIST))	

endif

