# Make

## Purpose

These files are created to abstract common tasks and are designed to be used purely for local development usage only.

## Prerequisites

The primary prerequisite is to have [Docker Desktop](https://www.docker.com/products/docker-desktop/) (or just Docker) installed.  
As much as possible is done via Docker to prevent individuals from having to install multiple applications or libraries as well as worrying about what versions are needed.

In the event other applications are needed (i.e. git) you will receive an error if they are not installed.

## Usage

### Makefile

#### Basic

To use these files within your repository, you can copy and paste the following code to the top of your repository `Makefile`.  
Alternatively, you can write a custom adaptation to replicate the same functionality.

```makefile
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
MAKE_DIR = $(ROOT_DIR)/.make

init: MAKE_URI = https://raw.githubusercontent.com/daemonite-labs/make
init: MAKE_VERSION = v0
init: MAKE_FILES = aws docker
init:
	@rm -rf $(MAKE_DIR) && mkdir -p $(MAKE_DIR)
	@for MAKE_FILE in $(MAKE_FILES); do docker run --rm curlimages/curl -sSL $(MAKE_URI)/$(MAKE_VERSION)/src/$${MAKE_FILE}.mk > $(MAKE_DIR)/$${MAKE_FILE}.mk; done

# your repository specific config go here

-include $(MAKE_DIR)/*.mk

# your repository specific targets/rules go here
```

#### Target/rule

By putting the basic usage example above at the top of your `Makefile` you can then either run `make init` or `make`.  
The example uses `init` but can be whatever you'd prefer, for example `install` could be used instead.

#### Directory

In the basic usage above, the `MAKE_DIR` variable is set to use `.make` as a directory within the root of the repository.  
It is also recommended ignoring the directory from your repository by adding `.make` in the `.gitignore` file in the root of the repository.

#### Version

These files are versioned and follow [semantic versioning](https://semver.org/) which is achieved with git tags, 
each patch version is immutable and will never change while the minor and major tags are mutable and will move based on the relevant patch version.  
It is recommended to lock your `MAKE_VERSION` to the current major version.

#### Includes

The above will include and download any files defined by `MAKE_FILES` which is a space delimited list.  
To include other files, it can be updated like so:

```makefile
init: MAKE_FILES = aws aws-lambda docker
```
