#!/bin/bash

set -ex

docker login
docker build "$@" -t cgialus/alus-focal-jupyter:latest -f jupyter.Dockerfile .
docker tag cgialus/alus-focal-jupyter:latest cgialus/alus-focal-jupyter:latest
docker push cgialus/alus-focal-jupyter:latest
