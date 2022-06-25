################################################################################
# Variables
################################################################################
.DEFAULT_GOAL := help
STOW_PACKAGES := bash git homebrew nvim tig tmux vim

################################################################################
# Rules
################################################################################
.PHONY: all
all: run link bundle ## Run all setup commands

.PHONY: run
run: ## Run run_once.sh
	$(CURDIR)/scripts/run_once.sh

.PHONY: link
link: ## Link dotfiles
	@stow -v --target $(HOME) $(STOW_PACKAGES)

.PHONY: unlink
unlink: ## Unlink dotfiles
	@stow -v --target $(HOME) --delete $(STOW_PACKAGES)

.PHONY: bundle
bundle: ## Bundle .Brewfile
	brew bundle --global

.PHONY: help
help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
