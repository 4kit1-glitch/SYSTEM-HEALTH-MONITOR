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
                    awk '{ printf "total: %10s\nused: %11s\navailable: %6s", $2, $3, $7 end}' | 
                    sed 's/Gi/Gb/')"
                
                ;;
            "ROM")
                # process short rom info
                # non existent - shift to bios info
                ;;

            "cache")
                # get cache info 
                cache_info="$(free -h | sed -n '/Mem/p' | 
                awk '{ printf "cached ram: %7s", $6}' | sed 's/Gi/Gb/g')"
                ;;

            "secondary")
                short_str_info="$(lsblk -d -o NAME,SIZE,TYPE)"
                echo $short_str_info
                ;;
            "cpu")
                # short cpu info
                short_cpu_info="$(lscpu | grep "Model name" |
                awk '{ print $0 "\ngeneration: " $3 "\nprocessing speed: " $9 "\nmanufacturer: " $5$6 "\nversion: "$7}')"
                echo $short_cpu_info
                ;;
            "gpu")
            
                ;;
            esac
        shift
    done
}

get_mem_info cpu