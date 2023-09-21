#!/bin/bash

set -e

dnf update -y
dnf install -y boost1.78-devel cmake unzip git

curl https://gitlab.com/libeigen/eigen/-/archive/3.3.7/eigen-3.3.7.zip --output /tmp/eigen-3.3.7.zip
cd /tmp
unzip eigen-3.3.7.zip
cd eigen-3.3.7
cmake -B build .
cd build
make install

