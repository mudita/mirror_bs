ifndef MK_FLAGS_COMPILER_WARNINGS_MK
MK_FLAGS_COMPILER_WARNINGS_MK=	TRUE

# TODO: Flags should be parsed and checked it there is no conflicting options.
# INFO: Official documentation:
#       https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
#
# INFO: Warnings are diagnostic messages that report constructions that are not
#       inherently erroneous but that are risky or suggest there may have been
#       an error.
#
#       The following language-independent options do not enable specific
#       warnings but control the kinds of diagnostics produced by GCC.
#
# INFO: -fsyntax-only
#       Check the code for syntax errors, but don't do anything beyond that.
#
# INFO: -fmax-errors=n
#       Limits the maximum number of error messages to n, at which point GCC
#       bails out rather than attempting to continue processing the source
#       code. If n is 0 (the default), there is no limit on the number of error
#       messages produced. If -Wfatal-errors is also specified, then
#       -Wfatal-errors takes precedence over this option.
#
# INFO: -w
#       Inhibit all warning messages.
#
# INFO: -Werror
#       Make all warnings into errors.

FLAGS_COMPILER_WARNINGS+=		-Werror

# INFO: -Werror=
#       Make the specified warning into an error. The specifier for a warning
#       is appended; for example -Werror=switch turns the warnings controlled
#       by -Wswitch into errors. This switch takes a negative form, to be used
#       to negate -Werror for specific warnings; for example -Wno-error=switch
#       makes -Wswitch warnings not be errors, even when -Werror is in effect.
#
#       The warning message for each controllable warning includes the option
#       that controls the warning. That option can then be used with -Werror=
#       and -Wno-error= as described above. (Printing of the option in the
#       warning message can be disabled using the -fno-diagnostics-show-option
#       flag.)
#
#       Note that specifying -Werror=foo automatically implies -Wfoo. However,
#       -Wno-error=foo does not imply anything.
#
# INFO: -Wfatal-errors
#       This option causes the compiler to abort compilation on the first error
#       occurred rather than trying to keep going and printing further error
#       messages.
#
#       You can request many specific warnings with options beginning with
#       ‘-W’, for example -Wimplicit to request warnings on implicit
#       declarations. Each of these specific warning options also has a
#       negative form beginning ‘-Wno-’ to turn off warnings; for example,
#       -Wno-implicit. This manual lists only one of the two forms, whichever
#       is not the default. For further language-specific options also refer to
#       C++ Dialect Options and Objective-C and Objective-C++ Dialect Options.
#
#       Some options, such as -Wall and -Wextra, turn on other options, such as
#       -Wunused, which may turn on further options, such as -Wunused-value.
#       The combined effect of positive and negative forms is that more
#       specific options have priority over less specific ones, independently
#       of their position in the command-line. For options of the same
#       specificity, the last one takes effect. Options enabled or disabled via
#       pragmas (see Diagnostic Pragmas) take effect as if they appeared at the
#       end of the command-line.
#
#       When an unrecognized warning option is requested (e.g.,
#       -Wunknown-warning), GCC emits a diagnostic stating that the option is
#       not recognized. However, if the -Wno- form is used, the behavior is
#       slightly different: no diagnostic is produced for -Wno-unknown-warning
#       unless other diagnostics are being produced. This allows the use of new
#       -Wno- options with old compilers, but if something goes wrong, the
#       compiler warns that an unrecognized option is present.

FLAGS_COMPILER_WARNINGS+=		-Wfatal-errors

# INFO: -Wpedantic
# INFO: -pedantic
#       Issue all the warnings demanded by strict ISO C and ISO C++; reject all
#       programs that use forbidden extensions, and some other programs that do
#       not follow ISO C and ISO C++. For ISO C, follows the version of the ISO
#       C standard specified by any -std option used.
#
#       Valid ISO C and ISO C++ programs should compile properly with or
#       without this option (though a rare few require -ansi or a -std option
#       specifying the required version of ISO C). However, without this
#       option, certain GNU extensions and traditional C and C++ features are
#       supported as well. With this option, they are rejected.
#
#       -Wpedantic does not cause warning messages for use of the alternate
#       keywords whose names begin and end with ‘__’. Pedantic warnings are
#       also disabled in the expression that follows __extension__. However,
#       only system header files should use these escape routes; application
#       programs should avoid them. See Alternate Keywords.
#
#       Some users try to use -Wpedantic to check programs for strict ISO C
#       conformance. They soon find that it does not do quite what they want:
#       it finds some non-ISO practices, but not all—only those for which ISO C
#       requires a diagnostic, and some others for which diagnostics have been
#       added.
#
#       A feature to report any failure to conform to ISO C might be useful in
#       some instances, but would require considerable additional work and
#       would be quite different from -Wpedantic. We don't have plans to
#       support such a feature in the near future.
#
#       Where the standard specified with -std represents a GNU extended
#       dialect of C, such as ‘gnu90’ or ‘gnu99’, there is a corresponding
#       base standard, the version of ISO C on which the GNU extended dialect
#       is based. Warnings from -Wpedantic are given where they are required
#       by the base standard. (It does not make sense for such warnings to be
#       given only for features not in the specified GNU C dialect, since by
#       definition the GNU dialects of C include all features the compiler
#       supports with the given option, and there would be nothing to warn
#       about.) 

FLAGS_COMPILER_WARNINGS+=		-Wpedantic

# INFO: -pedantic-errors
#       Give an error whenever the base standard (see -Wpedantic) requires a
#       diagnostic, in some cases where there is undefined behavior at
#       compile-time and in some other cases that do not prevent compilation of
#       programs that are valid according to the standard. This is not
#       equivalent to -Werror=pedantic, since there are errors enabled by this
#       option and not enabled by the latter and vice versa.

FLAGS_COMPILER_WARNINGS+=		-pedantic-errors

# INFO: -Wall
#       This enables all the warnings about constructions that some users
#       consider questionable, and that are easy to avoid (or modify to prevent
#       the warning), even in conjunction with macros. This also enables some
#       language-specific warnings described in C++ Dialect Options and
#       Objective-C and Objective-C++ Dialect Options.
#
#       -Wall turns on the following warning flags:
#
#              -Waddress   
#              -Warray-bounds=1 (only with -O2)  
#              -Wc++11-compat  -Wc++14-compat
#              -Wchar-subscripts  
#              -Wenum-compare (in C/ObjC; this is on by default in C++) 
#              -Wimplicit-int (C and Objective-C only) 
#              -Wimplicit-function-declaration (C and Objective-C only) 
#              -Wcomment  
#              -Wformat   
#              -Wmain (only for C/ObjC and unless -ffreestanding)  
#              -Wmaybe-uninitialized 
#              -Wmissing-braces (only for C/ObjC) 
#              -Wnonnull  
#              -Wopenmp-simd 
#              -Wparentheses  
#              -Wpointer-sign  
#              -Wreorder   
#              -Wreturn-type  
#              -Wsequence-point  
#              -Wsign-compare (only in C++)  
#              -Wstrict-aliasing  
#              -Wstrict-overflow=1  
#              -Wswitch  
#              -Wtrigraphs  
#              -Wuninitialized  
#              -Wunknown-pragmas  
#              -Wunused-function  
#              -Wunused-label     
#              -Wunused-value     
#              -Wunused-variable  
#              -Wvolatile-register-var 
#              
#       Note that some warning flags are not implied by -Wall. Some of them
#       warn about constructions that users generally do not consider
#       questionable, but which occasionally you might wish to check for;
#       others warn about constructions that are necessary or hard to avoid in
#       some cases, and there is no simple way to modify the code to suppress
#       the warning. Some of them are enabled by -Wextra but many of them must
#       be enabled individually.

FLAGS_COMPILER_WARNINGS+=		-Wall

# INFO: -Wextra
#       This enables some extra warning flags that are not enabled by -Wall.
#       (This option used to be called -W. The older name is still supported,
#       but the newer name is more descriptive.)
#              -Wclobbered  
#              -Wempty-body  
#              -Wignored-qualifiers 
#              -Wmissing-field-initializers  
#              -Wmissing-parameter-type (C only)  
#              -Wold-style-declaration (C only)  
#              -Woverride-init  
#              -Wsign-compare  
#              -Wtype-limits  
#              -Wuninitialized  
#              -Wunused-parameter (only with -Wunused or -Wall) 
#              -Wunused-but-set-parameter (only with -Wunused or -Wall)  
#              
#       The option -Wextra also prints warning messages for the following cases:
#
#              * A pointer is compared against integer zero with <, <=, >, or
#                >=.
#              * (C++ only) An enumerator and a non-enumerator both appear in a
#                conditional expression.
#              * (C++ only) Ambiguous virtual bases.
#              * (C++ only) Subscripting an array that has been declared
#                register.
#              * (C++ only) Taking the address of a variable that has been
#                declared register.
#              * (C++ only) A base class is not initialized in a derived
#                class's copy constructor.

