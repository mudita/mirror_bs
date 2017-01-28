ifndef MK_NAME_MK
MK_NAME_MK=			TRUE

NAME_REAL_PATH=			$(realpath \
					.)

NAME_COMMAND=			basename \
					$(NAME_REAL_PATH)

NAME_SHELL=			$(shell \
					$(NAME_COMMAND))

NAME=				$(NAME_SHELL)

endif

