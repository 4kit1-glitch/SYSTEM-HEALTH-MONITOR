#!/usr/bin/env bash


#---------- vars ------------
declare -r POWER_SUPPLY_DIR="/sys/class/power_supply"

declare -r ac_count=$(cat $POWER_SUPPLY_DIR/ADP* 2> /dev/null | wc -l)
declare -r battery_count=$(cat $POWER_SUPPLY_DIR/BAT* 2> /dev/null | wc -l)


#--------- getters ----------------

get_battery_info(){
    
}