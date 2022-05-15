all:
	@echo "use 'make install'"

install:
	ln -s $(CURDIR)/yadf /usr/local/bin/yadf

test:
	cd tests && ./test_deploy.bats

.PHONY: all install test
