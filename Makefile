PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin


build: 
	$(info Generating the main executable)
	@mkdir -p build
	@awk '1{ if (NR > 1) { print x }};/### BEGIN SOURCEFILES/{exit};{x=$$0}' tildelog.sh > ./build/tildelog
	@grep  -hv '^[[:space:]]*declare\|^#!' ./lib/*.sh >> ./build/tildelog
	@awk 'p;/### END SOURCEFILES/{p=1}' tildelog.sh >> ./build/tildelog

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
	@rm -f $(BINDIR)/md2html.awk
	@rm -f $(BINDIR)/md2gemini.awk
	@rm -f $(BINDIR)/md2gopher.awk

test:
	$(info Running shellspec tests)
	@rm -rf ./coverage
	@shellspec --kcov

.PHONY: build install uninstall test
