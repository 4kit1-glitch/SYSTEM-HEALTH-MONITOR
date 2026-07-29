#!/usr/bin/env bash

# ---------------vars-------------------

# array variable that stores the required dependencies of the program
declare -r  required_deps=(
    "sed" "awk" "grep" "wc" "free"
    "dmidecode" "lscpu" "lsblk" "cat"
    "ls" "cd" "pwd" "dirname" "pactl"
    "aplay"
)

declare -a missing_deps

get_missing_deps() {
    # function gets missing dependencies
    for dep in "${required_deps[@]}"; then
        
        
        
}

