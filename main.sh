#!/bin/env bash

# system health monitor

set -euo pipefail


#----------------------- GLOBAL VARS----------------------------
export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# ----------------------- source scripts ---------------------

# source core scripts
for script in "$( ls lib/core)"; do
    source "lib/core/$script"
done

echo $X