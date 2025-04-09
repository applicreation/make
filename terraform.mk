# terraform

ifndef TF_VERSION
$(error "TF_VERSION is not set")
endif

TF_MAKEFILE_DIR := $(abspath $(dir $(filter %/terraform.mk,$(MAKEFILE_LIST))))

TF_IMAGE ?= hashicorp/terraform:$(TF_VERSION)
TF_DIRECTORY ?= $(PWD)

TF_DOCKER_CMD = docker run --rm -it \
	-w /terraform \
	-v ~/.aws:/root/.aws:ro \
	-v ~/.ssh:/root/.ssh:ro \
	-v $(TF_DIRECTORY):/terraform \
	$(TF_DOCKER_ADDITIONAL) $(TF_IMAGE)

tf_%: AWS_PROFILE ?= default

# main commands

## init - prepare your working directory for other commands
tf_init:
ifdef UPGRADE
	$(TF_DOCKER_CMD) init -upgrade
else
	$(TF_DOCKER_CMD) init
endif

## validate - check whether the configuration is valid
tf_validate:
	$(TF_DOCKER_CMD) validate

## plan - show changes required by the current configuration
tf_plan: TF_PLAN_CMD = $(TF_DOCKER_CMD) plan
tf_plan:
ifdef REFRESH
	$(TF_PLAN_CMD) plan -refresh-only
else ifdef TARGET
	$(TF_PLAN_CMD) -target '$(TARGET)'
else ifdef REPLACE
	$(TF_PLAN_CMD) -replace '$(REPLACE)'
else
	$(TF_PLAN_CMD)
endif
	$(TF_DOCKER_CMD) plan

## apply - create or update infrastructure
tf_apply: TF_APPLY_CMD = $(TF_DOCKER_CMD) apply
tf_apply:
ifdef REFRESH
	$(TF_APPLY_CMD) -refresh-only
else ifdef TARGET
	$(TF_APPLY_CMD) -target '$(TARGET)'
else ifdef REPLACE
	$(TF_APPLY_CMD) -replace '$(REPLACE)'
else
	$(TF_APPLY_CMD)
endif

## destroy - destroy previously-created infrastructure
tf_destroy:
	$(TF_DOCKER_CMD) destroy

# all other commands

## console - try terraform expressions at an interactive command prompt
tf_console:
	$(TF_DOCKER_CMD) console

## fmt - reformat your configuration in the standard style
tf_fmt:
	$(TF_DOCKER_CMD) fmt -recursive

## force-unlock - release a stuck lock on the current workspace
tf_force_unlock:
	$(TF_DOCKER_CMD) force-unlock '$(LOCK_ID)'

## get - install or upgrade remote terraform modules
tf_get:
	$(TF_DOCKER_CMD) get

## graph - generate a graphviz graph of the steps in an operation
tf_graph:
	@echo "terraform graph is not implemented yet"

## import - associate existing infrastructure with a terraform resource
tf_import:
	$(TF_DOCKER_CMD) import '$(ADDRESS)' '$(ID)'

## login - obtain and save credentials for a remote host
tf_login:
	$(TF_DOCKER_CMD) login $(HOSTNAME)

## logout - remove locally-stored credentials for a remote host
tf_logout:
	$(TF_DOCKER_CMD) logout $(HOSTNAME)

## metadata - metadata related commands
tf_metadata_functions:
	$(TF_DOCKER_CMD) metadata functions -json

## modules - show all declared modules in a working directory
tf_modules:
	$(TF_DOCKER_CMD) modules

## output - show output values from your root module
tf_output:
	$(TF_DOCKER_CMD) output

## providers - show the providers required for this configuration
tf_providers:
	$(TF_DOCKER_CMD) providers

tf_providers_lock:
	$(TF_DOCKER_CMD) providers lock

tf_providers_mirror:
	$(TF_DOCKER_CMD) providers mirror '$(DIR)'

tf_providers_schema:
	$(TF_DOCKER_CMD) providers schema

## refresh - update the state to match remote systems
tf_refresh:
	@echo "terraform refresh is deprecated, use 'make tf_apply REFRESH=true' instead"

## show - show the current state or a saved plan
tf_show:
	$(TF_DOCKER_CMD) show

## state - advanced state management
tf_state_list:
	$(TF_DOCKER_CMD) state list

tf_state_mv:
	$(TF_DOCKER_CMD) state mv '$(SOURCE)' '$(DESTINATION)'

tf_state_pull:
	$(TF_DOCKER_CMD) state pull

# tf_state_push:
# 	$(TF_DOCKER_CMD) state push

tf_state_replace_provider:
	$(TF_DOCKER_CMD) state replace-provider '$(FROM_PROVIDER)' '$(TO_PROVIDER)'

tf_state_rm:
	$(TF_DOCKER_CMD) state rm '$(ADDRESS)'

tf_state_show:
	$(TF_DOCKER_CMD) state show '$(ADDRESS)'

## taint - mark a resource instance as not fully functional
tf_taint:
	$(TF_DOCKER_CMD) taint '$(ADDRESS)'

## untaint - remove the 'tainted' state from a resource instance
tf_untaint:
	$(TF_DOCKER_CMD) untaint '$(ADDRESS)'

## version - show the current terraform version
tf_version:
	$(TF_DOCKER_CMD) version

## workspace - workspace management
tf_workspace_list:
	$(TF_DOCKER_CMD) workspace list

tf_workspace_select:
	$(TF_DOCKER_CMD) workspace select '$(WORKSPACE)'

tf_workspace_new:
	$(TF_DOCKER_CMD) workspace new '$(WORKSPACE)'

tf_workspace_delete:
	$(TF_DOCKER_CMD) workspace delete '$(WORKSPACE)'

tf_workspace_show:
	$(TF_DOCKER_CMD) workspace show
