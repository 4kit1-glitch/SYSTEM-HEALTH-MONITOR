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
    local -ri TOTAL_MEM_DEVICES="$(
        run_privileged dmidecode -t memory | 
        grep -Ei "Number of devices" | awk '{ print $4}'
    )"

    run_privileged dmidecode -t memory | sed -E -n -f "$FEATURE_DIR/full_ram.sed" |
    awk 'NR%8==1 {print "----- device" ++n " ----"} 1'

    return $?
}

#------------------ CACHE-------------------------

# quick info on the cache
get_cache_info() {
    free -
}

# deep cpu cache details
get_ext_cache_info() {
    return 0
}

# ---------------- processes --------------------------
generate_memory_summary() {
    return 0
}