# docker

DKR_MAKEFILE_DIR = $(abspath $(dir $(filter %/docker.mk,$(MAKEFILE_LIST))))

include $(DKR_MAKEFILE_DIR)/_internal/validation-docker.mk

dkr_version:
	docker --version
