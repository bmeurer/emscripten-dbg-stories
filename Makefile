EMCC?=emcc

DISTDIR=dist
TARGETS=$(DISTDIR)/hello.html $(DISTDIR)/index.html

all: $(DISTDIR) $(TARGETS)

$(DISTDIR):
	mkdir -p $(DISTDIR)

$(DISTDIR)/index.html: index.html
	cp $< $@

$(DISTDIR)/hello.html: hello.c
	$(EMCC) -g -o $@ $<

start: all
	python3 -m http.server --directory $(DISTDIR) 4000

clean:
	@rm -rf $(DISTDIR)
