# git

GIT_MAKEFILE_DIR = $(abspath $(dir $(filter %/git.mk,$(MAKEFILE_LIST))))

GIT_DIR ?= $(PWD)/.git

include $(GIT_MAKEFILE_DIR)/_internal/validation-git.mk

GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
GIT_TAG ?= $(shell git rev-parse --short=10 HEAD)
