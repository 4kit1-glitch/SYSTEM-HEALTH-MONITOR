#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
# shellcheck source=/dev/null
# shellcheck disable=2155

# static info
readonly CPU_INFO_FILE="/proc/cpuinfo"
readonly LOAD_INFO_FILE="/proc/loadavg"
readonly CPU_USAGE_FILE="/proc/stat"
readonly UPTIME_INFO_FILE="/proc/uptime"
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
    printf "%d" "$core_count"
}

## refactor code and use read to set values 
calculate_usage() {
    local -r interval=1
    local -r item_passed=$1
    local value_tc=""

    if [[ $item_passed =~ (^cpu |^CPU |^cpu) ]]; then
        value_tc="^cpu "
    elif [[ $item_passed =~ (^cpu[0-9]+) ]]; then 
        value_tc="$item_passed"
    else
        printf "cannot calculate usage of %s not available" "$item_passed" >&2
        return "$ERR_BAD_USAGE"
    fi

    read -r total_time1 idle_time1 < <( \
        awk -v var="$value_tc" 'BEGIN {sum=0} 
            $0 ~ var {for(i=2; i<=NF; i++){sum += $i} 
            {printf "%d %d", sum, $5+$6}} # idle + iowait
            ' \
        $CPU_USAGE_FILE)

    sleep "$interval"

    read -r total_time2 idle_time2 < <( \
        awk -v var="$value_tc" 'BEGIN {sum=0} 
            $0 ~ var {for(i=2; i<=NF; i++){sum += $i} 
            {printf "%d %d", sum, $5+$6}}
            ' \
        $CPU_USAGE_FILE)
    
    local total_delta=$(( total_time2 - total_time1 ))
    local idle_delta=$(( idle_time2 - idle_time1 ))
    local working_time=$(( total_delta - idle_delta ))
    local usage=$( bc -q <<< "scale=2; 100 * $working_time / $total_delta" )

    printf "%.2f%%" "$usage"
}
get_load_average() {
    local load="$(cat $LOAD_INFO_FILE | awk '{print $1 $2 $3}')"
    printf "%s" "$load"
}

get_cpu_usage() {
    local -r usage=$(calculate_usage "cpu")
    echo -en "$usage" ## i know you might want to use printf but dont it doesnt work i dont know why
}

# this function is quite slow cause it waits the core amount times in seconds 
# might need refatoring 
get_cores_usage() {
    # actually gets the info but will process later
    local -r CORES=$(get_cpu_cores)
    local -A core_usages

    # first set core usage percentages
    for (( i=0; i<CORES; i++ )); do
        core_usages["cpu$i"]=$(calculate_usage "cpu$i")
    done

}
get_most_least_core() {
    # this doesnt fucking work 
    least_used=$( \
        awk 'BEGIN {idle = 0; max = 0} 
        /^cpu[0-9]+/ {idle=$5+$6; if(idle >= max) max=$1;  else max=max;}
        END {printf "%s", max}' $CPU_USAGE_FILE \
    )
    most_used=$( \
        awk 'BEGIN {total = 0; max = 0} /^cpu[0-9]+/ {total=$2+$3+$4; if(total >= max) max=$1; else max=max;print total -- max} END {printf "%s", max}' /proc/stat

    )

}
get_running_total() {
    # function reads processes running and total processes from loadavg
    # think its better to get them both then process at need rather than individually
    # maybe will improve later
    local running_total=$( \
        awk 'print $' $LOAD_INFO_FILE
    )
    printf "%s" "$running_total"
}

get_system_uptime() {
    uptime_value=($(cat /proc/uptime))
    days=$((uptime_value[0]*86400))
    hours=$(( (uptime_value[0]*3600) % 86400 ))
    minutes=$(( (uptime_value[0]*60) % 3600 ))
    seconds=$(( uptime_value[0] % 60 ))

    echo "$days days $hours hours $minutes minutes $seconds seconds"
    echo pass
}