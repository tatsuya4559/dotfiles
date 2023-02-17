################################################################################
# Variables
################################################################################
.DEFAULT_GOAL := help
STOW_PACKAGES := alacritty bash fd git tig tmux vim
DEVBOX := /usr/local/bin/devbox

################################################################################
# Rules
################################################################################
.PHONY: all
all: ansible link minpac ## Run all setup commands

$(DEVBOX):
	curl -fsSL https://get.jetpack.io/devbox | bash

.PHONY: ansible
ansible: $(DEVBOX) ## Run playbook
	@cd ansible
	@devbox run play

.PHONY: link
link: ## Link dotfiles
	@stow -v --target $(HOME) $(STOW_PACKAGES)

.PHONY: unlink
unlink: ## Unlink dotfiles
	@stow -v --target $(HOME) --delete $(STOW_PACKAGES)

.PHONY: minpac
minpac: ## Install vim plugins
	@vim -c "call PackInit() | call minpac#update('', {'do': 'quitall'})"

.PHONY: help
help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
