#!/usr/bin/env bash


#---------- vars ------------
declare -r POWER_SUPPLY_DIR="/sys/class/power_supply"

declare -r ac_count=$(ls -ld $POWER_SUPPLY_DIR/ADP* 2> /dev/null | wc -l)
declare -r battery_count=$(ls -ld $POWER_SUPPLY_DIR/BAT* 2> /dev/null | wc -l)


#--------- getters ----------------

get_battery_info(){
    printf "Power devices:/n"
    printf "ac source num: %d\nnumber of batteries: %d" "$ac_count" "$battery_count"

    for device in "$POWER_SUPPLY_DIR/*"; do
        name=$(basename "$device")
        type=%(cat "$dev/type" 2> /dev/null)
        printf "%s : %s" "$name" "$type"

        if [[ $type == "Baterry"]]; then
            printf "Capacity: %s\%" "$(cat "$device/capacity")"
            printf "Status: %s\%" "$(cat "$device/status")"
        elif [[$type == "Mains"]]; then
            printf "status: %s\%" "$(cat "$device/online")"
}