FLAGS_COMPILER_WARNINGS+=		-Wextra

# INFO: -Wchar-subscripts
#       Warn if an array subscript has type char. This is a common cause of
#       error, as programmers often forget that this type is signed on some
#       machines.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wcomment
#       Warn whenever a comment-start sequence ‘/*’ appears in a ‘/*’ comment,
#       or whenever a Backslash-Newline appears in a ‘//’ comment. This warning
#       is enabled by -Wall.

FLAGS_COMPILER_WARNINGS+=		-Wunreachable-code

# INFO: -Wno-coverage-mismatch
#       Warn if feedback profiles do not match when using the -fprofile-use
#       option. If a source file is changed between compiling with
#       -fprofile-gen and with -fprofile-use, the files with the profile
#       feedback can fail to match the source file and GCC cannot use the
#       profile feedback information. By default, this warning is enabled and
#       is treated as an error. -Wno-coverage-mismatch can be used to disable
#       the warning or -Wno-error=coverage-mismatch can be used to disable the
#       error. Disabling the error for this warning can result in poorly
#       optimized code and is useful only in the case of very minor changes
#       such as bug fixes to an existing code-base. Completely disabling the
#       warning is not recommended.
#
# INFO: -Wno-cpp
#       (C, Objective-C, C++, Objective-C++ and Fortran only)
#
#       Suppress warning messages emitted by #warning directives.
#
# INFO: -Wdouble-promotion (C, C++, Objective-C and Objective-C++ only)
#       Give a warning when a value of type float is implicitly promoted to
#       double. CPUs with a 32-bit “single-precision” floating-point unit
#       implement float in hardware, but emulate double in software. On such a
#       machine, doing computations using double values is much more expensive
#       because of the overhead required for software emulation.
#
#       It is easy to accidentally do computations with double because
#       floating-point literals are implicitly of type double. For example, in:
#
#              float area(float radius)
#              {
#                 return 3.14159 * radius * radius;
#              }
#
#       the compiler performs the entire computation with double because the
#       floating-point literal is a double.
#
# INFO: -Wformat
# INFO: -Wformat=n
#       Check calls to printf and scanf, etc., to make sure that the arguments
#       supplied have types appropriate to the format string specified, and
#       that the conversions specified in the format string make sense. This
#       includes standard functions, and others specified by format attributes
#       (see Function Attributes), in the printf, scanf, strftime and strfmon
#       (an X/Open extension, not in the C standard) families (or other
#       target-specific families). Which functions are checked without format
#       attributes having been specified depends on the standard version
#       selected, and such checks of functions without the attribute specified
#       are disabled by -ffreestanding or -fno-builtin.
#
#       The formats are checked against the format features supported by GNU
#       libc version 2.2. These include all ISO C90 and C99 features, as well
#       as features from the Single Unix Specification and some BSD and GNU
#       extensions. Other library implementations may not support all these
#       features; GCC does not support warning about features that go beyond a
#       particular library's limitations. However, if -Wpedantic is used with
#       -Wformat, warnings are given about format features not in the selected
#       standard version (but not for strfmon formats, since those are not in
#       any version of the C standard). See Options Controlling C Dialect.
#
#              -Wformat=1
#              -Wformat
#              Option -Wformat is equivalent to -Wformat=1, and -Wno-format is
#              equivalent to -Wformat=0. Since -Wformat also checks for null
#              format arguments for several functions, -Wformat also implies
#              -Wnonnull. Some aspects of this level of format checking can be
#              disabled by the options: -Wno-format-contains-nul,
#              -Wno-format-extra-args, and -Wno-format-zero-length. -Wformat is
#              enabled by -Wall.
#
#              -Wno-format-contains-nul
#              If -Wformat is specified, do not warn about format strings that
#              contain NUL bytes.
#
#              -Wno-format-extra-args
#              If -Wformat is specified, do not warn about excess arguments to
#              a printf or scanf format function. The C standard specifies that
#              such arguments are ignored.
#              Where the unused arguments lie between used arguments that are
#              specified with ‘$’ operand number specifications, normally
#              warnings are still given, since the implementation could not
#              know what type to pass to va_arg to skip the unused arguments.
#              However, in the case of scanf formats, this option suppresses
#              the warning if the unused arguments are all pointers, since the
#              Single Unix Specification says that such unused arguments are
#              allowed.
#
#              -Wno-format-zero-length
#              If -Wformat is specified, do not warn about zero-length formats.
#              The C standard specifies that zero-length formats are allowed.
#
#              -Wformat=2
#              Enable -Wformat plus additional format checks. Currently
#              equivalent to -Wformat -Wformat-nonliteral -Wformat-security
#              -Wformat-y2k.
#
#              -Wformat-nonliteral
#              If -Wformat is specified, also warn if the format string is not
#              a string literal and so cannot be checked, unless the format
#              function takes its format arguments as a va_list.
#
#              -Wformat-security
#              If -Wformat is specified, also warn about uses of format
#              functions that represent possible security problems. At present,
#              this warns about calls to printf and scanf functions where the
#              format string is not a string literal and there are no format
#              arguments, as in printf (foo);. This may be a security hole if
#              the format string came from untrusted input and contains ‘%n’.
#              (This is currently a subset of what -Wformat-nonliteral warns
#              about, but in future warnings may be added to -Wformat-security
#              that are not included in -Wformat-nonliteral.) 
#
#              -Wformat-signedness
#              If -Wformat is specified, also warn if the format string
#              requires an unsigned argument and the argument is signed and
#              vice versa.
#
#              -Wformat-y2k
#              If -Wformat is specified, also warn about strftime formats that
#              may yield only a two-digit year.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wnonnull
#       Warn about passing a null pointer for arguments marked as requiring a
#       non-null value by the nonnull function attribute.
#
#       -Wnonnull is included in -Wall and -Wformat. It can be disabled with
#       the -Wno-nonnull option.
#
# INFO: -Winit-self (C, C++, Objective-C and Objective-C++ only)
#       Warn about uninitialized variables that are initialized with
#       themselves. Note this option can only be used with the -Wuninitialized
#       option.
#
#       For example, GCC warns about i being uninitialized in the following
#       snippet only when -Winit-self has been specified:
#
#              int f()
#              {
#                int i = i;
#                return i;
#              }
#
# INFO: This warning is enabled by -Wall in C++.

FLAGS_COMPILER_WARNINGS+=		-Winit-self

# INFO: -Wimplicit-int (C and Objective-C only)
#       Warn when a declaration does not specify a type. This warning is
#       enabled by -Wall.
#
# INFO: -Wimplicit-function-declaration (C and Objective-C only)
#       Give a warning whenever a function is used before being declared. In
#       C99 mode (-std=c99 or -std=gnu99), this warning is enabled by default
#       and it is made into an error by -pedantic-errors. This warning is also
#       enabled by -Wall.
#
# INFO: -Wimplicit (C and Objective-C only)
#       Same as -Wimplicit-int and -Wimplicit-function-declaration. This
#       warning is enabled by -Wall.
#
# INFO: -Wignored-qualifiers (C and C++ only)
#       Warn if the return type of a function has a type qualifier such as
#       const. For ISO C such a type qualifier has no effect, since the value
#       returned by a function is not an lvalue. For C++, the warning is only
#       emitted for scalar types or void. ISO C prohibits qualified void return
#       types on function definitions, so such return types always receive a
#       warning even without this option.
#
#       This warning is also enabled by -Wextra.
#
# INFO: -Wmain
#       Warn if the type of main is suspicious. main should be a function with
#       external linkage, returning int, taking either zero arguments, two, or
#       three arguments of appropriate types. This warning is enabled by
#       default in C++ and is enabled by either -Wall or -Wpedantic.
#
# INFO: -Wmissing-braces
#       Warn if an aggregate or union initializer is not fully bracketed. In
#       the following example, the initializer for a is not fully bracketed,
#       but that for b is fully bracketed.
#
# INFO: This warning is enabled by -Wall in C.
#
#              int a[2][2] = { 0, 1, 2, 3 };
#              int b[2][2] = { { 0, 1 }, { 2, 3 } };
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wmissing-include-dirs (C, C++, Objective-C and Objective-C++ only)
#       Warn if a user-supplied include directory does not exist.

FLAGS_COMPILER_WARNINGS+=		-Wmissing-include-dirs

