# lambda_%: export NAME = $(subst _,-,$(notdir $(CURDIR)))
# lambda_%: export DIR = ./$(subst $(MAKEFILE_DIR),,$(CURDIR))

lambda_build:
	docker compose build $(SERVICE)

lambda_run: lambda_build
	docker compose up --abort-on-container-exit
	docker compose down
