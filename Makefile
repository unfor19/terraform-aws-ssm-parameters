.EXPORT_ALL_VARIABLES:
TERRAFORM_VERSION ?= 0.14.8
DOCKER_TAG ?= unfor19/tfcoding:$(TERRAFORM_VERSION)
SRC_DIR_RELATIVE_PATH ?= examples/basic

help:                ## Available make commands
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's~:~~' | sed -e 's~##~~'

usage: help         

clean:               ## Clean tfcoding in Docker Compose
	@docker-compose -p tfcoding down -v --remove-orphans
	@docker rm -f tfcoding 2>/dev/null || true
	@docker volume rm tfcoding_code_dir_tmp 2>/dev/null || true

up-localstack:       ## Run localstack in Docker Compose
	@docker-compose -p tfcoding_aws -f docker-compose-localstack.yml up --detach

up-aws:              ## Run tfcoding-aws in Docker Compose
	@export SRC_DIR_RELATIVE_PATH="examples/basic" && \
	docker-compose -p tfcoding_aws -f docker-compose-aws.yml up

up-aws-localstack:    up-localstack up-aws ##

up-localstack-aws:    up-aws-localstack

down-aws:            ## Stop tfcoding-aws in Docker Compose
	@docker-compose -p tfcoding_aws -f docker-compose-aws.yml down

down-localstack:     ## Stop localstack in Docker Compose
	@docker-compose -p tfcoding_aws -f docker-compose-localstack.yml down

clean-localstack:    ## Clean localstack in Docker Compose
	@docker-compose -p tfcoding_aws -f docker-compose-localstack.yml down -v --remove-orphans
	@docker rm -f localstack 2>/dev/null || true
	@rm -rf .localstack 2>/dev/null || true

clean-aws:           ## Clean tfcoding in Docker Compose
	@docker-compose -p tfcoding_aws -f docker-compose-aws.yml down -v --remove-orphans
	@docker rm -f tfcoding-aws 2>/dev/null || true
	@docker volume rm tfcoding_aws_code_dir_tmp_aws tfcoding_aws_plugins_cache_dir 2>/dev/null || true

down-aws-localstack:  down-aws down-localstack ##

down-localstack-aws:  down-aws-localstack

clean-aws-localstack: clean-aws clean-localstack ##

clean-localstack-aws: clean-aws-localstack

test:                ## Run tests
	@./scripts/tests.sh

clean-all:            clean clean-aws-localstack ##
