.DEFAULT_GOAL := help
# do not link .bashrc and .bash_profile. they are just a reference
STOW_PACKAGES := alacritty readline fd git tig tmux vim

.PHONY: all
all: brew download link minpac ## Run all setup commands

.PHONY: brew
brew: ## Install homebrew
	./scripts/brew.sh

.PHONY: download
download: ## Download files
	./scripts/download.sh

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
