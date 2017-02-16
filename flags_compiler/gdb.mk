ifndef MK_FLAGS_COMPILER_GDB_MK
MK_FLAGS_COMPILER_GDB_MK=		TRUE

# TODO: Flags should be parsed and checked it there is no conflicting options.
# TODO: Only some of flags are described here.
# INFO: Official documentation:
#       https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
#
# INFO: -glevel
#       -ggdblevel
#       
#       Request debugging information and also use level to specify how much
#       information. The default level is 2.
#       * Level 0 - produces no debug information at all. Thus, -g0 negates -g.
#       * Level 1 - produces minimal information, enough for making backtraces
#                   in parts of the program that you don't plan to debug. This
#                   includes descriptions of functions and external variables,
#                   and line number tables, but no information about local
#                   variables.
#       * Level 3 - includes extra information, such as all the macro
#                   definitions present in the program. Some debuggers support
#                   macro expansion when you use -g3.

FLAGS_COMPILER_GDB_DEBUG_LEVEL=	3

# INFO: -g
#
#       Produce debugging information in the operating system's native format
#       (stabs, COFF, XCOFF, or DWARF 2). GDB can work with this debugging
#       information.
#
#       On most systems that use stabs format, -g enables use of
#       extra debugging information that only GDB can use; this extra
#       information makes debugging work better in GDB but probably makes other
#       debuggers crash or refuse to read the program. If you want to control
#       for certain whether to generate the extra information, use -gstabs+,
#       -gstabs, -gxcoff+, -gxcoff, or -gvms (see below).

FLAGS_COMPILER_GDB+=		-g$(FLAGS_COMPILER_GDB_DEBUG_LEVEL)

#       GCC allows you to use -g with -O. The shortcuts taken by optimized code
#       may occasionally produce surprising results: some variables you
#       declared may not exist at all; flow of control may briefly move where
#       you did not expect it; some statements may not be executed because they
#       compute constant results or their values are already at hand; some
#       statements may execute in different places because they have been moved
#       out of loops.
#
#       Nevertheless it proves possible to debug optimized output. This makes
#       it reasonable to use the optimizer for programs that might have bugs.
#
#       The following options are useful when GCC is generated with the
#       capability for more than one debugging format. 
#
# INFO: -ggdb
#
#       Produce debugging information for use by GDB. This means to use the
#       most expressive format available (DWARF 2, stabs, or the native format
#       if neither of those are supported), including GDB extensions if at all
#       possible.
#

FLAGS_COMPILER_GDB+=		-ggdb$(FLAGS_COMPILER_GDB_DEBUG_LEVEL)

endif

