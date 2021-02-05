#!/bin/bash
set  -xeuo pipefail
IFS=$'\n\t'

PACKAGES=(
    "k8s.io/api/core/v1"
    "k8s.io/api/apps/v1"
)

go get -v ${PACKAGES[@]}
cue get go -v ${PACKAGES[@]}