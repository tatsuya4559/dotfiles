.DEFAULT_GOAL := help

.PHONY: install
install: ## Install plug
	ln -s $(CURDIR)/plug /usr/local/bin/plug
	mkdir -p ~/.local/bin
	ln -s $(CURDIR)/plug_completion.sh ~/.local/bin/plug_completion.sh
	@echo ""
	@echo "Please add 'source ~/.local/bin/plug_completion.sh' to your .bashrc"

.PHONY: uninstall
uninstall: ## Uninstall plug
	rm /usr/local/bin/plug
	rm ~/.local/bin/plug_completion.sh

.PHONY: help
help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
