#!/bin/bash

set -ex

docker login
docker build -t cgialus/alus-devel:latest .
#docker build -t cgialus/alus-runtime:latest -f runtime.Dockerfile .
docker tag cgialus/alus-devel:latest cgialus/alus-devel:latest
docker push cgialus/alus-devel:latest

