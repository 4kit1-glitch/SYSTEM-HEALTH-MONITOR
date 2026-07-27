#!/usr/bin/env bash

# system health monitor

set -euo pipefail


#----------------------- GLOBAL VARS----------------------------
export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


export CORE_DIR="$SCRIPT_DIR/lib/core"
export DEVICE_DIR="$SCRIPT_DIR/lib/devices"
export FEATURE_DIR="$SCRIPT_DIR/features"

# ----------------------- source scripts ---------------------

# source core scripts
for script in $( ls "$CORE_DIR"); do
    source "$CORE_DIR/$script"
done

# source device scripts
for dir in $(ls "$DEVICE_DIR"); do 
    for script in $( ls "$DEVICE_DIR/$dir"); do
        source "$DEVICE_DIR/$dir/$script"
    done
done