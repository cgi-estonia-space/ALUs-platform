#!/bin/bash

set -e

apt update
apt install -y gcc g++ software-properties-common
# From https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_network
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
dpkg -i cuda-keyring_1.0-1_all.deb
apt update
apt install -y cuda-compiler-11-2 cuda-libraries-dev-11-2
echo "" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-11.2/lib64/:$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export PATH=/usr/local/cuda-11.2/bin/:$PATH" >> ~/.bashrc

