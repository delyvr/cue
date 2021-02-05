#!/bin/bash
set  -xeuo pipefail
IFS=$'\n\t'

PACKAGES=(
    "k8s.io/api/core/v1"
    "k8s.io/api/apps/v1"
)

rm -rf ./k8s ./time ./cue.mod/gen

go get -v ${PACKAGES[@]}
cue get go -v ${PACKAGES[@]} || true

mv "./cue.mod/gen/k8s.io" "./cue.mod/gen/k8s"

find ./cue.mod/gen -name '*.cue' -exec sed -i '' -e 's#k8s.io/#github.com/delyvr/cue/k8s/#g' {} \;
find ./cue.mod/gen -name '*.cue' -exec sed -i '' -e 's#// Code generated by cue get go. DO NOT EDIT.#// Code generated by generate.sh. DO NOT EDIT.#g' {} \;
find ./cue.mod/gen -name '*.cue' -exec sed -i '' -e '/cue:generate/d' {} \;

mv ./cue.mod/gen/* .
rm -rf ./cue.mod/gen/