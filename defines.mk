ifndef MK_DEFINES_MK
MK_DEFINES_MK=			TRUE

INCLUDER_MODULES_LIST=		install \
				platform \
				config \
				unit_test

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEFINES_PREFIX=			-D

# INFO: Do not use quotations ("), use apostrophes instead (').
#DEFINES_BARE_LIST=		BARE_DEFINE_NAME='bare_define_value'

#ifeq ($(UNIT_TEST), 1)

DEFINES_BARE_LIST=		UNIT_TEST_ENTRY_POINT=$(UNIT_TEST_ENTRY_POINT) \
				LOGGER_DEVICE_XTERM_RW_COMMAND='xterm_rw_gcc_7_1_1_x86_64_pc_linux_gnu' \
				ETRACE_IF_CHRONOGRAPH_COMMAND='chronograph_gcc_7_1_1_x86_64_pc_linux_gnu' \
				TTY_SERIAL_DEVICE_XTERM_RW_COMMAND='xterm_rw_gcc_7_1_1_x86_64_pc_linux_gnu' \
				CPU_LOGS_CHRONOGRAPH_COMMAND='chronograph_gcc_7_1_1_x86_64_pc_linux_gnu' \
				FRAMEBUFFER_DEVICE_FB_VIEWER_COMMAND='fb_viewer_gcc_7_1_1_x86_64_pc_linux_gnu' \
				MAIN_MASTER_KERNEL_FILE='../../../baremetal_devel/install/arm_cortex_a9/baremetal_devel_arm_none_eabi_gcc_7_1_0_arm_none_eabi'

#else
#DEFINES_BARE_LIST=
#endif

# INFO: Each bare define gets define prefix here.
DEFINES_LIST=			$(patsubst \
					%, \
					$(DEFINES_PREFIX) %, \
					$(DEFINES_BARE_LIST))

endif

