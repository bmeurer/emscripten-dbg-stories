EMCC?=emcc
PORT?=4000
SOURCE_MAP_BASE=http://localhost:$(PORT)/

DISTDIR=dist
TARGETS= \
	$(DISTDIR)/crbug-887384.c \
	$(DISTDIR)/crbug-887384.html \
	$(DISTDIR)/hello.html \
	$(DISTDIR)/hello-threads.html \
	$(DISTDIR)/index.html

all: $(DISTDIR) $(TARGETS)

$(DISTDIR):
	mkdir -p $(DISTDIR)

$(DISTDIR)/index.html: index.html
	cp $< $@

$(DISTDIR)/crbug-887384.c: crbug-887384.c
	cp $< $@

$(DISTDIR)/crbug-887384.html: crbug-887384.c
	$(EMCC) -g4 -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=2 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/hello.html: hello.c
	$(EMCC) -g -o $@ $<

$(DISTDIR)/hello-threads.html: hello-threads.c
	$(EMCC) -g -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=2 -o $@ $<

start: all
	python3 -m http.server --directory $(DISTDIR) 4000

clean:
	@rm -rf $(DISTDIR)
