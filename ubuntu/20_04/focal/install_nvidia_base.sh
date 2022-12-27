#!/bin/bash

apt update
apt install -y gcc g++
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
apt update
apt -y install cuda-11-2
echo "" >> .bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export PATH=/usr/local/cuda/bin/:$PATH" >> ~/.bashrc
