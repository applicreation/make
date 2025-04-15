# lint

LINT_VERSION ?= v7
LINT_IMAGE ?= ghcr.io/super-linter/super-linter:$(LINT_VERSION)

LINT_BRANCH ?= main
LINT_DIRECTORY ?= $(CURDIR)

LINT_PRETTIER_FILE ?= .

LINT_CMD = docker run --rm --platform linux/amd64 \
	-e SHELL=/bin/bash \
	-e RUN_LOCAL=true \
	-e IGNORE_GITIGNORED_FILES=true \
	-e DEFAULT_BRANCH=$(LINT_BRANCH) \
	-v $(LINT_DIRECTORY):/tmp/lint \
	$(LINT_ADDITIONAL) $(LINT_IMAGE)

lint:
	$(LINT_CMD)

lint_prettier_check:
	docker run -w /tmp/prettier -v $(PWD):/tmp/prettier node:22-alpine npx prettier --check $(LINT_PRETTIER_FILE)

lint_prettier_write:
	docker run -w /tmp/prettier -v $(PWD):/tmp/prettier node:22-alpine npx prettier --write $(LINT_PRETTIER_FILE)
