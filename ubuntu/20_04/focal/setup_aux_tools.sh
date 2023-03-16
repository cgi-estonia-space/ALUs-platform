#!/bin/bash

set -e

apt update
# Some requirements.txt might include git repositories
apt install -y git python3-venv python3-pip python3-gdal python3-tk
