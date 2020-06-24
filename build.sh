#!/bin/bash

TEMPDIR=`mktemp -d`
(cd ${TEMPDIR} &&
 git clone https://github.com/emscripten-core/emsdk.git &&
 cd emsdk &&
 ./emsdk install latest &&
 ./emsdk activate latest) || exit $?
source ${TEMPDIR}/emsdk/emsdk_env.sh
make || exit $?
rm -rf ${TEMPDIR}
