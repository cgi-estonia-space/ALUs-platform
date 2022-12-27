#!/bin/bash

apt update &&  apt install -y --no-install-recommends software-properties-common curl ca-certificates &&  curl https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null |  apt-key add - &&  apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ focal main' &&  apt-get update &&  apt install -y cmake --no-install-recommends &&  apt-get clean

apt-get update &&  apt-get install -y --no-install-recommends clang unzip gdal-bin libgdal-dev libboost-program-options-dev libboost-date-time-dev libboost-iostreams-dev libboost-log-dev libeigen3-dev zlib1g-dev clang-format clang-tidy wget &&  apt-get -y autoremove &&  apt-get clean

apt install -y python3-venv pip
