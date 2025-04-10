# .make

# Setup

## .gitignore

```
.make
```

## Makefile

```makefile
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
MAKE_DIR = $(ROOT_DIR)/.make

# your repo/project specific config go here

init: MAKE_URI = https://raw.githubusercontent.com/applicreation/make
init: MAKE_VERSION = v0
init: MAKE_FILES = aws docker
init:
	@rm -rf $(MAKE_DIR) && mkdir -p $(MAKE_DIR)
	@for MAKE_FILE in $(MAKE_FILES); do docker run --rm curlimages/curl -sSL $(MAKE_URI)/$(MAKE_VERSION)/$${MAKE_FILE}.mk > $(MAKE_DIR)/$${MAKE_FILE}.mk; done

-include $(MAKE_DIR)/*.mk

# your repo/project specific targets/rules go here
```
