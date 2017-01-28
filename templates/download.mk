.PHONY: \
		$(DIRS_DOWNLOAD_DIR)

$(DIRS_DOWNLOAD_DIR): \
		%:
ifeq ($(wildcard $(DIRS_DOWNLOAD_DIR)), )
	git \
		clone \
		--recursive \
		$(DOWNLOAD_REPOSITORY_URL) \
		$*
else
	cd \
		$* && \
		git \
			pull || \
			true
endif

$(CLEAN_PREFIX)_$(DIRS_DOWNLOAD_DIR): \
		$(CLEAN_PREFIX)_%:
ifneq ($(wildcard $(DIRS_DOWNLOAD_DIR)/.git), )
	cd \
		$* && \
	git \
		checkout \
		. && \
	git \
		clean \
		-f \
		-d \
		-x
endif

$(CLEAN_FULL_PREFIX)_$(DIRS_DOWNLOAD_DIR): \
		$(CLEAN_FULL_PREFIX)_%:
	rm \
		-rf \
		$*

