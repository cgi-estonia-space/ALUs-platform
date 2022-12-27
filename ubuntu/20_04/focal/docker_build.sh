#!/bin/bash

set -ex

docker login
docker build -t cgialus/alus-devel:latest .
docker tag cgialus/alus-devel:latest cgialus/alus-devel:latest
docker push cgialus/alus-devel:latest

