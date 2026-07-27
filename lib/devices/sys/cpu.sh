#!/usr/bin/env bash


# -------- vars --------------
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