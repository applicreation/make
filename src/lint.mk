# lint

LINT_VERSION ?= v7
LINT_IMAGE ?= ghcr.io/super-linter/super-linter:$(LINT_VERSION)

LINT_BRANCH ?= main
LINT_DIRECTORY ?= $(CURDIR)

LINT_CMD = docker run --rm --platform linux/amd64 \
	-e SHELL=/bin/bash \
	-e RUN_LOCAL=true \
	-e IGNORE_GITIGNORED_FILES=true \
	-e DEFAULT_BRANCH=$(LINT_BRANCH) \
	-v $(LINT_DIRECTORY):/tmp/lint \
	$(LINT_ADDITIONAL) github/super-linter:$(LINT_VERSION)

lint:
	$(LINT_CMD)
