#!/bin/bash -eu
# Copyright 2020 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

# Create a directory for instrumented dependencies.
MOB_DEPS=${SRC}/dep
mkdir -p $MOB_DEPS

# build libplist with proper instrumentation.
cd ${SRC}/libplist
sh ./autogen.sh --without-cython --enable-debug
./configure --prefix=${MOB_DEPS}
make -j$(nproc) clean
make -j$(nproc) all
make install

# # build libusbmuxd
cd ${SRC}/libusbmuxd
sh ./autogen.sh
./configure --prefix=${MOB_DEPS}
make -j$(nproc) clean
make -j$(nproc) all
make install

# # build libimobiledvice
cd ${SRC}/libimobiledvice
# cd libimobiledvice
# ./autogen.sh --disable-openssl
# make -j$(nproc) clean
# make -j$(nproc) all

find . -name "*.a"

# build fuzzers
# e.g.
# $CXX $CXXFLAGS -std=c++11 -Iinclude \
#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
#     $LIB_FUZZING_ENGINE /path/to/library.a
