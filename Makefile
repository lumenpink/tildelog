PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

prep:
	@bpkg getdeps

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

install: build
	$(info Installing the executables to $(BINDIR))
	@install -Dm755 ./build/tildelog  $(BINDIR)/tildelog

uninstall:
	$(info Removing the executable from $(BINDIR))
	@rm -f $(BINDIR)/tildelog

test:
	$(info Running shellspec tests)
	@rm -rf ./coverage
	@shellspec --kcov

clean:
	@rm -rf ./build ./coverage

.PHONY: build install uninstall test clean prep
