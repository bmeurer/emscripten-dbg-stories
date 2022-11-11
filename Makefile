EMCC?=emcc
EMXX?=em++
PORT?=4000
SOURCE_MAP_BASE?=http://localhost:$(PORT)/
LLVMDWP?=llvm-dwp
EMCCDWARF5COMPILEFLAGS=-gsplit-dwarf -gdwarf-5 -gpubnames
EMCCDWARF5FLAGS=$(EMCCDWARF5COMPILEFLAGS) -sWASM_BIGINT -sERROR_ON_WASM_CHANGES_AFTER_LINK -sREVERSE_DEPS=all

DISTDIR=dist
TARGETS= \
	$(DISTDIR)/crbug-837572.c \
	$(DISTDIR)/crbug-837572.html \
	$(DISTDIR)/crbug-887384.c \
	$(DISTDIR)/crbug-887384.html \
	$(DISTDIR)/crbug-1141330.c \
	$(DISTDIR)/crbug-1141330.html \
	$(DISTDIR)/crbug-1150303.c \
	$(DISTDIR)/crbug-1150303.html \
	$(DISTDIR)/crbug-1153644.c \
	$(DISTDIR)/crbug-1153644.html \
	$(DISTDIR)/crbug-1234784.cc \
	$(DISTDIR)/crbug-1234784.html \
	$(DISTDIR)/deep-call-stack-with-inlining.c \
	$(DISTDIR)/deep-call-stack-with-inlining.html \
	$(DISTDIR)/diverse-inlining.h \
	$(DISTDIR)/diverse-inlining.html \
	$(DISTDIR)/diverse-inlining-extern.c \
	$(DISTDIR)/diverse-inlining-main.c \
	$(DISTDIR)/fibonacci.c \
	$(DISTDIR)/fibonacci.html \
	$(DISTDIR)/fibonacci-O1.html \
	$(DISTDIR)/fibonacci-O2.html \
	$(DISTDIR)/fibonacci-proxytopthread.html \
	$(DISTDIR)/fibonacci-proxytopthread-sourcemaps.html \
	$(DISTDIR)/globals.cc \
	$(DISTDIR)/globals.html \
	$(DISTDIR)/hello.c \
	$(DISTDIR)/hello.html \
	$(DISTDIR)/hello-no-symbols.html \
	$(DISTDIR)/hello-separate-dwarf.html \
	$(DISTDIR)/hello-separate-dwarf-broken.html \
	$(DISTDIR)/hello-split-dwarf-dwp.html \
	$(DISTDIR)/hello-split-dwarf-dwo.html \
	$(DISTDIR)/hello-split-dwarf-missing-dwp.html \
	$(DISTDIR)/hello-threads.c \
	$(DISTDIR)/hello-threads.html \
	$(DISTDIR)/hello-windows.html \
	$(DISTDIR)/index.html \
	$(DISTDIR)/inlining.c \
	$(DISTDIR)/inlining-crbug-1113603.html \
	$(DISTDIR)/inlining-dwarf.html \
	$(DISTDIR)/inlining-sourcemaps.html \
	$(DISTDIR)/inlining-sourcemaps.js \
	$(DISTDIR)/instrumentation-breakpoints.html \
	$(DISTDIR)/instrumentation-breakpoints.cc \
	$(DISTDIR)/instrumentation-breakpoints.js \
	$(DISTDIR)/lmi.cc \
	$(DISTDIR)/lmi.html \
	$(DISTDIR)/lmi-primitives.cc \
	$(DISTDIR)/lmi-primitives.html \
	$(DISTDIR)/lmi-structs-classes.cc \
	$(DISTDIR)/lmi-structs-classes.html \
	$(DISTDIR)/mandelbrot.cc \
	$(DISTDIR)/mandelbrot.html \
	$(DISTDIR)/simd.c \
	$(DISTDIR)/simd.html \
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
	$(DISTDIR)/string.html \
	$(DISTDIR)/tail-call-inlining.c \
	$(DISTDIR)/tail-call-inlining.html

all: $(DISTDIR) $(TARGETS)

$(DISTDIR):
	mkdir -p $(DISTDIR)

$(DISTDIR)/%.html: %.html
	cp $< $@

