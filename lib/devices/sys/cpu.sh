#!/usr/bin/env bash
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

get_cpu_usage() {
    local interval=${1:-1}  # default 1s but might be chnged 
    local total_time=$(cat /proc/stat | grep -iw "^cpu" | 
    awk 'BEGIN {sum=0} 
        {for(i=2; i<=NF; i++){sum = sum + $i} 
        {printf "%d", sum}  }
    ')

    local idle_time=$(cat /proc/stat | grep -iw "^cpu" | awk '{print $4 + $5}') 
    local working_time=$(( $total_time - $idle_time ))

    sleep 1

    local total_time2=$(cat /proc/stat | grep -iw "^cpu" | 
    awk 'BEGIN {sum=0} 
        {for(i=2; i<=NF; i++){sum = sum + $i} 
        {printf "%d", sum}  }
    ')

    local idle_time2=$(cat /proc/stat | grep -iw "^cpu" | awk '{print $4 + $5}') 
    local working_time2=$(($total_time2 - $idle_time2))

    working_delta=$(( $working_time2 - $working_time ))
    total_delta=$(( $total_time2 - $total_time ))
    
    local usage_percent=$(bc -q <<< "scale=2; 100 * $working_delta / $total_delta")

    echo "$usage_percent%"

}
get_load_average() {
    local load="$(cat $LOAD_INFO_FILE | awk '{print $1 $2 $3}')"
    printf "%s" "$load"
}
get_cpu_status() {
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

