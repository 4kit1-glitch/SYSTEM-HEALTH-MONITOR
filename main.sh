#!/bin/env bash

# system health monitor

set -euo pipefail


#----------------------- GLOBAL VARS--------------------


# ---------- GETTERS ---------------------------------

get_mem_info() {
    declare -A mem_info

    while (( $# )); do
        case $1 in
            "RAM")
                # process full ram info
                full_ram_info=""

                # process short ram info
                short_ram_info="$(free -h | sed -n '/Mem/p' | 
                    awk '{ printf "total: %10s\nused: %11s\navailable: %6s\n", $2, $3, $7 end}' | 
                    sed 's/Gi/Gb/')"
                
                ;;
            "ROM")
                # process short rom info
                # non existent - shift to bios info
                
            esac
        shift
    done
}

get_mem_info