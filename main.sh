#!/bin/env bash

# system health monitor

set -euo pipefail


#----------------------- GLOBAL VARS--------------------


# ---------- GETTERS ---------------------------------

get_mem_info() {
    declare -A mem_info

    while (( $# )); do
        case $1 in
            "${storage_terms[0]}")
                full_ram_info=""

                # process short ram info
                short_ram_info="$(free -h | sed -n '/Mem/p' | 
                    awk '{ printf "total: %10s\nused: %11s\navailable: %6s\n", $2, $3, $7 end}' | 
                    sed 's/Gi/Gb/')"
                echo "$short_ram_info"
                
                ;;
            esac

        shift
    done
}

get_mem_info RAM