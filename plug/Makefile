all:
	@echo "use 'make install'"

install:
	ln -s $(CURDIR)/plug /usr/local/bin/plug
	mkdir -p ~/.local/bin
	ln -s $(CURDIR)/plug_completion.sh ~/.local/bin/plug_completion.sh
	@echo ""
	@echo "Please add 'source ~/.local/bin/plug_completion.sh' to your .bashrc"

uninstall:
	rm /usr/local/bin/plug
	rm ~/.local/bin/plug_completion.sh

.PHONY: all install uninstall
