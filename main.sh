#!/bin/env bash

# system health monitor

set -euo pipefail


#----------------------- GLOBAL VARS--------------------


# ---------- GETTERS ---------------------------------

get_mem_info() {
    local storage_terms=("RAM" "ROM" "SSD" "HDD" "CACHE" "SWAP")
    declare -A mem_info

    while (( $# )); do
        for (( i=0; i < ${#storage_terms[@]}; i++ )); do
            case $1 in
                ${storage_terms[1]})
                    full_ram_info=""
                    short_ram_info=$(free -h | sed -n '/Mem/p' | awk '{ printf "total: %10s\nused: %11s\navailable: %6s\n", $2, $3, $7 }' | sed 's/Gi/Gb/')
                    echo "$short_ram_info"

}

get_battery_info() {

}

get_cpu_info() {

}

get_gpu_info() {

}

#----------- INFO PROCESSORS -----------------
info_processor() {
    
}