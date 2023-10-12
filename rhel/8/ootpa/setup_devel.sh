#!/bin/bash

set -e

dnf update -y
dnf install -y boost1.78-devel cmake unzip git
