##############################################################################
# Variables
##############################################################################
.DEFAULT_GOAL := help
DEVBOX := /usr/local/bin/devbox
STOW_PACKAGES := alacritty ghostty readline fd git tig tmux vim

##############################################################################
#  Rules
##############################################################################
.PHONY: all
all: ansible link minpac ## Run all setup commands

.PHONY: link
link: ## Link dotfiles
	@stow -v --target $(HOME) $(STOW_PACKAGES)

.PHONY: unlink
unlink: ## Unlink dotfiles
	@stow -v --target $(HOME) --delete $(STOW_PACKAGES)

.PHONY: minpac
minpac: ## Install vim plugins
	@vim -c "call PackInit() | call minpac#update('', {'do': 'quitall'})"

.PHONY: ansible
ansible: $(DEVBOX) ## Run ansbile
	$(DEVBOX) run ansible-playbook

$(DEVBOX):
	curl -fsSL https://get.jetify.com/devbox | bash

.PHONY: lint-ansible
lint-ansible: $(DEVBOX) ## Lint ansible
	$(DEVBOX) run ansible-lint

.PHONY: help
help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
