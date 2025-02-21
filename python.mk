# python

PYTHON_MAKEFILE_DIR = $(abspath $(dir $(filter %/python.mk,$(MAKEFILE_LIST))))

include $(PYTHON_MAKEFILE_DIR)/_internal/validation-docker.mk
include $(PYTHON_MAKEFILE_DIR)/_internal/validation-python.mk

PYTHON_DIRECTORY ?= $(PWD)

PYTHON_DOCKER_CMD = docker run --rm -it \
	-w /usr/src/app \
	-v $(PYTHON_DIRECTORY):/usr/src/app \
	$(PYTHON_DOCKER_ADDITIONAL) python:$(PYTHON_VERSION)-alpine

python_version:
	$(PYTHON_DOCKER_CMD) python --version

python_pip_install:
	$(PYTHON_DOCKER_CMD) pip install -r requirements.txt
