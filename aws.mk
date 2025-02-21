# aws

AWS_MAKEFILE_DIR = $(abspath $(dir $(filter %/aws.mk,$(MAKEFILE_LIST))))

include $(AWS_MAKEFILE_DIR)/_internal/validation-aws.mk
include $(AWS_MAKEFILE_DIR)/_internal/validation-docker.mk

AWS_DOCKER_CMD = docker run --rm -it \
	-v ~/.aws:/root/.aws:ro \
	$(AWS_DOCKER_ADDITIONAL) amazon/aws-cli

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
