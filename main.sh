#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
# shellcheck source=/dev/null
# shellcheck disable=2034,2155
#
# Syskit: A system health monitor built in bash version 5.3+
# https://github.com/4kit1-glitch/syskit
#
#

readonly version=0.0.1


sys_locale=${LANG:-C}

# Speed up script by not using unicode.
LC_ALL=C
LANG=C

# at the moment config files will be stored in shm folder for testing purposes

export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${SCRIPT_DIR}/.config}
PATH=$PATH:/usr/xpg4/bin:/usr/sbin:/sbin:/usr/etc:/usr/libexec

shopt -s nocasematch

set -euo pipefail

export CORE_DIR="$SCRIPT_DIR/lib/core"
export DEVICE_DIR="$SCRIPT_DIR/lib/devices"
export FEATURE_DIR="$SCRIPT_DIR/features"

# ----------------------- source scripts ---------------------

# source core scripts
for script in "$CORE_DIR"/*.sh; do
    echo "$script"
done

# checking program dependencies

# source device scripts
for dir in $DEVICE_DIR/*; do 
    for script in $dir/*.sh; do
        source $script
    done
done