#!/bin/bash

apt update && curl https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null |  apt-key add - &&  apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ focal main' &&  apt update &&  apt install -y cmake --no-install-recommends``
apt install clang clang-format-10 clang-tidy-10 libeigen3-dev unzip

apt install -y python3-venv pip python3-gdal
