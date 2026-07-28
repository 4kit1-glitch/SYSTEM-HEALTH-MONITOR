#!/usr/bin/env bash


#---------- vars ------------
declare -r POWER_SUPPLY_DIR="/sys/class/power_supply"

declare -r ac_count=$(ls -ld $POWER_SUPPLY_DIR/ADP* 2> /dev/null | wc -l)
declare -r battery_count=$(ls -ld $POWER_SUPPLY_DIR/BAT* 2> /dev/null | wc -l)


#--------- getters ----------------

get_battery_info(){
    printf "Power devices:\n"
    printf "ac source num: %d\nnumber of batteries: %d\n" "$ac_count" "$battery_count"

    for device in "$POWER_SUPPLY_DIR/*"; do
        echo $device
        if [[ $type == "Baterry" ]]; then   # this has not been
            printf "Capacity: %s\%" "$(cat "$device/capacity")"
            printf "Status: %s\%" "$(cat "$device/status")"
            return 0
        elif [[ $type == "Mains" ]]; then   # show that source is alternating current
            printf "status: %s\%" "$(cat "$device/online")"
            return 0
        else 
            printf "files missing"
            return 1
        fi
    done
}

get_battery_info