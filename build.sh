#!/bin/bash

EMSCRIPTEN_VERSION="3.1.14"

TEMPDIR=`mktemp -d`
(cd ${TEMPDIR} &&
 git clone https://github.com/emscripten-core/emsdk.git &&
 cd emsdk &&
 ./emsdk install ${EMSCRIPTEN_VERSION} &&
 ./emsdk activate ${EMSCRIPTEN_VERSION}) || exit $?
source ${TEMPDIR}/emsdk/emsdk_env.sh
export LLVMDWP=${TEMPDIR}/emsdk/upstream/bin/llvm-dwp
make || exit $?
rm -rf ${TEMPDIR}