# INFO: -Wparentheses
#       Warn if parentheses are omitted in certain contexts, such as when there
#       is an assignment in a context where a truth value is expected, or when
#       operators are nested whose precedence people often get confused about.
#
#       Also warn if a comparison like x<=y<=z appears; this is equivalent to
#       (x<=y ? 1 : 0) <= z, which is a different interpretation from that of
#       ordinary mathematical notation.
#
#       Also warn about constructions where there may be confusion to which if
#       statement an else branch belongs. Here is an example of such a case:
#
#              {
#                if (a)
#                  if (b)
#                    foo ();
#                else
#                  bar ();
#              }
#
#       In C/C++, every else branch belongs to the innermost possible if
#       statement, which in this example is if (b). This is often not what the
#       programmer expected, as illustrated in the above example by indentation
#       the programmer chose. When there is the potential for this confusion,
#       GCC issues a warning when this flag is specified. To eliminate the
#       warning, add explicit braces around the innermost if statement so there
#       is no way the else can belong to the enclosing if. The resulting code
#       looks like this:
#
#              {
#                if (a)
#                  {
#                    if (b)
#                      foo ();
#                    else
#                      bar ();
#                  }
#              }
#
#       Also warn for dangerous uses of the GNU extension to ?: with omitted
#       middle operand. When the condition in the ?: operator is a boolean
#       expression, the omitted value is always 1. Often programmers expect it
#       to be a value computed inside the conditional expression instead.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wsequence-point
#       Warn about code that may have undefined semantics because of violations
#       of sequence point rules in the C and C++ standards.
#       The C and C++ standards define the order in which expressions in a
#       C/C++ program are evaluated in terms of sequence points, which
#       represent a partial ordering between the execution of parts of the
#       program: those executed before the sequence point, and those executed
#       after it. These occur after the evaluation of a full expression (one
#       which is not part of a larger expression), after the evaluation of the
#       first operand of a &&, ||, ? : or , (comma) operator, before a function
#       is called (but after the evaluation of its arguments and the expression
#       denoting the called function), and in certain other places. Other than
#       as expressed by the sequence point rules, the order of evaluation of
#       subexpressions of an expression is not specified. All these rules
#       describe only a partial order rather than a total order, since, for
#       example, if two functions are called within one expression with no
#       sequence point between them, the order in which the functions are
#       called is not specified. However, the standards committee have ruled
#       that function calls do not overlap.
#
#       It is not specified when between sequence points modifications to the
#       values of objects take effect. Programs whose behavior depends on this
#       have undefined behavior; the C and C++ standards specify that “Between
#       the previous and next sequence point an object shall have its stored
#       value modified at most once by the evaluation of an expression.
#       Furthermore, the prior value shall be read only to determine the value
#       to be stored.”. If a program breaks these rules, the results on any
#       particular implementation are entirely unpredictable.
#
#       Examples of code with undefined behavior are a = a++;, a[n] = b[n++]
#       and a[i++] = i;. Some more complicated cases are not diagnosed by this
#       option, and it may give an occasional false positive result, but in
#       general it has been found fairly effective at detecting this sort of
#       problem in programs.
#
#       The standard is worded confusingly, therefore there is some debate over
#       the precise meaning of the sequence point rules in subtle cases. Links
#       to discussions of the problem, including proposed formal definitions,
#       may be found on the GCC readings page, at
#       http://gcc.gnu.org/readings.html.
#
# INFO: This warning is enabled by -Wall for C and C++.
#
# INFO: -Wno-return-local-addr
#       Do not warn about returning a pointer (or in C++, a reference) to a
#       variable that goes out of scope after the function returns.
#
# INFO: -Wreturn-type
#       Warn whenever a function is defined with a return type that defaults to
#       int. Also warn about any return statement with no return value in a
#       function whose return type is not void (falling off the end of the
#       function body is considered returning without a value), and about a
#       return statement with an expression in a function whose return type is
#       void.
#
#       For C++, a function without return type always produces a diagnostic
#       message, even when -Wno-return-type is specified. The only exceptions
#       are main and functions defined in system headers.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wshift-count-negative
#       Warn if shift count is negative.
#
# INFO: This warning is enabled by default.
#
# INFO: -Wshift-count-overflow
#       Warn if shift count >= width of type.
#
# INFO: This warning is enabled by default.
#
# INFO: -Wswitch
#       Warn whenever a switch statement has an index of enumerated type and
#       lacks a case for one or more of the named codes of that enumeration.
#       (The presence of a default label prevents this warning.) case labels
#       outside the enumeration range also provoke warnings when this option
#       is used (even if there is a default label). This warning is enabled by
#       -Wall.
#
# INFO: -Wswitch-default
#       Warn whenever a switch statement does not have a default case.
#
# INFO: -Wswitch-enum
#       Warn whenever a switch statement has an index of enumerated type and
#       lacks a case for one or more of the named codes of that enumeration.
#       case labels outside the enumeration range also provoke warnings when
#       this option is used. The only difference between -Wswitch and this
#       option is that this option gives a warning about an omitted enumeration
#       code even if there is a default label.
#
# INFO: -Wswitch-bool
#       Warn whenever a switch statement has an index of boolean type. It is
#       possible to suppress this warning by casting the controlling expression
#       to a type other than bool. For example:
#
#              switch ((int) (a == 4))
#                {
#                ...
#                }
#
# INFO: This warning is enabled by default for C and C++ programs.
#
# INFO: -Wsync-nand (C and C++ only)
#       Warn when __sync_fetch_and_nand and __sync_nand_and_fetch built-in
#       functions are used. These functions changed semantics in GCC 4.4.
#
# INFO: -Wtrigraphs
#       Warn if any trigraphs are encountered that might change the meaning of
#       the program (trigraphs within comments are not warned about). This
#       warning is enabled by -Wall.
#
# INFO: -Wunused-but-set-parameter
#       Warn whenever a function parameter is assigned to, but otherwise unused
#       (aside from its declaration).
#
#       To suppress this warning use the unused attribute (see Variable
#       Attributes).
#
#       This warning is also enabled by -Wunused together with -Wextra.
#
# INFO: -Wunused-but-set-variable
#       Warn whenever a local variable is assigned to, but otherwise unused
#       (aside from its declaration).
#
# INFO: This warning is enabled by -Wall.
#
#       To suppress this warning use the unused attribute (see Variable
#       Attributes).
#
#       This warning is also enabled by -Wunused, which is enabled by -Wall.
#
# INFO: -Wunused-function
#       Warn whenever a static function is declared but not defined or a
#       non-inline static function is unused.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wunused-label
#       Warn whenever a label is declared but not used. This warning is enabled
#       by -Wall.
#
#       To suppress this warning use the unused attribute (see Variable
#       Attributes).
#
# INFO: -Wunused-local-typedefs (C, Objective-C, C++ and Objective-C++ only)
#       Warn when a typedef locally defined in a function is not used. This
#       warning is enabled by -Wall.
#
# INFO: -Wunused-parameter
#       Warn whenever a function parameter is unused aside from its
#       declaration.
#
#       To suppress this warning use the unused attribute (see Variable
#       Attributes).
#
# INFO: -Wno-unused-result
#       Do not warn if a caller of a function marked with attribute
#       warn_unused_result (see Function Attributes) does not use its return
#       value. The default is -Wunused-result.
#
# INFO: -Wunused-variable
#       Warn whenever a local variable or non-constant static variable is
#       unused aside from its declaration.
#
# INFO: This warning is enabled by -Wall.
#
#       To suppress this warning use the unused attribute (see Variable
#       Attributes).
#
# INFO: -Wunused-value
#       Warn whenever a statement computes a result that is explicitly not
#       used. To suppress this warning cast the unused expression to void. This
#       includes an expression-statement or the left-hand side of a comma
#       expression that contains no side effects. For example, an expression
#       such as x[i,j] causes a warning, while x[(void)i,j] does not.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wunused
#       All the above -Wunused options combined.
#
#       In order to get a warning about an unused function parameter, you must
#       either specify -Wextra -Wunused (note that -Wall implies -Wunused), or
#       separately specify -Wunused-parameter.
#
# INFO: -Wuninitialized
#       Warn if an automatic variable is used without first being initialized
#       or if a variable may be clobbered by a setjmp call. In C++, warn if a
#       non-static reference or non-static const member appears in a class
#       without constructors.
#
#       If you want to warn about code that uses the uninitialized value of the
#       variable in its own initializer, use the -Winit-self option.
#
#       These warnings occur for individual uninitialized or clobbered elements
#       of structure, union or array variables as well as for variables that
#       are uninitialized or clobbered as a whole. They do not occur for
#       variables or elements declared volatile. Because these warnings depend
#       on optimization, the exact variables or elements for which there are
#       warnings depends on the precise optimization options and version of GCC
#       used.
#
#       Note that there may be no warning about a variable that is used only to
#       compute a value that itself is never used, because such computations
#       may be deleted by data flow analysis before the warnings are printed.
#
# INFO: -Wmaybe-uninitialized
#       For an automatic variable, if there exists a path from the function
#       entry to a use of the variable that is initialized, but there exist
#       some other paths for which the variable is not initialized, the
#       compiler emits a warning if it cannot prove the uninitialized paths
#       are not executed at run time. These warnings are made optional because
#       GCC is not smart enough to see all the reasons why the code might be
#       correct in spite of appearing to have an error. Here is one example of
#       how this can happen:
#
#              {
#                int x;
#                switch (y)
#                  {
#                  case 1: x = 1;
#                    break;
#                  case 2: x = 4;
#                    break;
#                  case 3: x = 5;
#                  }
#                foo (x);
#              }
#
#       If the value of y is always 1, 2 or 3, then x is always initialized,
#       but GCC doesn't know this. To suppress the warning, you need to provide
#       a default case with assert(0) or similar code.
#
#       This option also warns when a non-volatile automatic variable might be
#       changed by a call to longjmp. These warnings as well are possible only
#       in optimizing compilation.
#
#       The compiler sees only the calls to setjmp. It cannot know where
#       longjmp will be called; in fact, a signal handler could call it at any
#       point in the code. As a result, you may get a warning even when there
#       is in fact no problem because longjmp cannot in fact be called at the
#       place that would cause a problem.
#
#       Some spurious warnings can be avoided if you declare all the functions
#       you use that never return as noreturn. See Function Attributes.
#
# INFO: This warning is enabled by -Wall or -Wextra.
#
# INFO: -Wunknown-pragmas
#       Warn when a #pragma directive is encountered that is not understood by
#       GCC. If this command-line option is used, warnings are even issued for
#       unknown pragmas in system header files. This is not the case if the
#       warnings are only enabled by the -Wall command-line option.
#
# INFO: -Wno-pragmas
#       Do not warn about misuses of pragmas, such as incorrect parameters,
#       invalid syntax, or conflicts between pragmas. See also
#       -Wunknown-pragmas.
#
# INFO: -Wstrict-aliasing
#       This option is only active when -fstrict-aliasing is active. It warns
#       about code that might break the strict aliasing rules that the compiler
#       is using for optimization. The warning does not catch all cases, but
#       does attempt to catch the more common pitfalls. It is included in
#       -Wall. It is equivalent to -Wstrict-aliasing=3 
#
# INFO: -Wstrict-aliasing=n
#       This option is only active when -fstrict-aliasing is active. It warns
#       about code that might break the strict aliasing rules that the compiler
#       is using for optimization. Higher levels correspond to higher accuracy
#       (fewer false positives). Higher levels also correspond to more effort,
#       similar to the way -O works. -Wstrict-aliasing is equivalent to
#       -Wstrict-aliasing=3.
#
#       * Level 1 - Most aggressive, quick, least accurate. Possibly useful
#                   when higher levels do not warn but -fstrict-aliasing still
#                   breaks the code, as it has very few false negatives.
#                   However, it has many false positives. Warns for all pointer
#                   conversions between possibly incompatible types, even if
#                   never dereferenced. Runs in the front end only.
#
#       * Level 2 - Aggressive, quick, not too precise. May still have many
#                   false positives (not as many as level 1 though), and few
#                   false negatives (but possibly more than level 1). Unlike
#                   level 1, it only warns when an address is taken. Warns
#                   about incomplete types. Runs in the front end only.
#
#       * Level 3 - (default for -Wstrict-aliasing): Should have very few false
#                   positives and few false negatives. Slightly slower than
#                   levels 1 or 2 when optimization is enabled. Takes care of
#                   the common pun+dereference pattern in the front end:
#                   *(int*)&some_float. If optimization is enabled, it also
#                   runs in the back end, where it deals with multiple
#                   statement cases using flow-sensitive points-to information.
#                   Only warns when the converted pointer is dereferenced. Does
#                   not warn about incomplete types.
#
# INFO: -Wstrict-overflow
# INFO: -Wstrict-overflow=n
#       This option is only active when -fstrict-overflow is active. It warns
#       about cases where the compiler optimizes based on the assumption that
#       signed overflow does not occur. Note that it does not warn about all
#       cases where the code might overflow: it only warns about cases where
#       the compiler implements some optimization. Thus this warning depends on
#       the optimization level.
#
#       An optimization that assumes that signed overflow does not occur is
#       perfectly safe if the values of the variables involved are such that
#       overflow never does, in fact, occur. Therefore this warning can easily
#       give a false positive: a warning about code that is not actually a
#       problem. To help focus on important issues, several warning levels are
#       defined. No warnings are issued for the use of undefined signed
#       overflow when estimating how many iterations a loop requires, in
#       particular when determining whether a loop will be executed at all.
#
#              -Wstrict-overflow=1
#              Warn about cases that are both questionable and easy to avoid.
#              For example, with -fstrict-overflow, the compiler simplifies x +
#              1 > x to 1. This level of -Wstrict-overflow is enabled by -Wall;
#              higher levels are not, and must be explicitly requested.
#
#              -Wstrict-overflow=2
#              Also warn about other cases where a comparison is simplified to
#              a constant. For example: abs (x) >= 0. This can only be
#              simplified when -fstrict-overflow is in effect, because abs
#              (INT_MIN) overflows to INT_MIN, which is less than zero.
#              -Wstrict-overflow (with no level) is the same as
#              -Wstrict-overflow=2.
#
#              -Wstrict-overflow=3
#              Also warn about other cases where a comparison is simplified.
#              For example: x + 1 > 1 is simplified to x > 0.
#
#              -Wstrict-overflow=4
#              Also warn about other simplifications not covered by the above
#              cases. For example: (x * 10) / 5 is simplified to x * 2.
#
#              -Wstrict-overflow=5
#              Also warn about cases where the compiler reduces the magnitude
#              of a constant involved in a comparison. For example: x + 2 > y
#              is simplified to x + 1 >= y. This is reported only at the
#              highest warning level because this simplification applies to
#              many comparisons, so this warning level gives a very large
#              number of false positives.
#
# INFO: -Wsuggest-attribute=[pure|const|noreturn|format]
#       Warn for cases where adding an attribute may be beneficial. The
#       attributes currently supported are listed below.
#
#              -Wsuggest-attribute=pure
#              -Wsuggest-attribute=const
#              -Wsuggest-attribute=noreturn
#              Warn about functions that might be candidates for attributes
#              pure, const or noreturn. The compiler only warns for functions
#              visible in other compilation units or (in the case of pure and
#              const) if it cannot prove that the function returns normally. A
#              function returns normally if it doesn't contain an infinite loop
#              or return abnormally by throwing, calling abort or trapping.
#              This analysis requires option -fipa-pure-const, which is enabled
#              by default at -O and higher. Higher optimization levels improve
#              the accuracy of the analysis.
#
#              -Wsuggest-attribute=format
#              -Wmissing-format-attribute
#              Warn about function pointers that might be candidates for format
#              attributes. Note these are only possible candidates, not
#              absolute ones. GCC guesses that function pointers with format
#              attributes that are used in assignment, initialization,
#              parameter passing or return statements should have a
#              corresponding format attribute in the resulting type. I.e. the
#              left-hand side of the assignment or initialization, the type of
#              the parameter variable, or the return type of the containing
#              function respectively should also have a format attribute to
#              avoid the warning.
#
#              GCC also warns about function definitions that might be
#              candidates for format attributes. Again, these are only possible
#              candidates. GCC guesses that format attributes might be
#              appropriate for any function that calls a function like vprintf
#              or vscanf, but this might not always be the case, and some
#              functions for which format attributes are appropriate may not be
#              detected.
#
# INFO: -Wsuggest-final-types
#       Warn about types with virtual methods where code quality would be
#       improved if the type were declared with the C++11 final specifier, or,
#       if possible, declared in an anonymous namespace. This allows GCC to
#       more aggressively devirtualize the polymorphic calls. This warning is
#       more effective with link time optimization, where the information about
#       the class hierarchy graph is more complete.
#
# INFO: -Wsuggest-final-methods
#       Warn about virtual methods where code quality would be improved if the
#       method were declared with the C++11 final specifier, or, if possible,
#       its type were declared in an anonymous namespace or with the final
#       specifier. This warning is more effective with link time optimization,
#       where the information about the class hierarchy graph is more complete.
#       It is recommended to first consider suggestions of
#       -Wsuggest-final-types and then rebuild with new annotations.
#
# INFO: -Wsuggest-override
#       Warn about overriding virtual functions that are not marked with the
#       override keyword.
#
# INFO: -Warray-bounds
# INFO: -Warray-bounds=n
#       This option is only active when -ftree-vrp is active (default for -O2
#       and above). It warns about subscripts to arrays that are always out of
#       bounds.
#
# INFO: This warning is enabled by -Wall.
#
#              -Warray-bounds=1
#              This is the warning level of -Warray-bounds and is enabled by
#              -Wall; higher levels are not, and must be explicitly requested.
#
#              -Warray-bounds=2
#              This warning level also warns about out of bounds access for
#              arrays at the end of a struct and for arrays accessed through
#              pointers. This warning level may give a larger number of false
#              positives and is deactivated by default.
#
# INFO: -Wbool-compare
#       Warn about boolean expression compared with an integer value different
#       from true/false. For instance, the following comparison is always
#       false:
#
#              int n = 5;
#              ...
#              if ((n > 1) == 2) { ... }
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wno-discarded-qualifiers (C and Objective-C only)
#       Do not warn if type qualifiers on pointers are being discarded.
#       Typically, the compiler warns if a const char * variable is passed to a
#       function that takes a char * parameter. This option can be used to
#       suppress such a warning.
#
# INFO: -Wno-discarded-array-qualifiers (C and Objective-C only)
#       Do not warn if type qualifiers on arrays which are pointer targets are
#       being discarded. Typically, the compiler warns if a const int (*)[]
#       variable is passed to a function that takes a int (*)[] parameter. This
#       option can be used to suppress such a warning.
#
# INFO: -Wno-incompatible-pointer-types (C and Objective-C only)
#       Do not warn when there is a conversion between pointers that have
#       incompatible types. This warning is for cases not covered by
#       -Wno-pointer-sign, which warns for pointer argument passing or
#       assignment with different signedness.
#
# INFO: -Wno-int-conversion (C and Objective-C only)
#       Do not warn about incompatible integer to pointer and pointer to
#       integer conversions. This warning is about implicit conversions; for
#       explicit conversions the warnings -Wno-int-to-pointer-cast and
#       -Wno-pointer-to-int-cast may be used.
#
# INFO: -Wno-div-by-zero
#       Do not warn about compile-time integer division by zero. Floating-point
#       division by zero is not warned about, as it can be a legitimate way of
#       obtaining infinities and NaNs.
#
# INFO: -Wsystem-headers
#       Print warning messages for constructs found in system header files.
#       Warnings from system headers are normally suppressed, on the assumption
#       that they usually do not indicate real problems and would only make the
#       compiler output harder to read. Using this command-line option tells
#       GCC to emit warnings from system headers as if they occurred in user
#       code. However, note that using -Wall in conjunction with this option
#       does not warn about unknown pragmas in system headers—for that,
#       -Wunknown-pragmas must also be used.
#
# INFO: -Wtrampolines
#       Warn about trampolines generated for pointers to nested functions. A
#       trampoline is a small piece of data or code that is created at run time
#       on the stack when the address of a nested function is taken, and is
#       used to call the nested function indirectly. For some targets, it is
#       made up of data only and thus requires no special treatment. But, for
#       most targets, it is made up of code and thus requires the stack to be
#       made executable in order for the program to work properly.
#
# INFO: -Wfloat-equal
#       Warn if floating-point values are used in equality comparisons.
#
#       The idea behind this is that sometimes it is convenient (for the
#       programmer) to consider floating-point values as approximations to
#       infinitely precise real numbers. If you are doing this, then you need
#       to compute (by analyzing the code, or in some other way) the maximum or
#       likely maximum error that the computation introduces, and allow for it
#       when performing comparisons (and when producing output, but that's a
#       different problem). In particular, instead of testing for equality, you
#       should check to see whether the two values have ranges that overlap;
#       and this is done with the relational operators, so equality comparisons
#       are probably mistaken.
#
# INFO: -Wtraditional (C and Objective-C only)
#       Warn about certain constructs that behave differently in traditional
#       and ISO C. Also warn about ISO C constructs that have no traditional C
#       equivalent, and/or problematic constructs that should be avoided.
#
#              * Macro parameters that appear within string literals in the
#                macro body. In traditional C macro replacement takes place
#                within string literals, but in ISO C it does not.
#              * In traditional C, some preprocessor directives did not exist.
#                Traditional preprocessors only considered a line to be a
#                directive if the ‘#’ appeared in column 1 on the line.
#                Therefore -Wtraditional warns about directives that
#                traditional C understands but ignores because the ‘#’ does not
#                appear as the first character on the line. It also suggests
#                you hide directives like #pragma not understood by traditional
#                C by indenting them. Some traditional implementations do not
#                recognize #elif, so this option suggests avoiding it
#                altogether.
#              * A function-like macro that appears without arguments.
#              * The unary plus operator.
#              * The ‘U’ integer constant suffix, or the ‘F’ or ‘L’
#                floating-point constant suffixes. (Traditional C does support
#                the ‘L’ suffix on integer constants.) Note, these suffixes
#                appear in macros defined in the system headers of most modern
#                systems, e.g. the ‘_MIN’/‘_MAX’ macros in <limits.h>. Use of
#                these macros in user code might normally lead to spurious
#                warnings, however GCC's integrated preprocessor has enough
#                context to avoid warning in these cases.
#              * A function declared external in one block and then used after
#                the end of the block.
#              * A switch statement has an operand of type long.
#              * A non-static function declaration follows a static one. This
#                construct is not accepted by some traditional C compilers.
#              * The ISO type of an integer constant has a different width or
#                signedness from its traditional type. This warning is only
#                issued if the base of the constant is ten. I.e. hexadecimal or
#                octal values, which typically represent bit patterns, are not
#                warned about.
#              * Usage of ISO string concatenation is detected.
#              * Initialization of automatic aggregates.
#              * Identifier conflicts with labels. Traditional C lacks a
#                separate namespace for labels.
#              * Initialization of unions. If the initializer is zero, the
#                warning is omitted. This is done under the assumption that the
#                zero initializer in user code appears conditioned on e.g.
#                __STDC__ to avoid missing initializer warnings and relies on
#                default initialization to zero in the traditional C case.
#              * Conversions by prototypes between fixed/floating-point values
#                and vice versa. The absence of these prototypes when compiling
#                with traditional C causes serious problems. This is a subset
#                of the possible conversion warnings; for the full set use
#                -Wtraditional-conversion.
#              * Use of ISO C style function definitions. This warning
#                intentionally is not issued for prototype declarations or
#                variadic functions because these ISO C features appear in your
#                code when using libiberty's traditional C compatibility
#                macros, PARAMS and VPARAMS. This warning is also bypassed for
#                nested functions because that feature is already a GCC
#                extension and thus not relevant to traditional C
#                compatibility.
#
# INFO: -Wtraditional-conversion (C and Objective-C only)
#       Warn if a prototype causes a type conversion that is different from
#       what would happen to the same argument in the absence of a prototype.
#       This includes conversions of fixed point to floating and vice versa,
#       and conversions changing the width or signedness of a fixed-point
#       argument except when the same as the default promotion.
#
# INFO: -Wdeclaration-after-statement (C and Objective-C only)
#       Warn when a declaration is found after a statement in a block. This
#       construct, known from C++, was introduced with ISO C99 and is by
#       default allowed in GCC. It is not supported by ISO C90. See Mixed
#       Declarations.
#
# INFO: -Wundef
#       Warn if an undefined identifier is evaluated in an #if directive.
#
# INFO: -Wno-endif-labels
#       Do not warn whenever an #else or an #endif are followed by text.
#
# INFO: -Wshadow
#       Warn whenever a local variable or type declaration shadows another
#       variable, parameter, type, class member (in C++), or instance variable
#       (in Objective-C) or whenever a built-in function is shadowed. Note that
#       in C++, the compiler warns if a local variable shadows an explicit
#       typedef, but not if it shadows a struct/class/enum.
#
# INFO: -Wno-shadow-ivar (Objective-C only)
#       Do not warn whenever a local variable shadows an instance variable in
#       an Objective-C method.
#
# INFO: -Wlarger-than=len
#       Warn whenever an object of larger than len bytes is defined.
#
# INFO: -Wframe-larger-than=len
#       Warn if the size of a function frame is larger than len bytes. The
#       computation done to determine the stack frame size is approximate and
#       not conservative. The actual requirements may be somewhat greater than
#       len even if you do not get a warning. In addition, any space allocated
#       via alloca, variable-length arrays, or related constructs is not
#       included by the compiler when determining whether or not to issue a
#       warning.
#
# INFO: -Wno-free-nonheap-object
#       Do not warn when attempting to free an object that was not allocated on
#       the heap.
#
# INFO: -Wstack-usage=len
#       Warn if the stack usage of a function might be larger than len bytes.
#       The computation done to determine the stack usage is conservative. Any
#       space allocated via alloca, variable-length arrays, or related
#       constructs is included by the compiler when determining whether or not
#       to issue a warning.
#
#       The message is in keeping with the output of -fstack-usage.
#
#              * If the stack usage is fully static but exceeds the specified
#                amount, it's:
#                       warning: stack usage is 1120 bytes
#              * If the stack usage is (partly) dynamic but bounded, it's:
#                       warning: stack usage might be 1648 bytes
#              * If the stack usage is (partly) dynamic and not bounded, it's:
#                       warning: stack usage might be unbounded
#
# INFO: -Wunsafe-loop-optimizations
#       Warn if the loop cannot be optimized because the compiler cannot assume
#       anything on the bounds of the loop indices. With
#       -funsafe-loop-optimizations warn if the compiler makes such
#       assumptions.
#
# INFO: -Wno-pedantic-ms-format (MinGW targets only)
#       When used in combination with -Wformat and -pedantic without GNU
#       extensions, this option disables the warnings about non-ISO printf /
#       scanf format width specifiers I32, I64, and I used on Windows targets,
#       which depend on the MS runtime.
#
# INFO: -Wpointer-arith
#       Warn about anything that depends on the “size of” a function type or of
#       void. GNU C assigns these types a size of 1, for convenience in
#       calculations with void * pointers and pointers to functions. In C++,
#       warn also when an arithmetic operation involves NULL. This warning is
#       also enabled by -Wpedantic.
#
# INFO: -Wtype-limits
#       Warn if a comparison is always true or always false due to the limited
#       range of the data type, but do not warn for constant expressions. For
#       example, warn if an unsigned variable is compared against zero with <
#       or >=. This warning is also enabled by -Wextra.
#
# INFO: -Wbad-function-cast (C and Objective-C only)
#       Warn when a function call is cast to a non-matching type. For example,
#       warn if a call to a function returning an integer type is cast to a
#       pointer type.
#
# INFO: -Wc90-c99-compat (C and Objective-C only)
#       Warn about features not present in ISO C90, but present in ISO C99. For
#       instance, warn about use of variable length arrays, long long type,
#       bool type, compound literals, designated initializers, and so on. This
#       option is independent of the standards mode. Warnings are disabled in
#       the expression that follows __extension__.
#
# INFO: -Wc99-c11-compat (C and Objective-C only)
#       Warn about features not present in ISO C99, but present in ISO C11. For
#       instance, warn about use of anonymous structures and unions, _Atomic
#       type qualifier, _Thread_local storage-class specifier, _Alignas
#       specifier, Alignof operator, _Generic keyword, and so on. This option
#       is independent of the standards mode. Warnings are disabled in the
#       expression that follows __extension__.
#
# INFO: -Wc++-compat (C and Objective-C only)
#       Warn about ISO C constructs that are outside of the common subset of
#       ISO C and ISO C++, e.g. request for implicit conversion from void * to
#       a pointer to non-void type.
#
# INFO: -Wc++11-compat (C++ and Objective-C++ only)
#       Warn about C++ constructs whose meaning differs between ISO C++ 1998
#       and ISO C++ 2011, e.g., identifiers in ISO C++ 1998 that are keywords
#       in ISO C++ 2011. This warning turns on -Wnarrowing and is enabled by
#       -Wall.
#
# INFO: -Wc++14-compat (C++ and Objective-C++ only)
#       Warn about C++ constructs whose meaning differs between ISO C++ 2011
#       and ISO C++ 2014.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wcast-qual
#       Warn whenever a pointer is cast so as to remove a type qualifier from
#       the target type. For example, warn if a const char * is cast to an
#       ordinary char *.
#
#       Also warn when making a cast that introduces a type qualifier in an
#       unsafe way. For example, casting char ** to const char ** is unsafe,
#       as in this example:
#
#                /* p is char ** value.  */
#                const char **q = (const char **) p;
#                /* Assignment of readonly string to const char * is OK.  */
#                *q = "string";
#                /* Now char** pointer points to read-only memory.  */
#                **p = 'b';
#
# INFO: -Wcast-align
#       Warn whenever a pointer is cast such that the required alignment of the
#       target is increased. For example, warn if a char * is cast to
#       an int * on machines where integers can only be accessed at two- or
#       four-byte boundaries.
#
# INFO: -Wwrite-strings
#       When compiling C, give string constants the type const char[length] so
#       that copying the address of one into a non-const char * pointer
#       produces a warning. These warnings help you find at compile time code
#       that can try to write into a string constant, but only if you have been
#       very careful about using const in declarations and prototypes.
#       Otherwise, it is just a nuisance. This is why we did not make -Wall
#       request these warnings.
#
#       When compiling C++, warn about the deprecated conversion from string
#       literals to char *.
#
# TODO: This warning is enabled by default for C++ programs.
#
# INFO: -Wclobbered
#       Warn for variables that might be changed by longjmp or vfork. This
#       warning is also enabled by -Wextra.
#
# INFO: -Wconditionally-supported (C++ and Objective-C++ only)
#       Warn for conditionally-supported (C++11 [intro.defs]) constructs.
#
# INFO: -Wconversion
#       Warn for implicit conversions that may alter a value. This includes
#       conversions between real and integer, like abs (x) when x is double;
#       conversions between signed and unsigned, like unsigned ui = -1; and
#       conversions to smaller types, like sqrtf (M_PI). Do not warn for
#       explicit casts like abs ((int) x) and ui = (unsigned) -1, or if the
#       value is not changed by the conversion like in abs (2.0). Warnings
#       about conversions between signed and unsigned integers can be disabled
#       by using -Wno-sign-conversion.
#
#       For C++, also warn for confusing overload resolution for user-defined
#       conversions; and conversions that never use a type conversion operator:
#       conversions to void, the same type, a base class or a reference to
#       them. Warnings about conversions between signed and unsigned integers
#       are disabled by default in C++ unless -Wsign-conversion is explicitly
#       enabled.
#
# INFO: -Wno-conversion-null (C++ and Objective-C++ only)
#       Do not warn for conversions between NULL and non-pointer types.
#       -Wconversion-null is enabled by default.
#
# INFO: -Wzero-as-null-pointer-constant (C++ and Objective-C++ only)
#       Warn when a literal '0' is used as null pointer constant. This can be
#       useful to facilitate the conversion to nullptr in C++11.
#
# INFO: -Wdate-time
#       Warn when macros __TIME__, __DATE__ or __TIMESTAMP__ are encountered as
#       they might prevent bit-wise-identical reproducible compilations.
#
# INFO: -Wdelete-incomplete (C++ and Objective-C++ only)
#       Warn when deleting a pointer to incomplete type, which may cause
#       undefined behavior at runtime.
#
# INFO: This warning is enabled by default.
#
# INFO: -Wuseless-cast (C++ and Objective-C++ only)
#       Warn when an expression is casted to its own type.
#
# INFO: -Wempty-body
#       Warn if an empty body occurs in an if, else or do while statement.
#       This warning is also enabled by -Wextra.
#
# INFO: -Wenum-compare
#       Warn about a comparison between values of different enumerated types.
#       In C++ enumeral mismatches in conditional expressions are also
#       diagnosed and the warning is enabled by default. In C this warning is
#       enabled by -Wall.
#
# INFO: -Wjump-misses-init (C, Objective-C only)
#       Warn if a goto statement or a switch statement jumps forward across the
#       initialization of a variable, or jumps backward to a label after the
#       variable has been initialized. This only warns about variables that are
#       initialized when they are declared. This warning is only supported for
#       C and Objective-C; in C++ this sort of branch is an error in any case.
#
#       -Wjump-misses-init is included in -Wc++-compat. It can be disabled with
#       the -Wno-jump-misses-init option.
#
# INFO: -Wsign-compare
#       Warn when a comparison between signed and unsigned values could produce
#       an incorrect result when the signed value is converted to unsigned.
#       This warning is also enabled by -Wextra; to get the other warnings of
#       -Wextra without this warning, use -Wextra -Wno-sign-compare.
#
# INFO: -Wsign-conversion
#       Warn for implicit conversions that may change the sign of an integer
#       value, like assigning a signed integer expression to an unsigned
#       integer variable. An explicit cast silences the warning. In C, this
#       option is enabled also by -Wconversion.
#
# INFO: -Wfloat-conversion
#       Warn for implicit conversions that reduce the precision of a real
#       value. This includes conversions from real to integer, and from higher
#       precision real to lower precision real values. This option is also
#       enabled by -Wconversion.
#
# INFO: -Wsized-deallocation (C++ and Objective-C++ only)
#       Warn about a definition of an unsized deallocation function
#
#              void operator delete (void *) noexcept;
#              void operator delete[] (void *) noexcept;
#
#       without a definition of the corresponding sized deallocation function
#
#              void operator delete (void *, std::size_t) noexcept;
#              void operator delete[] (void *, std::size_t) noexcept;
#
#       or vice versa. Enabled by -Wextra along with -fsized-deallocation.
#
# INFO: -Wsizeof-pointer-memaccess
#       Warn for suspicious length parameters to certain string and memory
#       built-in functions if the argument uses sizeof. This warning warns e.g.
#       about memset (ptr, 0, sizeof (ptr)); if ptr is not an array, but a
#       pointer, and suggests a possible fix, or about memcpy (&foo, ptr,
#       sizeof (&foo));.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wsizeof-array-argument
#       Warn when the sizeof operator is applied to a parameter that is
#       declared as an array in a function definition. This warning is enabled
#       by default for C and C++ programs.
#
# INFO: -Wmemset-transposed-args
#       Warn for suspicious calls to the memset built-in function, if the
#       second argument is not zero and the third argument is zero. This warns
#       e.g. about memset (buf, sizeof buf, 0) where most probably memset (buf,
#       0, sizeof buf) was meant instead. The diagnostics is only emitted if
#       the third argument is literal zero, if it is some expression that is
#       folded to zero, or e.g. a cast of zero to some type etc., it is far
#       less likely that user has mistakenly exchanged the arguments and no
#       warning is emitted.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Waddress
#       Warn about suspicious uses of memory addresses. These include using the
#       address of a function in a conditional expression, such as void
#       func(void); if (func), and comparisons against the memory address of a
#       string literal, such as if (x == "abc"). Such uses typically indicate a
#       programmer error: the address of a function always evaluates to true,
#       so their use in a conditional usually indicate that the programmer
#       forgot the parentheses in a function call; and comparisons against
#       string literals result in unspecified behavior and are not portable in
#       C, so they usually indicate that the programmer intended to use strcmp.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wlogical-op
#       Warn about suspicious uses of logical operators in expressions. This
#       includes using logical operators in contexts where a bit-wise operator
#       is likely to be expected.
#
# INFO: -Wlogical-not-parentheses
#       Warn about logical not used on the left hand side operand of a
#       comparison. This option does not warn if the RHS operand is of a
#       boolean type. Its purpose is to detect suspicious code like the
#       following:
#
#              int a;
#              ...
#              if (!a > 1) { ... }
#
#       It is possible to suppress the warning by wrapping the LHS into
#       parentheses:
#
#              if ((!a) > 1) { ... }
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Waggregate-return
#       Warn if any functions that return structures or unions are defined or
#       called. (In languages where you can return an array, this also elicits
#       a warning.) 
#
# INFO: -Wno-aggressive-loop-optimizations
#       Warn if in a loop with constant number of iterations the compiler
#       detects undefined behavior in some statement during one or more of the
#       iterations.
#
# INFO: -Wno-attributes
#       Do not warn if an unexpected __attribute__ is used, such as
#       unrecognized attributes, function attributes applied to variables, etc.
#       This does not stop errors for incorrect use of supported attributes.
#
# INFO: -Wno-builtin-macro-redefined
#       Do not warn if certain built-in macros are redefined. This suppresses
#       warnings for redefinition of __TIMESTAMP__, __TIME__, __DATE__,
#       __FILE__, and __BASE_FILE__.
#
# INFO: -Wstrict-prototypes (C and Objective-C only)
#       Warn if a function is declared or defined without specifying the
#       argument types. (An old-style function definition is permitted without
#       a warning if preceded by a declaration that specifies the argument
#       types.) 
#
# INFO: -Wold-style-declaration (C and Objective-C only)
#       Warn for obsolescent usages, according to the C Standard, in a
#       declaration. For example, warn if storage-class specifiers like static
#       are not the first things in a declaration. This warning is also enabled
#       by -Wextra.
#
# INFO: -Wold-style-definition (C and Objective-C only)
#       Warn if an old-style function definition is used. A warning is given
#       even if there is a previous prototype.
#
# INFO: -Wmissing-parameter-type (C and Objective-C only)
#       A function parameter is declared without a type specifier in K&R-style
#       functions:
#
#              void foo(bar) { }
#
#       This warning is also enabled by -Wextra.
#
# INFO: -Wmissing-prototypes (C and Objective-C only)
#       Warn if a global function is defined without a previous prototype
#       declaration. This warning is issued even if the definition itself
#       provides a prototype. Use this option to detect global functions that
#       do not have a matching prototype declaration in a header file. This
#       option is not valid for C++ because all function declarations provide
#       prototypes and a non-matching declaration declares an overload rather
#       than conflict with an earlier declaration. Use -Wmissing-declarations
#       to detect missing declarations in C++.
#
# INFO: -Wmissing-declarations
#       Warn if a global function is defined without a previous declaration. Do
#       so even if the definition itself provides a prototype. Use this option
#       to detect global functions that are not declared in header files. In C,
#       no warnings are issued for functions with previous non-prototype
#       declarations; use -Wmissing-prototypes to detect missing prototypes. In
#       C++, no warnings are issued for function templates, or for inline
#       functions, or for functions in anonymous namespaces.
#
# INFO: -Wmissing-field-initializers
#       Warn if a structure's initializer has some fields missing. For example,
#       the following code causes such a warning, because x.h is implicitly
#       zero:
#
#              struct s { int f, g, h; };
#              struct s x = { 3, 4 };
#
#       This option does not warn about designated initializers, so the
#       following modification does not trigger a warning:
#
#              struct s { int f, g, h; };
#              struct s x = { .f = 3, .g = 4 };
#
#       In C++ this option does not warn either about the empty { }
#       initializer, for example:
#
#              struct s { int f, g, h; };
#              s x = { };
#
#       This warning is included in -Wextra. To get other -Wextra warnings
#       without this one, use -Wextra -Wno-missing-field-initializers.

