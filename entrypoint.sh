#!/bin/bash

set -eE

cd "$(dirname "$0")"

PREFIX=/var/lib/openmldb

if [ ! -d "$PREFIX" ]; then
    mkdir -p "$PREFIX"
fi

exec /opt/openmldb/bin/openmldb \
    --db_root_path="$PREFIX/db" \
    --recycle_bin_root_path="$PREFIX/recycle" \
    --hdd_root_path="$PREFIX/db_hdd" \
    --recycle_bin_hdd_root_path="$PREFIX/recycle_hdd" \
    --ssd_root_path="$PREFIX/db_ssd" \
    --recycle_bin_ssd_root_path="$PREFIX/recycle_ssd" \
    "$@"
