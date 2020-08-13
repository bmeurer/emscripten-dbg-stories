#!/bin/bash

EMSCRIPTEN_VERSION="1.40.1"

TEMPDIR=`mktemp -d`
(cd ${TEMPDIR} &&
 git clone https://github.com/emscripten-core/emsdk.git &&
 cd emsdk &&
 ./emsdk install ${EMSCRIPTEN_VERSION} &&
 ./emsdk activate ${EMSCRIPTEN_VERSION}) || exit $?
source ${TEMPDIR}/emsdk/emsdk_env.sh
make || exit $?
rm -rf ${TEMPDIR}