FLAGS_COMPILER_WARNINGS+=		-Wno-missing-field-initializers

# INFO: -Wno-multichar
#       Do not warn if a multicharacter constant (‘'FOOF'’) is used. Usually
#       they indicate a typo in the user's code, as they have
#       implementation-defined values, and should not be used in portable code.
#
# INFO: -Wnormalized[=<none|id|nfc|nfkc>]
#       In ISO C and ISO C++, two identifiers are different if they are
#       different sequences of characters. However, sometimes when characters
#       outside the basic ASCII character set are used, you can have two
#       different character sequences that look the same. To avoid confusion,
#       the ISO 10646 standard sets out some normalization rules which when
#       applied ensure that two sequences that look the same are turned into
#       the same sequence. GCC can warn you if you are using identifiers that
#       have not been normalized; this option controls that warning.
#
#       There are four levels of warning supported by GCC. The default is
#       -Wnormalized=nfc, which warns about any identifier that is not in the
#       ISO 10646 “C” normalized form, NFC. NFC is the recommended form for
#       most uses. It is equivalent to -Wnormalized.
#
#       Unfortunately, there are some characters allowed in identifiers by ISO
#       C and ISO C++ that, when turned into NFC, are not allowed in
#       identifiers. That is, there's no way to use these symbols in portable
#       ISO C or C++ and have all your identifiers in NFC. -Wnormalized=id
#       suppresses the warning for these characters. It is hoped that future
#       versions of the standards involved will correct this, which is why this
#       option is not the default.
#
#       You can switch the warning off for all characters by writing
#       -Wnormalized=none or -Wno-normalized. You should only do this if you
#       are using some other normalization scheme (like “D”), because otherwise
#       you can easily create bugs that are literally impossible to see.
#
#       Some characters in ISO 10646 have distinct meanings but look identical
#       in some fonts or display methodologies, especially once formatting has
#       been applied. For instance \u207F, “SUPERSCRIPT LATIN SMALL LETTER N”,
#       displays just like a regular n that has been placed in a superscript.
#       ISO 10646 defines the NFKC normalization scheme to convert all these
#       into a standard form as well, and GCC warns if your code is not in NFKC
#       if you use -Wnormalized=nfkc. This warning is comparable to warning
#       about every identifier that contains the letter O because it might be
#       confused with the digit 0, and so is not the default, but may be useful
#       as a local coding convention if the programming environment cannot be
#       fixed to display these characters distinctly.
#
# INFO: -Wno-deprecated
#       Do not warn about usage of deprecated features. See Deprecated
#       Features.
#
# INFO: -Wno-deprecated-declarations
#       Do not warn about uses of functions (see Function Attributes),
#       variables (see Variable Attributes), and types (see Type Attributes)
#       marked as deprecated by using the deprecated attribute.
#
# INFO: -Wno-overflow
#       Do not warn about compile-time overflow in constant expressions.
#
# INFO: -Wno-odr
#       Warn about One Definition Rule violations during link-time
#       optimization. Requires -flto-odr-type-merging to be enabled. Enabled by
#       default.
#
# INFO: -Wopenmp-simd
#       Warn if the vectorizer cost model overrides the OpenMP or the Cilk Plus
#       simd directive set by user. The -fsimd-cost-model=unlimited option can
#       be used to relax the cost model.
#
# INFO: -Woverride-init (C and Objective-C only)
#       Warn if an initialized field without side effects is overridden when
#       using designated initializers (see Designated Initializers).
#
#       This warning is included in -Wextra. To get other -Wextra warnings
#       without this one, use -Wextra -Wno-override-init.
#
# INFO: -Wpacked
#       Warn if a structure is given the packed attribute, but the packed
#       attribute has no effect on the layout or size of the structure. Such
#       structures may be mis-aligned for little benefit. For instance, in this
#       code, the variable f.x in struct bar is misaligned even though struct
#       bar does not itself have the packed attribute:
#
#              struct foo {
#                int x;
#                char a, b, c, d;
#              } __attribute__((packed));
#              struct bar {
#                char z;
#                struct foo f;
#              };
#
# INFO: -Wpacked-bitfield-compat
#       The 4.1, 4.2 and 4.3 series of GCC ignore the packed attribute on
#       bit-fields of type char. This has been fixed in GCC 4.4 but the change
#       can lead to differences in the structure layout. GCC informs you when
#       the offset of such a field has changed in GCC 4.4. For example there is
#       no longer a 4-bit padding between field a and b in this structure:
#
#              struct foo
#              {
#                char a:4;
#                char b:8;
#              } __attribute__ ((packed));
#
# INFO: This warning is enabled by default. Use -Wno-packed-bitfield-compat to
#       disable this warning.
#
# INFO: -Wpadded
#       Warn if padding is included in a structure, either to align an element
#       of the structure or to align the whole structure. Sometimes when this
#       happens it is possible to rearrange the fields of the structure to
#       reduce the padding and so make the structure smaller.

