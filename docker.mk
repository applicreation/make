# docker

ifeq (, $(shell which docker))
$(error "Executable 'docker' not found in PATH")
endif

DKR_MAKEFILE_DIR := $(abspath $(dir $(filter %/docker.mk,$(MAKEFILE_LIST))))

dkr_version:
	docker --version

dkr_system_prune:
	docker system prune -fa --volumes
	docker volume prune -f
