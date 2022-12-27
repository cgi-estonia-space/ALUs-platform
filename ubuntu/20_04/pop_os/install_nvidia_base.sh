#!/bin/bash

apt install system76-cuda-11.2
export LD_LIBRARY_PATH=/usr/lib/cuda/lib64:/usr/local/lib/:$LD_LIBRARY_PATH
