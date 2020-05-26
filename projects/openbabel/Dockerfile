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

FROM gcr.io/oss-fuzz-base/base-builder
MAINTAINER geoff.hutchison@gmail.com
RUN apt-get update && apt-get install -y make cmake wget \
    zlib1g-dev rapidjson-dev libeigen3-dev libxml2-dev \
    libboost-dev \
    libboost-program-options-dev \
    libboost-iostreams-dev \
    libboost-regex-dev \
    libcairo2-dev
RUN git clone --depth 1 https://github.com/openbabel/openbabel.git openbabel
WORKDIR openbabel
COPY build.sh *.cc $SRC/
