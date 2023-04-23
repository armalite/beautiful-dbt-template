.PHONY: help # Display list of available targets
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available Makefile targets:"
	@grep '.PHONY: .*' .xts/Makefile | grep -v 'grep' | sed 's/\.PHONY: \(.*\) # \(.*\)/\1\t\2/' | expand -t20

###############################################################################
# Environment Setup Targets
#
###############################################################################
.PHONY: clean # Remove all dependencies from the repository
clean: 
	rm -rf .venv
	rm -f poetry.lock

intro: 
	@echo " __  _______ ____    ___           _        _ _           ";
	@echo " \ \/ /_   _/ ___|  |_ _|_ __  ___| |_ __ _| | | ___ _ __ ";
	@echo "  \  /  | | \___ \   | || '_ \/ __| __/ _\` | | |/ _ \ '__|";
	@echo "  /  \  | |  ___) |  | || | | \__ \ || (_| | | |  __/ |   ";
	@echo " /_/\_\ |_| |____/  |___|_| |_|___/\__\__,_|_|_|\___|_|   ";
	@echo "                                                          ";

.git: intro
	./.xts/scripts/git_init.sh

.venv:
	@echo ""
	@echo "Installing Poetry Dependencies"	
	@echo "=============================="
	@echo ""
	/bin/bash ./.xts/scripts/install_poetry.sh

.PHONY: install # Initiate git repository, install dependencies
install: .git .venv 
	@echo ''
	@echo 'If you would like to do a fresh install of dependencies, run `make clean install`'

.PHONY: script-permissions # Set all script permissions to chmod 777
script-permissions: 
	find scripts/ -type f -iname "*.sh" -exec chmod 777 {} \;
	find dbt/ -type f -iname "*.sh" -exec chmod 777 {} \;
	find dbt/scripts -type f -iname "*.sh" -exec chmod 777 {} \;


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
