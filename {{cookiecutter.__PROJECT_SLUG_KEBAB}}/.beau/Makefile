.PHONY: help # Display list of available targets
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available Makefile targets:"
	@grep '.PHONY: .*' .beau/Makefile | grep -v 'grep' | sed 's/\.PHONY: \(.*\) # \(.*\)/\1\t\2/' | expand -t20

###############################################################################
# Environment Setup Targets
#
###############################################################################
.PHONY: clean # Remove all dependencies from the repository
clean: 
	rm -rf .venv
	rm -f poetry.lock

intro: 
	@echo " | _ ) ___ __ _ _  _  |_ _|_ _  __| |_ __ _| | |___ _ _  "
	@echo " | _ \/ -_) _` | || |  | || ' \(_-<  _/ _` | | / -_) '_| "
	@echo " |___/\___\__,_|\_,_| |___|_||_/__/\__\__,_|_|_\___|_|  "

.git: intro
	./.beau/scripts/git_init.sh

.venv:
	@echo ""
	@echo "Installing Poetry Dependencies"	
	@echo "=============================="
	@echo ""
	/bin/bash ./.beau/scripts/install_poetry.sh


.PHONY: install # Initiate git repository, install dependencies
install: .git .venv 
	@echo ''
	@echo 'If you would like to do a fresh install of dependencies, run `make clean install`'

.PHONY: force-install # Removes venv, attempts git init, then force installs Poetry
force-install: clean .git
	@echo ""
	@echo "Forcing Poetry Installation"	
	@echo "=============================="
	@echo ""
	/bin/bash ./.beau/scripts/install_poetry.sh --force

.PHONY: script-permissions # Set all script permissions to chmod 777
script-permissions: 
	find scripts/ -type f -iname "*.sh" -exec chmod 777 {} \;
	find dbt/ -type f -iname "*.sh" -exec chmod 777 {} \;
	find dbt/scripts -type f -iname "*.sh" -exec chmod 777 {} \;
