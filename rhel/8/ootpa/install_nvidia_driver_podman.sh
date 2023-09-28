#!/bin/bash

set -e

dnf update

# https://www.redhat.com/en/blog/how-use-gpus-containers-bare-metal-rhel-8
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum -y install kernel-devel kernel-headers dkms

curl https://us.download.nvidia.com/tesla/515.105.01/nvidia-driver-local-repo-rhel8-515.105.01-1.0-1.x86_64.rpm --output nvidia-driver-local-repo-rhel8-515.105.01-1.0-1.x86_64.rpm
rpm -i nvidia-driver-local-repo-rhel8-515.105.01-1.0-1.x86_64.rpm
yum clean all
yum install cuda-drivers

# Check if works
nvidia-smi

yum -y install podman

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
yum install -y nvidia-container-toolkit

# For Podman, NVIDIA recommends using CDI for accessing NVIDIA devices in containers.
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html
nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
nvidia-ctk cdi list

# Check if works
podman run --rm --device nvidia.com/gpu=all --security-opt=label=disable ubuntu nvidia-smi -L