$(DISTDIR)/%.h: %.h
	cp $< $@

$(DISTDIR)/%.c: %.c
	cp $< $@

$(DISTDIR)/%.cc: %.cc
	cp $< $@

$(DISTDIR)/crbug-837572.html: crbug-837572.c
	$(EMCC) -gsource-map --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/crbug-887384.html: crbug-887384.c
	$(EMCC) -gsource-map -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=2 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/crbug-1141330.html: crbug-1141330.c
	$(EMCC) -g -O0 -fdebug-compilation-dir=. -o $@ ./$<

$(DISTDIR)/crbug-1150303.html: crbug-1150303.c
	$(EMCC) -O0 -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/crbug-1153644.html: crbug-1153644.c
	$(EMCC) -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/deep-call-stack-with-inlining.html: deep-call-stack-with-inlining.c
	$(EMCC) -O0 -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/diverse-inlining.html: diverse-inlining-extern.c diverse-inlining-main.c
	$(EMCC) -g -fdebug-compilation-dir=. -o $@ $^

$(DISTDIR)/fibonacci.html: fibonacci.c
	$(EMCC) -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/fibonacci-O1.html: fibonacci.c
	$(EMCC) -O1 -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/fibonacci-O2.html: fibonacci.c
	$(EMCC) -O2 -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/fibonacci-proxytopthread-sourcemaps.html: fibonacci.c
	$(EMCC) -gsource-map -s PROXY_TO_PTHREAD -s USE_PTHREADS=1 --source-map-base $(SOURCE_MAP_BASE) -o $@ $<

$(DISTDIR)/fibonacci-proxytopthread.html: fibonacci.c
	$(EMCC) -g -s PROXY_TO_PTHREAD -s USE_PTHREADS=1 -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/globals.html: globals.cc
	$(EMXX) -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/hello.html: hello.c
	$(EMCC) -g -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/hello-no-symbols.html: hello.c
	$(EMCC) -o $@ $<

$(DISTDIR)/hello-separate-dwarf.html: hello.c
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=hello-separate-dwarf.debug.wasm -o $@ $<
	mv hello-separate-dwarf.debug.wasm $(DISTDIR)

$(DISTDIR)/hello-separate-dwarf-broken.html: hello.c
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=hello-separate-dwarf-broken.debug.wasm -o $@ $<
	rm hello-separate-dwarf-broken.debug.wasm

$(DISTDIR)/hello-split-dwarf-dwp.html: hello.c
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=$(DISTDIR)/hello-split-dwarf-dwp.debug.wasm $(EMCCDWARF5COMPILEFLAGS) -c -o hello-split-dwarf-dwp.o $<
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=$(DISTDIR)/hello-split-dwarf-dwp.debug.wasm $(EMCCDWARF5FLAGS) -o $@ hello-split-dwarf-dwp.o
	$(LLVMDWP) -e=$(DISTDIR)/hello-split-dwarf-dwp.debug.wasm -o=$(DISTDIR)/hello-split-dwarf-dwp.debug.wasm.dwp
	rm hello-split-dwarf-dwp.o hello-split-dwarf-dwp.dwo

$(DISTDIR)/hello-split-dwarf-dwo.html: hello.c
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=$(DISTDIR)/hello-split-dwarf-dwo.debug.wasm $(EMCCDWARF5COMPILEFLAGS) -c -o hello-split-dwarf-dwo.o $<
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=$(DISTDIR)/hello-split-dwarf-dwo.debug.wasm $(EMCCDWARF5FLAGS) -o $@ hello-split-dwarf-dwo.o
	mv hello-split-dwarf-dwo.dwo $(DISTDIR)
	rm hello-split-dwarf-dwo.o

$(DISTDIR)/hello-split-dwarf-missing-dwp.html: hello.c
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=$(DISTDIR)/hello-split-dwarf-missing-dwp.debug.wasm $(EMCCDWARF5COMPILEFLAGS) -c -o hello-split-dwarf-missing-dwp.o $<
	$(EMCC) -fdebug-compilation-dir=. -gseparate-dwarf=$(DISTDIR)/hello-split-dwarf-missing-dwp.debug.wasm $(EMCCDWARF5FLAGS) -o $@ hello-split-dwarf-missing-dwp.o
	rm hello-split-dwarf-missing-dwp.o hello-split-dwarf-missing-dwp.dwo

