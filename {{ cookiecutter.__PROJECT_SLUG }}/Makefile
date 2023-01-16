SHELL=/bin/bash -e -o pipefail
bold := $(shell tput bold)
sgr0 := $(shell tput sgr0)

.PHONY: help install check lint pyright test hooks install-hooks dbt
.SILENT:

output_location = "output"
MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := help

## display help message
help:
	@awk '/^##.*$$/,/^[~\/\.0-9a-zA-Z_-]+:/' $(MAKEFILE_LIST) | awk '!(NR%2){print $$0p}{p=$$0}' | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' | sort

###############################################################################
# Environment Setup Targets
#
###############################################################################
clean:
	sudo rm -rf .venv

install:
	/bin/bash ./scripts/setup/poetry_install.sh

script-permissions:
	find scripts/ -type f -iname "*.sh" -exec chmod 777 {} \;
	find dbt/ -type f -iname "*.sh" -exec chmod 777 {} \;
	find dbt/scripts -type f -iname "*.sh" -exec chmod 777 {} \;

generate-profile:
	cd scripts/dbt_generator; poetry run python -m src.generate_profile
###############################################################################
# XADE Data Vault - LOCAL DBT command targets
# These targets execute dbt commands on any of our data vault constructs
#
###############################################################################
# Runs all the dbt models in the repo except for the example models prefixed with zzz_
dbt-run: script-permissions
	cd dbt; poetry run ./scripts/dbt_run_all.sh

dbt-deps:
	cd dbt; poetry run dbt deps


###############################################################################
# Test Targets
#
###############################################################################
test: test-functional test-unit
	echo "$(bold)=== Run all tests ===$(sgr0)"

test-unit:
	echo "$(bold)=== Running unit tests ===$(sgr0)"
	#pytest --capture=no --doctest-modules -m unit --user=$(user) --password=$(password) --account=$(account) --prefix=$(prefix) --environment=$(env) tests/

test-functional:
	echo "$(bold)=== Running functional tests ===$(sgr0)"

test-end-to-end:
	echo "$(bold)=== Running end-to-end tests ===$(sgr0)"
	#pytest --capture=no --doctest-modules -m end_to_end --user=$(user) --password=$(password) --account=$(account) --prefix=$(prefix) --environment=$(env) tests/

test-pre-deployment:
	echo "$(bold)=== Running pre-deployment tests ===$(sgr0)"
	#pytest --capture=no --doctest-modules -m pre_deployment --user=$(user) --password=$(password) --account=$(account) --prefix=$(prefix) --environment=$(env) tests/

test-post-deployment:
	echo "$(bold)=== Running post-deployment tests ===$(sgr0)"
	#pytest --capture=no --doctest-modules -m post_deployment --user=$(user) --password=$(password) --account=$(account) --prefix=$(prefix) --environment=$(env) tests/
