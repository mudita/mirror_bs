ifndef MK_FLAGS_COMPILER_COVERAGE_MK
MK_FLAGS_COMPILER_COVERAGE_MK=	TRUE


# TODO:
# https://gcc.gnu.org/onlinedocs/gcc-3.0/gcc_8.html
# http://logan.tw/posts/2015/04/28/check-code-coverage-with-clang-and-lcov/
# http://www.expcov.com/
# http://stackoverflow.com/questions/19881928/code-coverage-in-clang
# https://coveralls.io/

# INFO: Enable coverage testing with gcov during compilation.
FLAGS_COMPILER_COVERAGE=		-fprofile-arcs \
					-ftest-coverage

endif

