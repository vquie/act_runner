#!/bin/bash

set -eu

_INSTANCE=${ACT_INSTANCE:?instance missing}
_TOKEN=${ACT_TOKEN:?token missing}
_LABELS=${ACT_LABELS:-"ubuntu-latest:docker://node:16-bullseye,ubuntu-22.04:docker://node:16-bullseye,ubuntu-20.04:docker://node:16-bullseye,ubuntu-18.04:docker://node:16-buster"}

echo "wait for docker to become available"
while ! docker --host localhost:2375 ps -a > /dev/null; do sleep 1; done

/usr/local/bin/act_runner register \
    --instance ${_INSTANCE} \
    --token ${_TOKEN} \
    --labels ${_LABELS} \
    --no-interactive

/usr/local/bin/act_runner daemon