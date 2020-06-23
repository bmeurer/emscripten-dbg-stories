EMCC?=emcc
PORT?=4000
SOURCE_MAP_BASE=http://localhost:$(PORT)/

DISTDIR=dist
TARGETS= \
	$(DISTDIR)/crbug-837572.c \
	$(DISTDIR)/crbug-837572.html \
	$(DISTDIR)/crbug-887384.c \
	$(DISTDIR)/crbug-887384.html \
	$(DISTDIR)/fibonacci.html \
	$(DISTDIR)/hello.html \
	$(DISTDIR)/hello-threads.html \
	$(DISTDIR)/index.html \
	$(DISTDIR)/stepping-with-state.c \
	$(DISTDIR)/stepping-with-state.js \
	$(DISTDIR)/stepping-with-state-sourcemaps.html \
	$(DISTDIR)/stepping-with-state-and-threads.c \
	$(DISTDIR)/stepping-with-state-and-threads.js \
	$(DISTDIR)/stepping-with-state-and-threads-sourcemaps.html

all: $(DISTDIR) $(TARGETS)

$(DISTDIR):
	mkdir -p $(DISTDIR)

$(DISTDIR)/%.html: %.html
	cp $< $@

$(DISTDIR)/%.c: %.c
	cp $< $@

$(DISTDIR)/crbug-837572.html: crbug-837572.c
	$(EMCC) -g4 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/crbug-887384.html: crbug-887384.c
	$(EMCC) -g4 -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=2 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/fibonacci.html: fibonacci.c
	$(EMCC) -g -o $@ $<

$(DISTDIR)/hello.html: hello.c
	$(EMCC) -g -o $@ $<

$(DISTDIR)/hello-threads.html: hello-threads.c
	$(EMCC) -g -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=2 -o $@ $<

$(DISTDIR)/stepping-with-state.js: stepping-with-state.c
	$(EMCC) -g4 -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=1 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/stepping-with-state-and-threads.js: stepping-with-state-and-threads.c
	$(EMCC) -g4 -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=1 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

start: all
	python3 -m http.server --directory $(DISTDIR) 4000

clean:
	@rm -rf $(DISTDIR)
