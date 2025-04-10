# git

ifeq (, $(shell which git))
$(error "Executable 'git' not found in PATH")
endif

GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null)
GIT_TAG ?= $(shell git rev-parse --short=10 HEAD 2>/dev/null)

ifeq ($(GIT_BRANCH),)
$(error "No git repository found")
endif
