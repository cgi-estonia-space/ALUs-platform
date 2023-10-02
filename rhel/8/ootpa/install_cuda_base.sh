#!/bin/bash

set -e

if [ ! -e "/etc/yum.repos.d/cuda.repo" ]; then
    # From https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/11.2.2/ubi8/base
    CUDA_REPO_DECLARATION="[cuda]
    name=cuda
    baseurl=https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64
    enabled=1
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA"

    echo "$CUDA_REPO_DECLARATION" > /tmp/cuda.repo
    mv /tmp/cuda.repo /etc/yum.repos.d/cuda.repo

    NVIDIA_GPGKEY_SUM=d0664fbbdb8c32356d45de36c5984617217b2d0bef41b93ccecd326ba3b80c87
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/D42D0685.pub | sed '/^Version/d' > /tmp/RPM-GPG-KEY-NVIDIA
    cp /tmp/RPM-GPG-KEY-NVIDIA /etc/pki/rpm-gpg/.
    echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -
fi

CUDA_VERSION="11.2.2"
NV_CUDA_CUDART_VERSION="11.2.152-1"

yum install -y \
    cuda-cudart-11-2-${NV_CUDA_CUDART_VERSION} \
    cuda-compat-11-2 \
    && ln -s cuda-11.2 /usr/local/cuda \
    && yum clean all \
    && rm -rf /var/cache/yum/*


# From https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.2.2/ubi8/runtime/Dockerfile
NV_CUDA_LIB_VERSION="11.2.2-1"
NV_LIBNPP_VERSION="11.3.2.152-1"
NV_LIBNPP_PACKAGE="libnpp-11-2-${NV_LIBNPP_VERSION}"
NV_LIBCUBLAS_VERSION="11.4.1.1043-1"

yum install -y \
    cuda-libraries-11-2-${NV_CUDA_LIB_VERSION} \
    ${NV_LIBNPP_PACKAGE} \
    libcublas-11-2-${NV_LIBCUBLAS_VERSION} \
    && yum clean all \
    && rm -rf /var/cache/yum/*

echo "export PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64" >> ~/.bashrc
