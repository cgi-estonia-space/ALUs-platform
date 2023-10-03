#!/bin/bash

set -e

# If one does dnf/yum update/upgrade then most probably the drivers need to be reinstalled/built
# because of the kernel version mismatch

# For fresh system one might like to run `dnf update -y` after which restart is required in order to continue.
# Also check if there are devices available - `lspci | grep -i nvidia`

if lsmod | grep -q "nouveau"; then
    echo "WARNING: nouveau is active, exiting installation"
    exit 1
fi

# Commands from https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html
yum install -y gcc
dnf install -y kernel-devel-$(uname -r) kernel-headers-$(uname -r)

dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
set +e
rpm --erase gpg-pubkey-7fa2af80*
set -e
distro="rhel8"
arch="x86_64"
dnf config-manager -y --add-repo https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-$distro.repo
dnf clean expire-cache
dnf module install -y nvidia-driver:latest-dkms

echo "Pleare reboot the system before continuing interaction with NVIDIA GPU"

# After reboot to check if it works - `nvidia-smi`

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
