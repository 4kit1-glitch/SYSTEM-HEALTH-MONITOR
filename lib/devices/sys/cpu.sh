#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
# shellcheck source=/dev/null
# shellcheck disable=2155

# static info
readonly CPU_INFO_FILE="/proc/cpuinfo"
readonly LOAD_INFO_FILE="/proc/loadavg"
readonly CPU_USAGE_FILE="/proc/stat"
readonly THERMAL_INFO_FILE="/sys/class/thermal"

get_cpu_model_info() {
    [[ -f "$CPU_INFO_FILE" ]] && {
        local model_name="$(cat $CPU_INFO_FILE | \
        grep -i "model name" | \
        awk -F':' '{print $2}' | head -1)"
    }
    printf "%s" "$model_name"
}

get_cpu_cores() {
    local core_count=$(cat $CPU_INFO_FILE | grep -ci "processor")
    printf "%s" "$core_count"
}

## refactor code and use read to set values 
get_cpu_usage() {
    local -r interval=1

    read -r total_time1 idle_time1 < <( \
        awk 'BEGIN {sum=0} 
            /^cpu /{for(i=2; i<=NF; i++){sum += $i} 
            {printf "%d %d", sum, $5+$6}  }
            ' \
        $CPU_USAGE_FILE)

    sleep "$interval"

    read -r total_time2 idle_time2 < <( \
        awk 'BEGIN {sum=0} 
            /^cpu /{for(i=2; i<=NF; i++){sum += $i} 
            {printf "%d %d", sum, $5+$6}  }
            ' \
        $CPU_USAGE_FILE)
    
    local total_delta=$(( total_time2 - total_time1 ))
    local idle_delta=$(( idle_time2 - idle_time1 ))
    local working_time=$(( total_delta - idle_delta ))
    local usage=$( bc -q <<< "scale=2; 100 * $working_time / $total_delta" )

    echo "usage: $usage%"
}
get_load_average() {
    local load="$(cat $LOAD_INFO_FILE | awk '{print $1 $2 $3}')"
    printf "%s" "$load"get_cpu_usage
}
get_most_used_core() {
    echo pass

}
get_running_processes() {
    echo pass
}
get_total_processes() {
    echo pass
}
get_system_uptime() {
    echo pass
}