FLAGS_COMPILER_WARNINGS+=		-Wno-padded

# INFO: -Wredundant-decls
#       Warn if anything is declared more than once in the same scope, even in
#       cases where multiple declaration is valid and changes nothing.

FLAGS_COMPILER_WARNINGS+=		-Wredundant-decls

# INFO: -Wnested-externs (C and Objective-C only)
#       Warn if an extern declaration is encountered within a function.
#
# INFO: -Wno-inherited-variadic-ctor
#       Suppress warnings about use of C++11 inheriting constructors when the
#       base class inherited from has a C variadic constructor; the warning is
#       on by default because the ellipsis is not inherited.
#
# INFO: -Winline
#       Warn if a function that is declared as inline cannot be inlined. Even
#       with this option, the compiler does not warn about failures to inline
#       functions declared in system headers.
#
#       The compiler uses a variety of heuristics to determine whether or not
#       to inline a function. For example, the compiler takes into account the
#       size of the function being inlined and the amount of inlining that has
#       already been done in the current function. Therefore, seemingly
#       insignificant changes in the source program can cause the warnings
#       produced by -Winline to appear or disappear.
#
# INFO: -Wno-invalid-offsetof (C++ and Objective-C++ only)
#       Suppress warnings from applying the offsetof macro to a non-POD type.
#       According to the 2014 ISO C++ standard, applying offsetof to a
#       non-standard-layout type is undefined. In existing C++ implementations,
#       however, offsetof typically gives meaningful results. This flag is for
#       users who are aware that they are writing nonportable code and who have
#       deliberately chosen to ignore the warning about it.
#
#       The restrictions on offsetof may be relaxed in a future version of the
#       C++ standard.
#
# INFO: -Wno-int-to-pointer-cast
#       Suppress warnings from casts to pointer type of an integer of a
#       different size. In C++, casting to a pointer type of smaller size is an
#       error. Wint-to-pointer-cast is enabled by default.
#
# INFO: -Wno-pointer-to-int-cast (C and Objective-C only)
#       Suppress warnings from casts from a pointer to an integer type of a
#       different size.
#
# INFO: -Winvalid-pch
#       Warn if a precompiled header (see Precompiled Headers) is found in the
#       search path but can't be used.
#
# INFO: -Wlong-long
#       Warn if long long type is used. This is enabled by either -Wpedantic or
#       -Wtraditional in ISO C90 and C++98 modes. To inhibit the warning
#       messages, use -Wno-long-long.
#
# INFO: -Wvariadic-macros
#       Warn if variadic macros are used in ISO C90 mode, or if the GNU
#       alternate syntax is used in ISO C99 mode. This is enabled by either
#       -Wpedantic or -Wtraditional. To inhibit the warning messages, use
#       -Wno-variadic-macros.
#
# INFO: -Wvarargs
#       Warn upon questionable usage of the macros used to handle variable
#       arguments like va_start. This is default. To inhibit the warning
#       messages, use -Wno-varargs.
#
# INFO: -Wvector-operation-performance
#       Warn if vector operation is not implemented via SIMD capabilities of
#       the architecture. Mainly useful for the performance tuning. Vector
#       operation can be implemented piecewise, which means that the scalar
#       operation is performed on every vector element; in parallel, which
#       means that the vector operation is implemented using scalars of wider
#       type, which normally is more performance efficient; and as a single
#       scalar, which means that vector fits into a scalar type.
#
# INFO: -Wno-virtual-move-assign
#       Suppress warnings about inheriting from a virtual base with a
#       non-trivial C++11 move assignment operator. This is dangerous because
#       if the virtual base is reachable along more than one path, it is moved
#       multiple times, which can mean both objects end up in the moved-from
#       state. If the move assignment operator is written to avoid moving from
#       a moved-from object, this warning can be disabled.
#
# INFO: -Wvla
#       Warn if variable length array is used in the code. -Wno-vla prevents
#       the -Wpedantic warning of the variable length array.
#
# INFO: -Wvolatile-register-var
#       Warn if a register variable is declared volatile. The volatile modifier
#       does not inhibit all optimizations that may eliminate reads and/or
#       writes to register variables.
#
# INFO: This warning is enabled by -Wall.
#
# INFO: -Wdisabled-optimization
#       Warn if a requested optimization pass is disabled. This warning does
#       not generally indicate that there is anything wrong with your code; it
#       merely indicates that GCC's optimizers are unable to handle the code
#       effectively. Often, the problem is that your code is too big or too
#       complex; GCC refuses to optimize programs when the optimization itself
#       is likely to take inordinate amounts of time.
#
# INFO: -Wpointer-sign (C and Objective-C only)
#       Warn for pointer argument passing or assignment with different
#       signedness. This option is only supported for C and Objective-C. It is
#       implied by -Wall and by -Wpedantic, which can be disabled with
#       -Wno-pointer-sign.
#
# INFO: -Wstack-protector
#       This option is only active when -fstack-protector is active. It warns
#       about functions that are not protected against stack smashing.
#
# INFO: -Woverlength-strings
#       Warn about string constants that are longer than the “minimum maximum”
#       length specified in the C standard. Modern compilers generally allow
#       string constants that are much longer than the standard's minimum
#       limit, but very portable programs should avoid using longer strings.
#
#       The limit applies after string constant concatenation, and does not
#       count the trailing NUL. In C90, the limit was 509 characters; in C99,
#       it was raised to 4095. C++98 does not specify a normative minimum
#       maximum, so we do not diagnose overlength strings in C++.
#
#       This option is implied by -Wpedantic, and can be disabled with
#       -Wno-overlength-strings.
#
# INFO: -Wunsuffixed-float-constants (C and Objective-C only)
#       Issue a warning for any floating constant that does not have a suffix.
#       When used together with -Wsystem-headers it warns about such constants
#       in system header files. This can be useful when preparing code to use
#       with the FLOAT_CONST_DECIMAL64 pragma from the decimal floating-point
#       extension to C99.
#
# INFO: -Wno-designated-init (C and Objective-C only)
#       Suppress warnings when a positional initializer is used to initialize
#       a structure that has been marked with the designated_init attribute.

endif

