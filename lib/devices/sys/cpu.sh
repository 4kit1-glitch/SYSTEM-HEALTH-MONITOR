#!/usr/bin/env bash
#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
# shellcheck source=/dev/null
#

# static info
readonly CPU_INFO_FILE="/proc/cpuinfo"
readonly LOAD_INFO_FILE="/proc/loadavg
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
    local total_time
    local idle_time
    local working_time
    local usage_percent=$(bc -l <<< "scale=2 echo "100 * $working_time / $total_time"")

}
get_load_average() {
    local load=$(cat $LOAD_INFO_FILE | awk '{print $1 $2 $3}')
    printf "%s" "$load"
}
get_cpu_status() {

}
get_running_processes() {

}
get_total_processes() {

}