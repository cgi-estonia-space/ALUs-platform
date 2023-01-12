#!/bin/bash

set -e

apt update
apt install -y cmake git
apt install -y clang clang-format clang-tidy libeigen3-dev unzip

apt install -y python3-venv python3-pip python3-gdal python3-tk
