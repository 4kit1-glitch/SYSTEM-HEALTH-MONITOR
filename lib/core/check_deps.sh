#!/usr/bin/env bash

# ---------------vars-------------------

# array variable that stores the required dependencies of the program
declare -r  required_deps=(
    "sed" "awk" "grep" "wc" "free"
    "dmidecode" "lscpu" "lsblk" "cat"
    "ls" "cd" "pwd" "dirname" "pactl"
    "aplay" "lllllds" "dsjfjlsdk" "diowe"
)

declare -a missing_deps
missing_count=0

get_missing_deps() {
    # function gets missing dependencies
    for dep in "${required_deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps[$missing_count]="$dep"
            (( missing_count++ ))
        fi
    done
    return $?
}