ifndef MK_FLAGS_COMPILER_DIALECT_MK
MK_FLAGS_COMPILER_DIALECT_MK=	TRUE

# TODO: Flags should be parsed and checked it there is no conflicting options.
# INFO: Official documentation:
#       https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
#
# INFO: The following options control the dialect of C (or languages derived
#       from C, such as C++, Objective-C and Objective-C++) that the compiler
#       accepts:
#       
# INFO: -ansi
#       In C mode, this is equivalent to -std=c90. In C++ mode, it is
#       equivalent to -std=c++98.
#
#       This turns off certain features of GCC that are incompatible with ISO
#       C90 (when compiling C code), or of standard C++ (when compiling C++
#       code), such as the asm and typeof keywords, and predefined macros such
#       as unix and vax that identify the type of system you are using. It also
#       enables the undesirable and rarely used ISO trigraph feature. For the C
#       compiler, it disables recognition of C++ style ‘//’ comments as well as
#       the inline keyword.
#       
#       The alternate keywords __asm__, __extension__, __inline__ and
#       __typeof__ continue to work despite -ansi. You would not want to use
#       them in an ISO C program, of course, but it is useful to put them in
#       header files that might be included in compilations done with -ansi.
#       Alternate predefined macros such as __unix__ and __vax__ are also
#       available, with or without -ansi.
#       
#       The -ansi option does not cause non-ISO programs to be rejected
#       gratuitously. For that, -Wpedantic is required in addition to -ansi.
#       See Warning Options.
#       
#       The macro __STRICT_ANSI__ is predefined when the -ansi option is used.
#       Some header files may notice this macro and refrain from declaring
#       certain functions or defining certain macros that the ISO standard
#       doesn't call for; this is to avoid interfering with any programs that
#       might use these names for other things.. \n
#       
#       Functions that are normally built in but do not have semantics defined
#       by ISO C (such as alloca and ffs) are not built-in functions when -ansi
#       is used. See Other built-in functions provided by GCC, for details of
#       the functions affected.
#       
# INFO: -std=
#       Determine the language standard. See Language Standards Supported by
#       GCC, for details of these standard versions. This option is currently
#       only supported when compiling C or C++.
#
#       The compiler can accept several base standards, such as ‘c90’ or
#       ‘c++98’, and GNU dialects of those standards, such as ‘gnu90’ or
#       ‘gnu++98’. When a base standard is specified, the compiler accepts all
#       programs following that standard plus those using GNU extensions that
#       do not contradict it. For example, -std=c90 turns off certain features
#       of GCC that are incompatible with ISO C90, such as the asm and typeof
#       keywords, but not other GNU extensions that do not have a meaning in
#       ISO C90, such as omitting the middle term of a ?: expression. On the
#       other hand, when a GNU dialect of a standard is specified, all features
#       supported by the compiler are enabled, even when those features change
#       the meaning of the base standard. As a result, some strict-conforming
#       programs may be rejected. The particular standard is used by -Wpedantic
#       to identify which features are GNU extensions given that version of the
#       standard. For example -std=gnu90 -Wpedantic warns about C++ style ‘//’
#       comments, while -std=gnu99 -Wpedantic does not.
#       
#       A value for this option must be provided; possible values are
#       
#       ‘c90’
#       ‘c89’
#       ‘iso9899:1990’
#              Support all ISO C90 programs (certain GNU extensions that
#              conflict with ISO C90 are disabled). Same as -ansi for C code.
#       ‘iso9899:199409’
#              ISO C90 as modified in amendment 1.
#       ‘c99’
#       ‘c9x’
#       ‘iso9899:1999’
#       ‘iso9899:199x’
#              ISO C99. This standard is substantially completely supported,
#              modulo bugs and floating-point issues (mainly but not entirely
#              relating to optional C99 features from Annexes F and G). See
#              http://gcc.gnu.org/c99status.html for more information. The
#              names ‘c9x’ and ‘iso9899:199x’ are deprecated.
#       ‘c11’
#       ‘c1x’
#       ‘iso9899:2011’
#              ISO C11, the 2011 revision of the ISO C standard. This standard
#              is substantially completely supported, modulo bugs,
#              floating-point issues (mainly but not entirely relating to
#              optional C11 features from Annexes F and G) and the optional
#              Annexes K (Bounds-checking interfaces) and L (Analyzability).
#              The name ‘c1x’ is deprecated.
#       ‘gnu90’
#       ‘gnu89’
#              GNU dialect of ISO C90 (including some C99 features).
#       ‘gnu99’
#       ‘gnu9x’
#              GNU dialect of ISO C99. The name ‘gnu9x’ is deprecated.
#       ‘gnu11’
#       ‘gnu1x’
#              GNU dialect of ISO C11. This is the default for C code. The name
#              ‘gnu1x’ is deprecated.
#       ‘c++98’
#       ‘c++03’
#              The 1998 ISO C++ standard plus the 2003 technical corrigendum
#              and some additional defect reports. Same as -ansi for C++ code.
#       ‘gnu++98’
#       ‘gnu++03’
#              GNU dialect of -std=c++98. This is the default for C++ code.
#       ‘c++11’
#       ‘c++0x’
#              The 2011 ISO C++ standard plus amendments. The name ‘c++0x’ is
#              deprecated.
#       ‘gnu++11’
#       ‘gnu++0x’
#              GNU dialect of -std=c++11. The name ‘gnu++0x’ is deprecated.
#       ‘c++14’
#       ‘c++1y’
#              The 2014 ISO C++ standard plus amendments. The name ‘c++1y’ is
#              deprecated.
#       ‘gnu++14’
#       ‘gnu++1y’
#              GNU dialect of -std=c++14. The name ‘gnu++1y’ is deprecated.
#       ‘c++1z’
#              The next revision of the ISO C++ standard, tentatively planned
#              for 2017. Support is highly experimental, and will almost
#              certainly change in incompatible ways in future releases.
#       ‘gnu++1z’
#              GNU dialect of -std=c++1z. Support is highly experimental, and
#              will almost certainly change in incompatible ways in future
#              releases.

