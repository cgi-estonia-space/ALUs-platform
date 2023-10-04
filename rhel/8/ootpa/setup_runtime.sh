#!/bin/bash

set -e

dnf install -y gcc gcc-c++ 
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf install -y boost1.78-date-time boost1.78-log boost1.78-program-options
dnf install -y libgeotiff-devel sqlite-devel proj-devel

# Not needed for development but we intend to install gdal with python
dnf install -y python3 python3-devel

# The official version available on base RHEL 8 as well.
curl -o /tmp/gdal-3.0.4.tar.gz -L https://github.com/OSGeo/gdal/releases/download/v3.0.4/gdal-3.0.4.tar.gz 
cd /tmp
tar -xzvf /tmp/gdal-3.0.4.tar.gz
cd gdal-3.0.4
# https://github.com/OSGeo/gdal/issues/2402#issuecomment-613612096 - jasper thing
./configure --includedir=/usr/include/gdal --libdir=/usr/lib --with-python --without-jasper
make -j8
make install

rm /tmp/gdal-3.0.4.tar.gz
rm -rf /tmp/gdal-3.0.4
