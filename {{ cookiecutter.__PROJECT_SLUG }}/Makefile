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

script-permissions:
	find scripts/ -type f -iname "*.sh" -exec chmod 777 {} \;
	find dbt/ -type f -iname "*.sh" -exec chmod 777 {} \;
	find dbt/scripts -type f -iname "*.sh" -exec chmod 777 {} \;

# Runs all the dbt models in the repo except for the example models prefixed with zzz_
dbt-run:
	cd dbt && poetry run dbt deps && poetry run dbt run --full-refresh --exclude ./models/examples/zzz_example_test_model/ --profiles-dir .

dbt-deps:
	cd dbt && poetry run dbt deps
