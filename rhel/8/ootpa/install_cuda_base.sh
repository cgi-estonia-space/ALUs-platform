#!/bin/bash

set -e

# Prerequisite is the NVIDIA driver installation script!

yum install -y cuda-11-2

echo "export PATH=/usr/local/cuda/bin:${PATH}" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}" >> ~/.bashrc
