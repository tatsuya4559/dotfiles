################################################################################
# Variables
################################################################################
.DEFAULT_GOAL := help
STOW_PACKAGES := alacritty bash fd git tig tmux vim

################################################################################
# Rules
################################################################################
.PHONY: all
all: run link bundle minpac ## Run all setup commands

.PHONY: run
run: ## Run scripts
	@$(CURDIR)/scripts/download_git_scripts.sh

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