$(DISTDIR)/hello-threads.html: hello-threads.c
	$(EMCC) -g -fdebug-compilation-dir=. -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=2 -o $@ $<

$(DISTDIR)/hello-windows.html: hello.c
	$(EMCC) -g -fdebug-compilation-dir=c:\\src -o $@ $<

$(DISTDIR)/inlining-crbug-1113603.html: inlining.c
	$(EMCC) -g -fdebug-compilation-dir=. -O1 -o $@ $<

$(DISTDIR)/inlining-dwarf.html: inlining.c
	$(EMCC) -g -fdebug-compilation-dir=. -O0 -o $@ $<

$(DISTDIR)/inlining-sourcemaps.js: inlining.c
	$(EMCC) -gsource-map --source-map-base $(SOURCE_MAP_BASE) -O0 -o $@ $<

$(DISTDIR)/instrumentation-breakpoints.js: instrumentation-breakpoints.cc
	$(EMXX) -g -O0 -fdebug-compilation-dir=. -o $@ ./$<

$(DISTDIR)/lmi.html: lmi.cc
	$(EMXX) -g -O0 -fdebug-compilation-dir=. -o $@ ./$<

$(DISTDIR)/lmi-primitives.html: lmi-primitives.cc
	$(EMXX) -g -O0 -fdebug-compilation-dir=. -o $@ ./$<

$(DISTDIR)/lmi-structs-classes.html: lmi-structs-classes.cc
	$(EMXX) -g -O0 -fdebug-compilation-dir=. -o $@ ./$<

$(DISTDIR)/mandelbrot.html: mandelbrot.cc
	$(EMXX) -g -s USE_SDL=2 -s ALLOW_MEMORY_GROWTH=1 -fdebug-compilation-dir=. -o $@ $<

$(DISTDIR)/simd.html: simd.c
	$(EMCC) -g -msimd128 -fdebug-compilation-dir=. -o $@ ./$<

$(DISTDIR)/stepping-with-state.js: stepping-with-state.c
	$(EMCC) -gsource-map --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/stepping-with-state-and-threads.js: stepping-with-state-and-threads.c
	$(EMCC) -gsource-map -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=1 --source-map-base $(SOURCE_MAP_BASE) -o $@ ./$<

$(DISTDIR)/stepping-with-state-and-threads-sourcemaps-proxytopthread.js: stepping-with-state-and-threads.c
	$(EMCC)  -gsource-map -s USE_PTHREADS=1 -s PROXY_TO_PTHREAD --source-map-base $(SOURCE_MAP_BASE) -o $@ $<

$(DISTDIR)/stepping-with-state-and-threads-proxytopthread.js: stepping-with-state-and-threads.c
	$(EMCC)  -g -s USE_PTHREADS=1 -s PROXY_TO_PTHREAD -fdebug-compilation-dir=.  -o $@ $<

$(DISTDIR)/string.html: string.cc
	$(EMXX) -g -fno-limit-debug-info -fdebug-compilation-dir=. -O0 -o $@ $<

$(DISTDIR)/crbug-1234784.html: crbug-1234784.cc
	$(EMXX) -fdebug-compilation-dir=. -gseparate-dwarf=$(DISTDIR)/crbug-1234784.debug.wasm $(EMCCDWARF5FLAGS) -O1 -o $@ $<
	$(LLVMDWP) -e=$(DISTDIR)/crbug-1234784.debug.wasm -o=$(DISTDIR)/crbug-1234784.debug.wasm.dwp
	rm crbug-1234784.dwo

$(DISTDIR)/stepping-with-state-and-threads-proxytopthread.html: stepping-with-state-and-threads-sourcemaps-proxytopthread.html
	cp $< $@

$(DISTDIR)/tail-call-inlining.html: tail-call-inlining.c
	$(EMCC) -g -fdebug-compilation-dir=. -O0 -o $@ $<

$(DISTDIR)/netlify.toml: netlify.toml
	cp $< $@

start: all
	python3 -m http.server --directory $(DISTDIR) 4000

clean:
	@rm -rf $(DISTDIR) *.dwo *.o
