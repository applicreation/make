# .make

# Setup

## .gitignore

```
.make
```

## Makefile

```makefile
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# your repo/project specific config go here

init: MAKE_NAME = .make
init: MAKE_URI = https://raw.githubusercontent.com/garyrutland/$(MAKE_NAME)
init: MAKE_VERSION = v0
init: MAKE_DIR = ./$(MAKE_NAME)
init: MAKE_FILES = git python
init:
	@rm -rf $(MAKE_DIR) && mkdir -p $(MAKE_DIR)
	@for MAKE_FILE in $(MAKE_FILES); do docker run --rm curlimages/curl -sSL $(MAKE_URI)/$(MAKE_VERSION)/$${MAKE_FILE}.mk > $(MAKE_DIR)/$${MAKE_FILE}.mk; done

include $(ROOT_DIR)/.make/*.mk

# your repo/project specific targets/rules go here
```
