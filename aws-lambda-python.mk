lambda_update: lambda_build
	docker compose run --rm dev pip-compile ./src/lambda_function/requirements.in

lambda_update_test: lambda_build
	docker compose run --rm dev pip-compile ./tests/requirements.in

lambda_test: lambda_build
	docker compose run --rm dev pytest --cov-report=term-missing:skip-covered --cov=src/lambda_function $(JUNITXML) ./tests
