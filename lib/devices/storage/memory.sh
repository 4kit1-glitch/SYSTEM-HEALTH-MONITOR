#!/usr/bin/env bash

# script carries functions that work with system memory info and test
# ext stands for extended

#----------- Getters --------------------------

#---------------RAM-----------------------------
# quick details about ram 
get_short_ram_info() {
    local short_ram_info="$(
        free -h | sed -n '/Mem/p' | 
        awk '{ printf "total: %10s\nused: %11s\navailable: %6s", $2, $3, $7 end}' | 
        sed 's/Gi/Gb/'
    )"
    
    printf "%s\n" "$short_ram_info"
}

# full details about ram
get_full_ram_info() {
    local -r PARAMETERS=8

    run_privileged dmidecode -t memory | sed -E -n -f "$FEATURE_DIR/full_ram.sed" |
    awk 'BEGIN {printf "memory devices found \n"} NR % 8== 1 {print "----- Device" ++n " -----"} { print }'

    return $?
}

#------------------ CACHE-------------------------

# quick info on the cache
get_short_cache_info() {
    short_cache_info="$(
        free -h | grep -Ei "Mem" | awk '{ printf "cache memory: %s\n", $6 }' | sed  s/Gi/Gb/
    )"
    printf "%s\n" "$short_cache_info"
}

# deep cpu cache details
get_ext_cache_info() {

    printf "%s\ncpu cache info\n%s\n" "$(get_short_cache_info)" \
    "$(lscpu | sed -E -n '/^L[[:digit:]]i?d?/p')"
    return $?
}

# ---------------- processes --------------------------
generate_memory_summary() {
    
    return 0
}