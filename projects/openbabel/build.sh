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

# build project
cmake -DBUILD_SHARED=OFF -DBUILD_MIXED=ON
make -j$(nproc)
make install

find . -name "*.a"
find . -name "babelconfig.h"
ls

# build fuzzers
for fuzzers in $(find $SRC -name '*_fuzzer.cc'); do
  fuzz_basename=$(basename -s .cc $fuzzers)
  $CXX $CXXFLAGS -std=c++11 -I. -Iinclude/ -Isrc/ \
  $fuzzers $LIB_FUZZING_ENGINE ./src/libopenbabel.a \
  -o $OUT/$fuzz_basename
done
