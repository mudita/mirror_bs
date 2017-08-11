ifndef MK_PLATFORM_MK
MK_PLATFORM_MK=			TRUE

INCLUDER_MODULES_LIST=		config \
				jobs \
				path

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

PLATFORM_SEPARATOR=		-
PLATFORM_HOST_ARCHITECTURE=	host

# TODO: Default platform should not be assumed!
ifndef PLATFORM
PLATFORM=			$(PLATFORM_HOST_ARCHITECTURE)
endif

# INFO: Base configuration
PLATFORM_HOST_ASSEMBLER=	as
PLATFORM_HOST_ARCHIVER=		ar
PLATFORM_HOST_LINKER=		ld
PLATFORM_HOST_GDB=		gdb
PLATFORM_HOST_SIZE=		size
PLATFORM_HOST_C_COMPILER=	gcc
PLATFORM_HOST_CPP_COMPILER=	g++
PLATFORM_HOST_FLAG_LIST=	-pthread

# INFO: Host.
ifeq ($(PLATFORM), $(PLATFORM_HOST_ARCHITECTURE))
PLATFORM_PREFIX=
PLATFORM_ASSEMBLER=		$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_HOST_ARCHIVER)
PLATFORM_LINKER=		$(PLATFORM_HOST_LINKER)
PLATFORM_GDB=			$(PLATFORM_HOST_GDB)
PLATFORM_SIZE=			$(PLATFORM_HOST_SIZE)
PLATFORM_C_COMPILER=		$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_HOST_CPP_COMPILER)
PLATFORM_FLAG_LIST=		$(PLATFORM_HOST_FLAG_LIST)
endif

# INFO: 
#ifeq ($(PLATFORM), x86_64)
#PLATFORM_PREFIX=
#PLATFORM_ASSEMBLER=		$(PLATFORM_HOST_ASSEMBLER)
#PLATFORM_ARCHIVER=
#PLATFORM_LINKER=
#PLATFORM_GDB=
#PLATFORM_SIZE=
#PLATFORM_C_COMPILER=		$(PLATFORM_HOST_C_COMPILER)
#PLATFORM_CPP_COMPILER=		$(PLATFORM_HOST_CPP_COMPILER)
#PLATFORM_FLAG_LIST=		$(PLATFORM_HOST_FLAG_LIST)
#endif

# INFO: 
#ifeq ($(PLATFORM), i386)
#PLATFORM_PREFIX=
#PLATFORM_ASSEMBLER=		$(PLATFORM_HOST_ASSEMBLER)
#PLATFORM_ARCHIVER=
#PLATFORM_LINKER=
#PLATFORM_GDB=
#PLATFORM_SIZE=
#PLATFORM_C_COMPILER=		$(PLATFORM_HOST_C_COMPILER)
#PLATFORM_CPP_COMPILER=		$(PLATFORM_HOST_CPP_COMPILER)
#PLATFORM_FLAG_LIST=		$(PLATFORM_HOST_FLAG_LIST)
#endif

# INFO: 
ifeq ($(PLATFORM), arm926ej_s)
PLATFORM_PREFIX=		arm-none-eabi
PLATFORM_ASSEMBLER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ARCHIVER)
PLATFORM_LINKER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_LINKER)
PLATFORM_GDB=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_GDB)
PLATFORM_SIZE=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_SIZE)
PLATFORM_C_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_QEMU=			qemu-system-arm
PLATFORM_MACHINE=		versatilepb
PLATFORM_CPU=			arm926

PLATFORM_FLAG_LIST=		-mcpu=arm926ej-s
endif

# INFO: 
ifeq ($(PLATFORM), arm_cortex_m4)
PLATFORM_PREFIX=		arm-none-eabi
PLATFORM_ASSEMBLER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ARCHIVER)
PLATFORM_LINKER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_LINKER)
PLATFORM_GDB=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_GDB)
PLATFORM_SIZE=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_SIZE)
PLATFORM_C_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)
# TODO: Cut of not obligatory!
# TODO: remove -march=armv7e-m if possible
PLATFORM_SPECS_LIST=		-mfpu=fpv4-sp-d16 \
				-mfloat-abi=softfp \
				-mcpu=cortex-m4 \
				-march=armv7e-m \
				-mthumb

PLATFORM_DEFINES_LIST=		-DREVISION_STR=\"@\" \
				-DREVISION_SGN=0x00000000 \
				-DPROJECT_NAME=\"ekofone\" \
				-DREENTRANT_SYSCALLS_PROVIDED=1 \
				-DDEBUG \
				-DNO_VCP \
				-DBATTERY_SIZE=710 \
				-DCORE_M4 \
				-DARM_MATH_CM4

