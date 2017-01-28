ifndef MK_JOBS_MK
MK_JOBS_MK=			TRUE

JOBS_CPU_INFO=			/proc/cpuinfo
JOBS_CPU_PATTERN=		processor

JOBS_COUNT_PROCESSORS_COMMAND=	cat $(JOBS_CPU_INFO) | \
					grep $(JOBS_CPU_PATTERN) | \
					wc -l

JOBS_PROCESSORS_COUNT=		$(shell \
					$(JOBS_COUNT_PROCESSORS_COMMAND))

JOBS_COUNT_COMMAND=		echo \
					$$(( ($(JOBS_PROCESSORS_COUNT) * 2) + 1 ))

JOBS_COUNT=			$(shell \
					$(JOBS_COUNT_COMMAND))

endif

