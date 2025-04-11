ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
MAKE_DIR = $(ROOT_DIR)/../../src

export NAME = make-advanced

AWS_PROFILE = default
AWS_REGION = eu-west-1

TF_VERSION = latest

include $(MAKE_DIR)/*.mk
