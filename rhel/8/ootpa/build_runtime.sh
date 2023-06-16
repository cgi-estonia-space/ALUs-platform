#!/bin/bash

set -ex

docker login
docker build "$@" -t cgialus/alus-ootpa-runtime:latest -f runtime.Dockerfile .
docker tag cgialus/alus-ootpa-runtime:latest cgialus/alus-ootpa-runtime:latest
docker push cgialus/alus-ootpa-runtime:latest

