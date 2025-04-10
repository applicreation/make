lambda_%: export NAME += -$(subst _,-,$(notdir $(CURDIR)))
lambda_%: export DIR = .

lambda_%: DOCKER_COMPOSE_FILE = $(CURDIR)/docker-compose.yaml

lambda_%: DOCKER_COMPOSE_CMD = docker compose -f $(DOCKER_COMPOSE_FILE)

lambda_build:
	$(DOCKER_COMPOSE_CMD) build $(SERVICE)

lambda_run: lambda_build
	$(DOCKER_COMPOSE_CMD) up --abort-on-container-exit
	$(DOCKER_COMPOSE_CMD) down
