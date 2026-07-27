#!/usr/bin/env bash


# -------- vars --------------


#------------ Getters --------------
get_short_cpu_info() {
    if lscpu &> /dev/null; then
        lscpu | grep -E 'Model name|Socket|CPU\(s\)|Thread|Core|NUMA node\(s\)' | 
        awk -F: '{print $1 ": " $2}' | sed 's/^[ \t]*//'
        return 0
    else
        echo "lscpu command not found."
        return 1
    fi
}

get_extended_cpu_info() {
    
    local -ri total_cpus=$(lscpu | grep -E "^CPU\(s\):" | awk '{print $2}')
    echo "Total CPUs: $total_cpus"
    if [[ -f /proc/cpuinfo ]]; then
        cat /proc/cpuinfo | sed -E -n -f "$FEATURE_DIR/full_cpu.sed" | 
        awk 'BEGIN {PARAMETERS=13; printf "Full CPU Info:\ntotal CPUs: \n"} NR % PARAMETERS == 1 {print "----- CPU" ++n " -----"} { print }'
        return 0
    else
        echo "/proc/cpuinfo file not found."
        return 1
    fi
}