PLATFORM_WARNINGS_LIST=		-Wno-unused-function \
				-Werror \
				-Wall \
				-Wstrict-prototypes \
				-Wreturn-type \
				-Wmissing-prototypes \
				-Wmissing-declarations \
				-Wimplicit-function-declaration \
				-Wmaybe-uninitialized \
				-Wuninitialized

PLATFORM_IMPERS_LIST=		-fno-strict-aliasing \
				-ffunction-sections \
				-fdata-sections \
				-fno-builtin-printf \
				-finput-charset=UTF-8

PLATFORM_LINKER_LIST=		-Wl,--gc-sections \
				-Os \
				-DSTM32L476xx \
				-DUSED_PROCESSOR_L4 \
				-DUSE_HAL_DRIVER=1

PLATFORM_FLAG_LIST=		$(PLATFORM_SPECS_LIST) \
				$(PLATFORM_DEFINES_LIST) \
				$(PLATFORM_WARNINGS_LIST) \
				$(PLATFORM_IMPERS_LIST) \
				$(PLATFORM_LINKER_LIST) \
				-specs=nosys.specs
endif

# INFO: 
ifeq ($(PLATFORM), stm32f407xx)
PLATFORM_PREFIX=		arm-none-eabi
PLATFORM_ASSEMBLER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ARCHIVER)
PLATFORM_LINKER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_LINKER)
PLATFORM_GDB=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_GDB)
PLATFORM_SIZE=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_SIZE)
PLATFORM_C_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)
# TODO: Cut of not obligatory!
# TODO: remove -march=armv7e-m if possible
#PLATFORM_SPECS_LIST=		-mfpu=fpv4-sp-d16 \
#				-mfloat-abi=softfp \
#				-mcpu=cortex-m4 \
#				-march=armv7e-m \
#				-mthumb

PLATFORM_SPECS_LIST=		-mcpu=cortex-m4 \
				-march=armv7e-m \
				-mfloat-abi=soft \
				-mthumb

#PLATFORM_DEFINES_LIST=		-DREVISION_STR=\"@\" \
#				-DREVISION_SGN=0x00000000 \
#				-DPROJECT_NAME=\"ekofone\" \
#				-DREENTRANT_SYSCALLS_PROVIDED=1 \
#				-DDEBUG \
#				-DNO_VCP \
#				-DBATTERY_SIZE=710 \
#				-DCORE_M4 \
#				-DARM_MATH_CM4

#PLATFORM_WARNINGS_LIST=		-Wno-unused-function \
#				-Werror \
#				-Wall \
#				-Wstrict-prototypes \
#				-Wreturn-type \
#				-Wmissing-prototypes \
#				-Wmissing-declarations \
#				-Wimplicit-function-declaration \
#				-Wmaybe-uninitialized \
#				-Wuninitialized

#PLATFORM_IMPERS_LIST=		-fno-strict-aliasing \
#				-ffunction-sections \
#				-fdata-sections \
#				-fno-builtin-printf \
#				-finput-charset=UTF-8

#PLATFORM_LINKER_LIST=		-Wl,--gc-sections \
#				-Os \
#				-DSTM32L476xx \
#				-DUSED_PROCESSOR_L4 \
#				-DUSE_HAL_DRIVER=1

#PLATFORM_FLAG_LIST=		$(PLATFORM_SPECS_LIST) \
#				$(PLATFORM_DEFINES_LIST) \
#				$(PLATFORM_WARNINGS_LIST) \
#				$(PLATFORM_IMPERS_LIST) \
#				$(PLATFORM_LINKER_LIST) \
#				-specs=nosys.specs

PLATFORM_FLAG_LIST=		$(PLATFORM_SPECS_LIST)
endif

# INFO: 
ifeq ($(PLATFORM), arm_cortex_a9)
PLATFORM_PREFIX=		arm-none-eabi
PLATFORM_ASSEMBLER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ARCHIVER)
PLATFORM_LINKER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_LINKER)
PLATFORM_GDB=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_GDB)
PLATFORM_SIZE=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_SIZE)
PLATFORM_C_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)

PLATFORM_SPECS_LIST=		-mcpu=cortex-a9 \
				-march=armv7-a

PLATFORM_QEMU=			qemu-system-arm
PLATFORM_MACHINE=		vexpress-a9

PLATFORM_CPU=			cortex-a9

# INFO: Working for application cortex_a9
PLATFORM_FLAG_LIST=		$(PLATFORM_SPECS_LIST) \
				-mword-relocations
