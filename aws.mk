# aws

ifndef AWS_PROFILE
$(error "AWS_PROFILE is not set")
endif

ifndef AWS_ACCOUNT_ID
$(error "AWS_ACCOUNT_ID is not set")
endif

ifndef AWS_REGION
$(error "AWS_REGION is not set")
endif

AWS_MAKEFILE_DIR := $(abspath $(dir $(filter %/aws.mk,$(MAKEFILE_LIST))))

AWS_VERSION ?= latest
AWS_IMAGE ?= amazon/aws-cli:$(AWS_VERSION)

AWS_DOCKER_CMD = docker run --rm -it \
	-v ~/.aws:/root/.aws:ro \
	$(AWS_DOCKER_ADDITIONAL) $(AWS_IMAGE)

aws_version:
	$(AWS_DOCKER_CMD) --version

aws_sso_configure:
	$(AWS_DOCKER_CMD) configure sso --profile $(AWS_PROFILE)

aws_sso_validate:
	@aws sts get-caller-identity &> /dev/null || { echo "aws login required, run 'make aws_sso_login' and try again"; exit 1; }

aws_sso_login:
	$(AWS_DOCKER_CMD) sso login --profile $(AWS_PROFILE)

aws_sso_logout:
	$(AWS_DOCKER_CMD) sso logout --profile $(AWS_PROFILE)
