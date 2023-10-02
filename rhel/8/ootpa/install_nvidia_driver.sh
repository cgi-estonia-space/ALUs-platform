#!/bin/bash

set -e

dnf update

# https://www.redhat.com/en/blog/how-use-gpus-containers-bare-metal-rhel-8
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum install -y kernel-devel kernel-headers dkms

curl https://us.download.nvidia.com/tesla/515.105.01/nvidia-driver-local-repo-rhel8-515.105.01-1.0-1.x86_64.rpm --output /tmp/nvidia-driver-local-repo-rhel8-515.105.01-1.0-1.x86_64.rpm
rpm -i /tmp/nvidia-driver-local-repo-rhel8-515.105.01-1.0-1.x86_64.rpm
yum clean all
yum install -y cuda-drivers

nvidia-modprobe && nvidia-modprobe -u