#FLAGS_C_COMPILER_DIALECT+=		-std=c11
FLAGS_C_COMPILER_DIALECT+=		-std=gnu11
FLAGS_CPP_COMPILER_DIALECT+=		-std=c++11

# INFO: -fgnu89-inline
#       The option -fgnu89-inline tells GCC to use the traditional GNU
#       semantics for inline functions when in C99 mode. See An Inline Function
#       is As Fast As a Macro. Using this option is roughly equivalent to
#       adding the gnu_inline function attribute to all inline functions (see
#       Function Attributes).
#
#       The option -fno-gnu89-inline explicitly tells GCC to use the C99
#       semantics for inline when in C99 or gnu99 mode (i.e., it specifies the
#       default behavior). This option is not supported in -std=c90 or
#       -std=gnu90 mode.
#       
#       The preprocessor macros __GNUC_GNU_INLINE__ and __GNUC_STDC_INLINE__
#       may be used to check which semantics are in effect for inline
#       functions. See Common Predefined Macros.
#       
# INFO: -aux-info filename
#       Output to the given filename prototyped declarations for all functions
#       declared and/or defined in a translation unit, including those in
#       header files. This option is silently ignored in any language other
#       than C.
#
#       Besides declarations, the file indicates, in comments, the origin of
#       each declaration (source file and line), whether the declaration was
#       implicit, prototyped or unprototyped (‘I’, ‘N’ for new or ‘O’ for old,
#       respectively, in the first character after the line number and the
#       colon), and whether it came from a declaration or a definition (‘C’ or
#       ‘F’, respectively, in the following character). In the case of function
#       definitions, a K&R-style list of arguments followed by their
#       declarations is also provided, inside comments, after the declaration.
#       
# INFO: -fallow-parameterless-variadic-functions
#       Accept variadic functions without named parameters.
#       Although it is possible to define such a function, this is not very
#       useful as it is not possible to read the arguments. This is only
#       supported for C as this construct is allowed by C++.
#       
# INFO: -fno-asm
#       Do not recognize asm, inline or typeof as a keyword, so that code can
#       use these words as identifiers. You can use the keywords __asm__,
#       __inline__ and __typeof__ instead. -ansi implies -fno-asm.
#
#       In C++, this switch only affects the typeof keyword, since asm and
#       inline are standard keywords. You may want to use the -fno-gnu-keywords
#       flag instead, which has the same effect. In C99 mode (-std=c99 or
#       -std=gnu99), this switch only affects the asm and typeof keywords,
#       since inline is a standard keyword in ISO C99.
#       
# INFO: -fno-builtin
# INFO: -fno-builtin-function
#       Don't recognize built-in functions that do not begin with ‘__builtin_’
#       as prefix. See Other built-in functions provided by GCC, for details of
#       the functions affected, including those which are not built-in
#       functions when -ansi or -std options for strict ISO C conformance are
#       used because they do not have an ISO standard meaning.
#
#       GCC normally generates special code to handle certain built-in
#       functions more efficiently; for instance, calls to alloca may become
#       single instructions which adjust the stack directly, and calls to
#       memcpy may become inline copy loops. The resulting code is often both
#       smaller and faster, but since the function calls no longer appear as
#       such, you cannot set a breakpoint on those calls, nor can you change
#       the behavior of the functions by linking with a different library. In
#       addition, when a function is recognized as a built-in function, GCC may
#       use information about that function to warn about problems with calls
#       to that function, or to generate more efficient code, even if the
#       resulting code still contains calls to that function. For example,
#       warnings are given with -Wformat for bad calls to printf when printf
#       is built in and strlen is known not to modify global memory.
#       
#       With the -fno-builtin-function option only the built-in function
#       function is disabled. function must not begin with ‘__builtin_’. If a
#       function is named that is not built-in in this version of GCC, this
#       option is ignored. There is no corresponding -fbuiltin-function option;
#       if you wish to enable built-in functions selectively when using
#       -fno-builtin or -ffreestanding, you may define macros such as:
#       
#              #define abs(n)          __builtin_abs ((n))
#              #define strcpy(d, s)    __builtin_strcpy ((d), (s))

