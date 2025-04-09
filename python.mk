# python

ifndef PYTHON_VERSION
$(error "PYTHON_VERSION is not set")
endif

PYTHON_IMAGE ?= python:$(PYTHON_VERSION)-alpine
PYTHON_DIRECTORY ?= $(PWD)

PYTHON_DOCKER_CMD = docker run --rm -it \
	-w /usr/src/app \
	-v $(PYTHON_DIRECTORY):/usr/src/app \
	$(PYTHON_DOCKER_ADDITIONAL) $(PYTHON_IMAGE)

python_version:
	$(PYTHON_DOCKER_CMD) python --version

python_pip_install:
	$(PYTHON_DOCKER_CMD) pip install -r requirements.txt
