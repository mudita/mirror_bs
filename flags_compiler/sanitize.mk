ifndef MK_FLAGS_COMPILER_SANITIZE_MK
MK_FLAGS_COMPILER_SANITIZE_MK=	TRUE

INCLUDER_MODULES_LIST=		mode
				

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Flags should be parsed and checked it there is no conflicting options.
# TODO: Only some of flags are described here.
# INFO: Official documentation:
#       https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
#
# INFO: -fsanitize=address
#       Enable AddressSanitizer, a fast memory error detector. Memory access
#       instructions are instrumented to detect out-of-bounds and
#       use-after-free bugs. See http://code.google.com/p/address-sanitizer/
#       for more details. The run-time behavior can be influenced using the
#       ASAN_OPTIONS environment variable; see
#       https://code.google.com/p/address-sanitizer/wiki/Flags#Run-time_flags
#       for a list of supported options.

ifdef MODE_SANITIZER_ADDRESS
ifeq ($(MODE_SANITIZER_ADDRESS), ENABLE)
#FLAGS_COMPILER_SANITIZE+=		-fsanitize=address
endif
endif

# INFO: Official documentation:
#       http://clang.llvm.org/docs/AddressSanitizer.html

# INFO: Simply compile and link your program with -fsanitize=address flag. The
#       AddressSanitizer run-time library should be linked to the final
#       executable, so make sure to use clang (not ld) for the final link step.
#       When linking shared libraries, the AddressSanitizer run-time is not
#       linked, so -Wl,-z,defs may cause link errors (don’t use it with
#       AddressSanitizer). To get a reasonable performance add -O1 or higher.
#       To get nicer stack traces in error messages add
#       -fno-omit-frame-pointer. To get perfect stack traces you may need to
#       disable inlining (just use -O1) and tail call elimination
#       (-fno-optimize-sibling-calls).
#

FLAGS_COMPILER_SANITIZE+=		-fno-omit-frame-pointer \
				-fno-optimize-sibling-calls

# INFO: Official documentation:
#       https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
#
# INFO: -fsanitize=kernel-address
#       Enable AddressSanitizer for Linux kernel. See
#       http://code.google.com/p/address-sanitizer/wiki/AddressSanitizerForKernel
#       for more details.
#
# INFO: -fsanitize=thread
#       Enable ThreadSanitizer, a fast data race detector. Memory access
#       instructions are instrumented to detect data race bugs. See
#       http://code.google.com/p/thread-sanitizer/ for more details. The
#       run-time behavior can be influenced using the TSAN_OPTIONS environment
#       variable; see https://code.google.com/p/thread-sanitizer/wiki/Flags for
#       a list of supported options. To get a reasonable performance add -O1 or
#       higher. Use -g to get file names and line numbers in the warning
#       messages.

ifdef MODE_SANITIZER_THREAD
ifeq ($(MODE_SANITIZER_THREAD), ENABLE)
FLAGS_COMPILER_SANITIZE+=		-fsanitize=thread
endif
endif

# INFO: -fsanitize=leak
#       Enable LeakSanitizer, a memory leak detector. This option only matters
#       for linking of executables and if neither -fsanitize=address nor
#       -fsanitize=thread is used. In that case the executable is linked
#       against a library that overrides malloc and other allocator functions.
#       See https://code.google.com/p/address-sanitizer/wiki/LeakSanitizer for
#       more details. The run-time behavior can be influenced using the 
#       LSAN_OPTIONS environment variable.

ifdef MODE_SANITIZER_LEAK
ifeq ($(MODE_SANITIZER_LEAK), ENABLE)
#FLAGS_COMPILER_SANITIZE+=		-fsanitize=leak
endif
endif

# INFO: -fsanitize=undefined
#       Enable UndefinedBehaviorSanitizer, a fast undefined behavior detector.
#       Various computations are instrumented to detect undefined behavior at
#       runtime. Current suboptions are:

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=undefined

#       -fsanitize=shift
#       This option enables checking that the result of a shift operation is
#       not undefined. Note that what exactly is considered undefined differs
#       slightly between C and C++, as well as between ISO C90 and C99, etc.

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=shift

#       -fsanitize=integer-divide-by-zero
#       Detect integer division by zero as well as INT_MIN / -1 division.

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=integer-divide-by-zero

#       -fsanitize=unreachable
#       With this option, the compiler turns the __builtin_unreachable call
#       into a diagnostics message call instead. When reaching the
#       __builtin_unreachable call, the behavior is undefined. 

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=unreachable

#       -fsanitize=vla-bound
#       This option instructs the compiler to check that the size of a variable
#       length array is positive.

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=vla-bound

#       -fsanitize=null
#       This option enables pointer checking. Particularly, the application
#       built with this option turned on will issue an error message when it
#       tries to dereference a NULL pointer, or if a reference (possibly an
#       rvalue reference) is bound to a NULL pointer, or if a method is invoked
#       on an object pointed by a NULL pointer.

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=null

#       -fsanitize=return
#       This option enables return statement checking. Programs built with this
#       option turned on will issue an error message when the end of a non-void
#       function is reached without actually returning a value. This option
#       works in C++ only.
#
#       -fsanitize=signed-integer-overflow
#       This option enables signed integer overflow checking. We check that the
#       result of +, *, and both unary and binary - does not overflow in the
#       signed arithmetics. Note, integer promotion rules must be taken into
#       account. That is, the following is not an overflow:
#
#              signed char a = SCHAR_MAX;
#              a++;

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=signed-integer-overflow

#       -fsanitize=bounds
#       This option enables instrumentation of array bounds. Various out of
#       bounds accesses are detected. Flexible array members, flexible array
#       member-like arrays, and initializers of variables with static storage
#       are not instrumented.

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=bounds

