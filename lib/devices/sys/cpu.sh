#!/usr/bin/env bash
#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
# shellcheck source=/dev/null
#

readonly CPU_INFO_FILE="/proc/cpuinfo"

get_cpu_model_info() {
    local model_name=$(cat $CPU_INFO_FILE | grep -i "model name" | awk -F':' '{print $2}' | head -1)
    printf "%s" "$model_name"
}

get_cpu_cores() {
    local core_count=$(cat $CPU_INFO_FILE | grep -ci "processor")
    printf "%s" "$core_count"
}
get_cpu_speed() {

}
get_cpu_usage() {

}
get_load_average() {

}
get_cpu_status() {

}
get_running_processes() {

}
get_total_processes() {

}