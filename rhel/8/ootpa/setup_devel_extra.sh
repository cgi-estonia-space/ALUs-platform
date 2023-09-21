#!/usr/bin/bash

set -e

#pip3 install GDAL==3.0.4

mkdir /root/.aws
touch /root/.aws/credentials

mkdir /alus

git clone https://github.com/cgi-estonia-space/skript
mv skript /alus/.

cd /alus/skript
pip3 install -r requirements.txt

cd /alus
git clone https://github.com/cgi-estonia-space/rastcomp
cd /alus/rastcomp && cmake -B build . && cd build && make

ln -s /alus/rastcomp/build/rastcomp /usr/bin/rastcomp
ln -s /alus/rastcomp/gdal_compare/rast_compare.py /usr/bin/rast_compare.py