#       -fsanitize=alignment
#       This option enables checking of alignment of pointers when they are
#       dereferenced, or when a reference is bound to insufficiently aligned
#       target, or when a method or constructor is invoked on insufficiently
#       aligned object.

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=alignment

#       -fsanitize=object-size
#       This option enables instrumentation of memory references using the
#       __builtin_object_size function. Various out of bounds pointer accesses
#       are detected.

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=object-size

#       -fsanitize=float-divide-by-zero
#       Detect floating-point division by zero. Unlike other similar options,
#       -fsanitize=float-divide-by-zero is not enabled by -fsanitize=undefined,
#       since floating-point division by zero can be a legitimate way of
#       obtaining infinities and NaNs. 

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=float-divide-by-zero

#       -fsanitize=float-cast-overflow
#       This option enables floating-point type to integer conversion checking.
#       We check that the result of the conversion does not overflow. Unlike
#       other similar options, -fsanitize=float-cast-overflow is not enabled by
#       -fsanitize=undefined. This option does not work well with FE_INVALID
#       exceptions enabled.

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=float-cast-overflow

#       -fsanitize=nonnull-attribute
#       This option enables instrumentation of calls, checking whether null
#       values are not passed to arguments marked as requiring a non-null value
#       by the nonnull function attribute. 

# TODO: On ubuntu there was problem with this flag
#FLAGS_COMPILER_SANITIZE+=		-fsanitize=nonnull-attribute

#       -fsanitize=returns-nonnull-attribute
#       This option enables instrumentation of return statements in functions
#       marked with returns_nonnull function attribute, to detect returning of
#       null values from such functions. 

# TODO: On ubuntu there was problem with this flag
#FLAGS_COMPILER_SANITIZE+=		-fsanitize=returns-nonnull-attribute

#       -fsanitize=bool
#       This option enables instrumentation of loads from bool. If a value
#       other than 0/1 is loaded, a run-time error is issued. 

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=bool

#       -fsanitize=enum
#       This option enables instrumentation of loads from an enum type. If a
#       value outside the range of values for the enum type is loaded, a
#       run-time error is issued. 

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=enum

#      -fsanitize=vptr
#       This option enables instrumentation of C++ member function calls,
#       member accesses and some conversions between pointers to base and
#       derived classes, to verify the referenced object has the correct
#       dynamic type.
#       While -ftrapv causes traps for signed overflows to be emitted,
#       -fsanitize=undefined gives a diagnostic message. This currently works
#       only for the C family of languages. 

#FLAGS_COMPILER_SANITIZE+=		-fsanitize=vptr

# INFO: -fno-sanitize=all
#       This option disables all previously enabled sanitizers. -fsanitize=all
#       is not allowed, as some sanitizers cannot be used together. 
#
# INFO: -fasan-shadow-offset=number
#       This option forces GCC to use custom shadow offset in AddressSanitizer
#       checks. It is useful for experimenting with different shadow memory
#       layouts in Kernel AddressSanitizer. 
#
# INFO: -fsanitize-recover[=opts]
#       -fsanitize-recover= controls error recovery mode for sanitizers
#       mentioned in comma-separated list of opts. Enabling this option for a
#       sanitizer component causes it to attempt to continue running the
#       program as if no error happened. This means multiple runtime errors can
#       be reported in a single program run, and the exit code of the program
#       may indicate success even when errors have been reported. The
#       -fno-sanitize-recover= option can be used to alter this behavior: only
#       the first detected error is reported and program then exits with a
#       non-zero exit code.
#
#       Currently this feature only works for -fsanitize=undefined (and its
#       suboptions except for -fsanitize=unreachable and -fsanitize=return),
#       -fsanitize=float-cast-overflow, -fsanitize=float-divide-by-zero and
#       -fsanitize=kernel-address. For these sanitizers error recovery is
#       turned on by default. -fsanitize-recover=all and
#       -fno-sanitize-recover=all is also accepted, the former enables recovery
#       for all sanitizers that support it, the latter disables recovery for
#       all sanitizers that support it.
#       
#       Syntax without explicit opts parameter is deprecated. It is equivalent
#       to
#       
#              -fsanitize-recover=undefined,float-cast-overflow,
#              float-divide-by-zero
#
#       Similarly -fno-sanitize-recover is equivalent to
#
#              -fno-sanitize-recover=undefined,float-cast-overflow,
#              float-divide-by-zero

# TODO: On ubuntu there was problem with this flag
#FLAGS_COMPILER_SANITIZE+=		-fsanitize-recover=all

# INFO: -fsanitize-undefined-trap-on-error
#       The -fsanitize-undefined-trap-on-error option instructs the compiler to
#       report undefined behavior using __builtin_trap rather than a libubsan
#       library routine. The advantage of this is that the libubsan library is
#       not needed and is not linked in, so this is usable even in freestanding
#       environments.

# INFO: -fsanitize=memory
#       MemorySanitizer is a detector of uninitialized reads. It consists of a
#       compiler instrumentation module and a run-time library. When linking
#       shared libraries, the MemorySanitizer run-time is not linked, so
#       -Wl,-z,defs may cause link errors (don’t use it with MemorySanitizer).
#       To get a reasonable performance add -O1 or higher. To get meaninful
#       stack traces in error messages add -fno-omit-frame-pointer. To get
#       perfect stack traces you may need to disable inlining (just use -O1)
#       and tail call elimination (-fno-optimize-sibling-calls).

ifdef MODE_SANITIZER_MEMORY
ifeq ($(MODE_SANITIZER_MEMORY), ENABLE)
FLAGS_COMPILER_SANITIZE+=		-fsanitize=memory
endif
endif

endif

