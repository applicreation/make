# docker

ifeq (, $(shell which docker))
$(error "Executable 'docker' not found in PATH")
endif

dkr_version:
	docker --version

dkr_system_prune:
	docker system prune -fa --volumes
	docker volume prune -f
