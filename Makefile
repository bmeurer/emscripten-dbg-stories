EMCC?=emcc

DISTDIR=dist
TARGETS= \
	$(DISTDIR)/hello.html \
	$(DISTDIR)/hello-threads.html \
	$(DISTDIR)/index.html

all: $(DISTDIR) $(TARGETS)

$(DISTDIR):
	mkdir -p $(DISTDIR)

$(DISTDIR)/index.html: index.html
	cp $< $@

$(DISTDIR)/hello.html: hello.c
	$(EMCC) -g -o $@ $<

$(DISTDIR)/hello-threads.html: hello-threads.c
	$(EMCC) -g -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=2 -o $@ $<

start: all
	python3 -m http.server --directory $(DISTDIR) 4000

clean:
	@rm -rf $(DISTDIR)
