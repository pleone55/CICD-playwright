#!/usr/bin/env bash

if [ -z "$1" ]; then
    /usr/local/bin/node
else
    if [[ "$1" == "node" ]] || [[ "$1" == "npm" ]] || [[ "$1" == "npx" ]] || [[ "$1" == "sh" ]] || [[ "$1" == "bash" ]]; then
        $@
    else
        /usr/local/bin/node "$@"
    fi
fi