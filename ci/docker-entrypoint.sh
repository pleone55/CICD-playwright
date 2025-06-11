#!/usr/bin/env bash

if [ -z "$1" ]; then
    /usr/bin/node
else
    if [[ "$1" == "node" ]] || [[ "$1" == "npm" ]] || [[ "$1" == "npx" ]] || [[ "$1" == "sh" ]] || [[ "$1" == "bash" ]]; then
        $@
    else
        /usr/bin/node "$@"
    fi
fi