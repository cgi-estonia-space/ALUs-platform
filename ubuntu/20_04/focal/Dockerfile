FROM nvidia/cuda:11.4.2-devel-ubuntu20.04

# for tzdata installation - https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND=noninteractive

# For CMake 3.22, since default 3.16 does not support CMAKE_CUDA_ARCHITECTURES (which is supported since 3.18)
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common curl ca-certificates && \
    curl https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
    apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get purge --autoremove -y curl && \
    apt-get update && apt install -y cmake --no-install-recommends && apt-get -y autoremove && apt-get clean

RUN apt-get update && apt-get install -y --no-install-recommends \
    clang \
    unzip \
    gdal-bin libgdal-dev \
    libboost-program-options-dev libboost-date-time-dev \
    libboost-iostreams-dev libboost-log-dev \
    libeigen3-dev zlib1g-dev git clang-tidy clang-format parallel wget \
    python3-tk && \
    apt-get -y autoremove && apt-get clean


