#!/bin/sh
cd "$(dirname "$0")" || exit 1
exec node bin/diff-vtuberv2.mjs "$@"
