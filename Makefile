EMCC?=emcc
EMXX?=em++
PORT?=4000
SOURCE_MAP_BASE?=http://localhost:$(PORT)/

DISTDIR=dist
TARGETS= \
	$(DISTDIR)/crbug-837572.c \
	$(DISTDIR)/crbug-837572.html \
	$(DISTDIR)/crbug-887384.c \
	$(DISTDIR)/crbug-887384.html \
	$(DISTDIR)/fibonacci.c \
	$(DISTDIR)/fibonacci.html \
	$(DISTDIR)/fibonacci-proxytopthread.html \
	$(DISTDIR)/fibonacci-proxytopthread-sourcemaps.html \
	$(DISTDIR)/deep-call-stack-with-inlining.c \
	$(DISTDIR)/deep-call-stack-with-inlining.html \
	$(DISTDIR)/hello.c \
	$(DISTDIR)/hello.html \
	$(DISTDIR)/hello-separate-dwarf.html \
	$(DISTDIR)/hello-separate-dwarf-broken.html \
	$(DISTDIR)/hello-threads.c \
	$(DISTDIR)/hello-threads.html \
	$(DISTDIR)/index.html \
	$(DISTDIR)/inlining.c \
	$(DISTDIR)/inlining-crbug-1113603.html \
	$(DISTDIR)/inlining-dwarf.html \
	$(DISTDIR)/inlining-sourcemaps.html \
	$(DISTDIR)/inlining-sourcemaps.js \
	$(DISTDIR)/stepping-with-state.c \
	$(DISTDIR)/stepping-with-state.js \
	$(DISTDIR)/stepping-with-state-sourcemaps.html \
	$(DISTDIR)/stepping-with-state-and-threads.c \
	$(DISTDIR)/stepping-with-state-and-threads.js \
	$(DISTDIR)/stepping-with-state-and-threads-sourcemaps.html \
	$(DISTDIR)/stepping-with-state-and-threads-sourcemaps-proxytopthread.js \
	$(DISTDIR)/stepping-with-state-and-threads-sourcemaps-proxytopthread.html \
	$(DISTDIR)/stepping-with-state-and-threads-proxytopthread.js \
	$(DISTDIR)/stepping-with-state-and-threads-proxytopthread.html \
	$(DISTDIR)/string.cc \
	$(DISTDIR)/string.html

all: $(DISTDIR) $(TARGETS)

$(DISTDIR):
	mkdir -p $(DISTDIR)

$(DISTDIR)/%.html: %.html
	cp $< $@

$(DISTDIR)/%.c: %.c
	cp $< $@

$(DISTDIR)/%.cc: %.cc
	cp $< $@

$(DISTDIR)/crbug-837572.html: crbug-837572.c
	$(EMCC) -g4 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/crbug-887384.html: crbug-887384.c
	$(EMCC) -g4 -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=2 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/deep-call-stack-with-inlining.html: deep-call-stack-with-inlining.c
	$(EMCC) -O0 -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/fibonacci.html: fibonacci.c
	$(EMCC) -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/fibonacci-proxytopthread-sourcemaps.html: fibonacci.c
	$(EMCC) -g4 -s PROXY_TO_PTHREAD -s USE_PTHREADS=1 --source-map-base $(SOURCE_MAP_BASE) -o $@ $<

$(DISTDIR)/fibonacci-proxytopthread.html: fibonacci.c
	$(EMCC) -g -s PROXY_TO_PTHREAD -s USE_PTHREADS=1 -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/hello.html: hello.c
	$(EMCC) -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/hello-separate-dwarf.html: hello.c
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=hello-separate-dwarf.debug.wasm -o $@ $<
	mv hello-separate-dwarf.debug.wasm $(DISTDIR)

$(DISTDIR)/hello-separate-dwarf-broken.html: hello.c
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=$(DISTDIR)/hello-separate-dwarf-broken.debug.wasm -o $@ $<

$(DISTDIR)/hello-threads.html: hello-threads.c
	$(EMCC) -g -fdebug-compilation-dir=. -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=2 -o $@ $<

$(DISTDIR)/inlining-crbug-1113603.html: inlining.c
	$(EMCC) -g -fdebug-compilation-dir=. -O1 -o $@ $<

$(DISTDIR)/inlining-dwarf.html: inlining.c
	$(EMCC) -g -fdebug-compilation-dir=. -O0 -o $@ $<

$(DISTDIR)/inlining-sourcemaps.js: inlining.c
	$(EMCC) -g4 --source-map-base $(SOURCE_MAP_BASE) -O0 -o $@ $<

$(DISTDIR)/stepping-with-state.js: stepping-with-state.c
	$(EMCC) -g4 -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=1 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/stepping-with-state-and-threads.js: stepping-with-state-and-threads.c
	$(EMCC) -g4 -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=1 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/stepping-with-state-and-threads-sourcemaps-proxytopthread.js: stepping-with-state-and-threads.c
	$(EMCC)  -g4 -s USE_PTHREADS=1 -s PROXY_TO_PTHREAD --source-map-base $(SOURCE_MAP_BASE) -o $@ $<

$(DISTDIR)/stepping-with-state-and-threads-proxytopthread.js: stepping-with-state-and-threads.c
	$(EMCC)  -g -s USE_PTHREADS=1 -s PROXY_TO_PTHREAD -fdebug-compilation-dir=.  -o $@ $<

$(DISTDIR)/string.html: string.cc
	$(EMXX) -g -fno-limit-debug-info -fdebug-compilation-dir=. -O0 -o $@ $<

$(DISTDIR)/stepping-with-state-and-threads-proxytopthread.html: stepping-with-state-and-threads-sourcemaps-proxytopthread.html
	cp $< $@

start: all
	python3 -m http.server --directory $(DISTDIR) 4000

clean:
	@rm -rf $(DISTDIR)
