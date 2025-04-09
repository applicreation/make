# git

ifeq (, $(shell which git))
$(error "Executable 'git' not found in PATH")
endif

ifeq (, $(wildcard $(GIT_DIR)))
$(error "No git repository found in $(GIT_DIR)")
endif

GIT_MAKEFILE_DIR := $(abspath $(dir $(filter %/git.mk,$(MAKEFILE_LIST))))

GIT_DIR ?= $(PWD)/.git

GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
GIT_TAG ?= $(shell git rev-parse --short=10 HEAD)
