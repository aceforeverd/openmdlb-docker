#!/bin/bash

set -eE

cd "$(dirname "$0")"

PREFIX=/var/lib/openmldb

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage() {
    echo "Usage :  $0 [options] [--] [openmldb flags]

    Options:
    -p            Prefix path for openmldb data, default to '/var/lib/openmldb'
    -h|help       Display this message"

} # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

while getopts ":hvp:" opt; do
    case $opt in

    h | help)
        usage
        exit 0
        ;;

    p) PREFIX=$(realpath "$OPTARG") ;;

    *)
        echo -e "\n  Option does not exist : $OPTARG\n"
        usage
        exit 1
        ;;

    esac # --- end of case ---
done
shift $((OPTIND - 1))

if [ ! -d "$PREFIX" ]; then
    mkdir -p "$PREFIX"
fi

exec ./bin/openmldb \
    --db_root_path="$PREFIX/db" \
    --recycle_bin_root_path="$PREFIX/recycle" \
    --hdd_root_path="$PREFIX/db_hdd" \
    --recycle_bin_hdd_root_path="$PREFIX/recycle_hdd" \
    --ssd_root_path="$PREFIX/db_ssd" \
    --recycle_bin_ssd_root_path="$PREFIX/recycle_ssd" \
    "$@"
