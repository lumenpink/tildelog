PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin


build: 
	$(info Generating the main executable)
	@mkdir -p build
	@awk '1{ if (NR > 1) { print x }};/### BEGIN SOURCEFILES/{exit};{x=$$0}' tildelog.sh > ./build/tildelog
	@grep  -hv '^[[:space:]]*declare\|^#!' ./functions/*.sh > ./build/tildelog.tmp
	@grep  -hv '^[[:space:]]*declare\|^#!' ./libs/*.sh >> ./build/tildelog.tmp
	@awk 'p;/### END SOURCEFILES/{p=1}' tildelog.sh >> ./build/tildelog.tmp
	@echo '#!/usr/bin/env bash' > ./build/tildelog
	@/usr/bin/sed -e '/^\s*#/d' -e '/^[[:space:]]*$$/d' ./build/tildelog.tmp  >> ./build/tildelog
	@rm -rf ./build/tildelog.tmp

install:
	$(info Generating the main executable)
	@mkdir -p build
	@awk '1{ if (NR > 1) { print x }};/### BEGIN SOURCEFILES/{exit};{x=$$0}' tildelog.sh > ./build/tildelog
	@grep  -hv '^[[:space:]]*declare\|^#!' ./lib/*.sh >> ./build/tildelog
	@awk 'p;/### END SOURCEFILES/{p=1}' tildelog.sh >> ./build/tildelog
	$(info Installing the executables to $(BINDIR))
	@install -Dm755 ./build/tildelog  $(BINDIR)/tildelog
	@install -Dm755 md2html.awk   $(BINDIR)/md2html.awk
	@install -Dm755 md2gemini.awk $(BINDIR)/md2gemini.awk
	@install -Dm755 md2gopher.awk $(BINDIR)/md2gopher.awk

uninstall:
	$(info Removing the executable from $(BINDIR))
	@rm -f $(BINDIR)/tildelog


test:
	$(info Running shellspec tests)
	@rm -rf ./coverage
	@shellspec --kcov

.PHONY: build install uninstall test
