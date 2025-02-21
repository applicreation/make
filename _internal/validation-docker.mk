ifeq (, $(shell which docker))
$(error "Executable 'docker' not found in PATH")
endif
