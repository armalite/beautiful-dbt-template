SHELL=/bin/bash -e -o pipefail
bold := $(shell tput bold)
sgr0 := $(shell tput sgr0)

.PHONY: help install check lint pyright test hooks install-hooks dbt
.SILENT:

output_location = "output"
MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := help

# Includes template managed targets in your Makefile
# Use `make help` for more details
include .beau/Makefile

###############################################################################
# 
# These are example Make targets to run a script that contains dbt commands. 
# These are intended to be used for quick runs of dbt commands LOCALLY
#
###############################################################################
# Run all dbt models except example models
dbt-run: script-permissions 
	cd dbt; poetry run ./scripts/dbt_run_all.sh

# Install dbt dependencies
dbt-deps: 
	cd dbt; poetry run dbt deps