endif

# INFO: 
ifeq ($(PLATFORM), or1k)
PLATFORM_PREFIX=		$(PLATFORM)-elf
PLATFORM_ASSEMBLER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_ARCHIVER)
PLATFORM_LINKER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_LINKER)
PLATFORM_GDB=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_GDB)
PLATFORM_SIZE=			$(PLATFORM_PREFIX)-$(PLATFORM_HOST_SIZE)
PLATFORM_C_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_PREFIX)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_SPECS_LIST=		-nostdlib \
				-mhard-div \
				-mhard-mul

PLATFORM_FLAG_LIST=		$(PLATFORM_SPECS_LIST)
endif

ifneq ($(wildcard $(CONFIG_PLATFORMS_FILE_NAME)), )
PLATFORM_COMPATIBLE_LIST_COMMAND=	cat \
						$(CONFIG_PLATFORMS_FILE_NAME)

PLATFORM_COMPATIBLE_LIST=	$(shell \
					$(PLATFORM_COMPATIBLE_LIST_COMMAND))

PLATFORM_CURRENT_PRESENT=	$(filter \
					$(PLATFORM), \
					$(PLATFORM_COMPATIBLE_LIST))

ifeq ($(PLATFORM_CURRENT_PRESENT), $(PLATFORM))
PLATFORM_COMPATIBLE_FLAG=	TRUE
else
PLATFORM_COMPATIBLE_FLAG=	FALSE
endif

endif

# INFO: Sanity check for variable PLATFORM_ASSEMBLER
ifndef PLATFORM_ASSEMBLER
$(error Variable PLATFORM_ASSEMBLER is not specified for $(PLATFORM))
else
ifeq ($(shell type -f $(PLATFORM_ASSEMBLER) 2> /dev/null || echo), )
$(error unknown command $(PLATFORM_ASSEMBLER))
endif
endif

# INFO: Sanity check for variable PLATFORM_ARCHIVER
ifndef PLATFORM_ARCHIVER
$(error Variable PLATFORM_ARCHIVER is not specified for $(PLATFORM))
else
ifeq ($(shell type -f $(PLATFORM_ARCHIVER) 2> /dev/null || echo), )
$(error unknown command $(PLATFORM_ARCHIVER))
endif
endif

# TODO: Think what should be done, if linker is not specified
# INFO: Sanity check for variable PLATFORM_LINKER
ifndef PLATFORM_LINKER
$(error Variable PLATFORM_LINKER is not specified for $(PLATFORM))
else
ifeq ($(shell type -f $(PLATFORM_LINKER) 2> /dev/null || echo), )
$(error unknown command $(PLATFORM_LINKER))
endif
endif

# INFO: Sanity check for variable PLATFORM_GDB
#ifndef PLATFORM_GDB
#$(error Variable PLATFORM_GDB is not specified for $(PLATFORM))
#else
#ifeq ($(shell type -f $(PLATFORM_GDB) 2> /dev/null || echo), )
#$(error unknown command $(PLATFORM_GDB))
#endif
#endif

# INFO: Sanity check for variable PLATFORM_SIZE
ifndef PLATFORM_SIZE
$(error Variable PLATFORM_SIZE is not specified for $(PLATFORM))
else
ifeq ($(shell type -f $(PLATFORM_SIZE) 2> /dev/null || echo), )
$(error unknown command $(PLATFORM_SIZE))
endif
endif

# INFO: Sanity check for variable PLATFORM_C_COMPILER
ifndef PLATFORM_C_COMPILER
$(error Variable PLATFORM_C_COMPILER is not specified for $(PLATFORM))
else
ifeq ($(shell type -f $(PLATFORM_C_COMPILER) 2> /dev/null || echo), )
$(error unknown command $(PLATFORM_C_COMPILER))
endif
endif

# INFO: Sanity check for variable PLATFORM_CPP_COMPILER
#ifndef PLATFORM_CPP_COMPILER
#$(error Variable PLATFORM_CPP_COMPILER is not specified for $(PLATFORM))
#else
#ifeq ($(shell type -f $(PLATFORM_CPP_COMPILER) 2> /dev/null || echo), )
#$(error unknown command $(PLATFORM_CPP_COMPILER))
#endif
#endif

# INFO: Sanity check for variable PLATFORM_FLAG_LIST
#ifndef PLATFORM_FLAG_LIST
#$(error Variable PLATFORM_FLAG_LIST is not specified for $(PLATFORM))
#endif

# INFO: If sanity check has passed, everything should be fine here.
PLATFORM_COMPATIBLE_FLAG=	TRUE

endif