#FLAGS_C_COMPILER_DIALECT+=		-fno-builtin
#FLAGS_CPP_COMPILER_DIALECT+=		-fno-builtin

# INFO: -fhosted
#       Assert that compilation targets a hosted environment. This implies
#       -fbuiltin. A hosted environment is one in which the entire standard
#       library is available, and in which main has a return type of int.
#       Examples are nearly everything except a kernel. This is equivalent to
#       -fno-freestanding.

#FLAGS_C_COMPILER_DIALECT+=		-fhosted
#FLAGS_CPP_COMPILER_DIALECT+=		-fhosted

# INFO: -ffreestanding
#       Assert that compilation targets a freestanding environment. This
#       implies -fno-builtin. A freestanding environment is one in which the
#       standard library may not exist, and program startup may not necessarily
#       be at main. The most obvious example is an OS kernel. This is
#       equivalent to -fno-hosted.
#
#       See Language Standards Supported by GCC, for details of freestanding
#       and hosted environments.
#
# INFO: -fopenacc
#       Enable handling of OpenACC directives #pragma acc in C/C++ and !$acc in
#       Fortran. When -fopenacc is specified, the compiler generates
#       accelerated code according to the OpenACC Application Programming
#       Interface v2.0 http://www.openacc.org/. This option implies -pthread,
#       and thus is only supported on targets that have support for -pthread.
#
#       Note that this is an experimental feature, incomplete, and subject to
#       change in future versions of GCC. See https://gcc.gnu.org/wiki/OpenACC
#       for more information.
#       
# INFO: -fopenmp
#       Enable handling of OpenMP directives #pragma omp in C/C++ and !$omp in
#       Fortran. When -fopenmp is specified, the compiler generates parallel
#       code according to the OpenMP Application Program Interface v4.0
#       http://www.openmp.org/. This option implies -pthread, and thus is only
#       supported on targets that have support for -pthread. -fopenmp implies
#       -fopenmp-simd.
#
# INFO: -fopenmp-simd
#       Enable handling of OpenMP's SIMD directives with #pragma omp in C/C++
#       and !$omp in Fortran. Other OpenMP directives are ignored.
#
# INFO: -fcilkplus
#       Enable the usage of Cilk Plus language extension features for C/C++.
#       When the option -fcilkplus is specified, enable the usage of the Cilk
#       Plus Language extension features for C/C++. The present implementation
#       follows ABI version 1.2. This is an experimental feature that is only
#       partially complete, and whose interface may change in future versions
#       of GCC as the official specification changes. Currently, all features
#       but _Cilk_for have been implemented.
#
# INFO: -fgnu-tm
#       When the option -fgnu-tm is specified, the compiler generates code for
#       the Linux variant of Intel's current Transactional Memory ABI
#       specification document (Revision 1.1, May 6 2009). This is an
#       experimental feature whose interface may change in future versions of
#       GCC, as the official specification changes. Please note that not all
#       architectures are supported for this feature.
#
#       For more information on GCC's support for transactional memory, See The
#       GNU Transactional Memory Library.
#       
#       Note that the transactional memory feature is not supported with
#       non-call exceptions (-fnon-call-exceptions).
#       
# INFO: -fms-extensions
#       Accept some non-standard constructs used in Microsoft header files.
#
#       In C++ code, this allows member names in structures to be similar to
#       previous types declarations.
#       
#              typedef int UOW;
#              struct ABC {
#                UOW UOW;
#              };
#
#       Some cases of unnamed fields in structures and unions are only accepted
#       with this option. See Unnamed struct/union fields within
#       structs/unions, for details.
#       
#       Note that this option is off for all targets but x86 targets using
#       ms-abi.
#       
# INFO: -fplan9-extensions
#       Accept some non-standard constructs used in Plan 9 code.
#
#       This enables -fms-extensions, permits passing pointers to structures
#       with anonymous fields to functions that expect pointers to elements of
#       the type of the field, and permits referring to anonymous fields
#       declared using a typedef. See Unnamed struct/union fields within
#       structs/unions, for details. This is only supported for C, not C++.
#       
# INFO: -trigraphs
#       Support ISO C trigraphs. The -ansi option (and -std options for strict
#       ISO C conformance) implies -trigraphs.
#       
# INFO: -traditional
# INFO: -traditional-cpp
#       Formerly, these options caused GCC to attempt to emulate a pre-standard
#       C compiler. They are now only supported with the -E switch. The
#       preprocessor continues to support a pre-standard mode. See the GNU CPP
#       manual for details.
#
# INFO: -fcond-mismatch
#       Allow conditional expressions with mismatched types in the second and
#       third arguments. The value of such an expression is void. This option
#       is not supported for C++.
#
# INFO: -flax-vector-conversions
#       Allow implicit conversions between vectors with differing numbers of
#       elements and/or incompatible element types. This option should not be
#       used for new code.
#
# INFO: -funsigned-char
#       Let the type char be unsigned, like unsigned char.
#       Each kind of machine has a default for what char should be. It is
#       either like unsigned char by default or like signed char by default.
#       
#       Ideally, a portable program should always use signed char or unsigned
#       char when it depends on the signedness of an object. But many programs
#       have been written to use plain char and expect it to be signed, or
#       expect it to be unsigned, depending on the machines they were written
#       for. This option, and its inverse, let you make such a program work
#       with the opposite default.
#       
#       The type char is always a distinct type from each of signed char or
#       unsigned char, even though its behavior is always just like one of
#       those two.
#       
# INFO: -fsigned-char
#       Let the type char be signed, like signed char.

FLAGS_C_COMPILER_DIALECT+=		-fsigned-char
FLAGS_CPP_COMPILER_DIALECT+=		-fsigned-char

#       Note that this is equivalent to -fno-unsigned-char, which is the
#       negative form of -funsigned-char. Likewise, the option -fno-signed-char
#       is equivalent to -funsigned-char.
#       
# INFO: -fsigned-bitfields
# INFO: -funsigned-bitfields
# INFO: -fno-signed-bitfields
# INFO: -fno-unsigned-bitfields
#       These options control whether a bit-field is signed or unsigned, when
#       the declaration does not use either signed or unsigned. By default,
#       such a bit-field is signed, because this is consistent: the basic
#       integer types such as int are signed types.

endif

