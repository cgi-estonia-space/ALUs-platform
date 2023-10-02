#!/bin/bash

set -e

dnf update

# https://www.redhat.com/en/blog/how-use-gpus-containers-bare-metal-rhel-8
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum install -y kernel-devel kernel-headers dkms acpid

# This is one of the many options. Via this repo, always the latest driver,
# with all the complete modules (including CUDA SDK).
# Also it seems to be performing tasks in the background that ensures the complete setup
# From https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/11.2.2/ubi8/base
CUDA_REPO_DECLARATION="[cuda]
name=cuda
baseurl=https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA"

echo "$CUDA_REPO_DECLARATION" > /tmp/cuda.repo
mv /tmp/cuda.repo /etc/yum.repos.d/cuda.repo

modprobe -r nouveau

NVIDIA_GPGKEY_SUM=d0664fbbdb8c32356d45de36c5984617217b2d0bef41b93ccecd326ba3b80c87
curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/D42D0685.pub | sed '/^Version/d' > /tmp/RPM-GPG-KEY-NVIDIA
cp /tmp/RPM-GPG-KEY-NVIDIA /etc/pki/rpm-gpg/.
echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -

yum install -y cuda-drivers

# Check if it works
nvidia-smi

# Troubleshoot
# lsmod | grep "nouveau" > /dev/null && echo "WARNING: nouveau still active" || echo "Success"
# if active then
# sudo rmmod nouveau

# modprobe -r nouveau
# or
# cat <<EOF | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
# blacklist nouveau
# options nouveau modeset=0
# EOF

# lspci | grep -e VGA -ie NVIDIA


