lambda_build:
	docker compose build $(SERVICE)

lambda_run: lambda_build
	docker compose up --abort-on-container-exit
	docker compose down
