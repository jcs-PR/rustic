.PHONY: test

-include config.mk

PKG = rustic

EMACS ?= emacs
EMACS_ARGS ?=

EASK ?= eask

# TODO: add lint
ci: package install compile checkdoc test

package:
	$(EASK) package

install:
	$(EASK) install

compile:
	$(EASK) compile

test:
	if [ -f "$(HOME)/.cargo/env" ] ; then . "$(HOME)/.cargo/env" ; fi ; \
	$(EASK) install-deps --dev
	$(EASK) test ert ./test/*.el

checkdoc:
	$(EASK) lint checkdoc

lint:
	$(EASK) lint package

CLEAN  = $(PKG)-autoloads.el

clean:
	@printf "Cleaning...\n"
	@rm -rf $(CLEAN)
	$(EASK) clean-all

$(PKG)-autoloads.el: $(ELS)
	@printf "Generating $@\n"
	$(EASK) autoloads
