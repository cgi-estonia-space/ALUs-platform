#!/bin/bash

set -e

# Check if driver base is present
nvidia-smi

yum install -y podman

distro="rhel8"
arch="x86_64"
repository_name="cuda-$distro-$arch"

if sudo dnf repolist | grep -q "$repository_name"; then
    echo "Repository '$repository_name' is installed, installing nvidia-container-toolkit from there"
    # Add your actions here if the repository is installed
else
    # https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
      sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
fi

yum install -y nvidia-container-toolkit

# For Podman, NVIDIA recommends using CDI for accessing NVIDIA devices in containers.
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html
nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
nvidia-ctk cdi list

# Check if works
podman run --rm --device nvidia.com/gpu=all --security-opt=label=disable ubuntu nvidia-smi -L
