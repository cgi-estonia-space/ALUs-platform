#!/bin/bash

set -e

apt update
apt install gpg
# From https://apt.kitware.com/
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null
apt update
apt install -y cmake --no-install-recommends``
apt install -y clang clang-format-10 clang-tidy-10 libeigen3-dev unzip

apt install -y python3-venv pip python3-gdal
