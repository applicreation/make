ifeq (, $(shell which git))
$(error "Executable 'git' not found in PATH")
endif

ifeq (, $(wildcard $(GIT_DIR)))
$(error "No git repository found in $(GIT_DIR)")
endif
