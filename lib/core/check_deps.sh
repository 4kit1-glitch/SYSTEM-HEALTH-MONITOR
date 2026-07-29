#!/usr/bin/env bash

# script check if program dependencies are installed


# ---------------vars-------------------

# array variable that stores the required dependencies of the program
declare -r  required_deps=(
    "sed" "awk" "grep" "wc" "free"
    "dmidecode" "lscpu" "lsblk" "cat"
    "ls" "cd" "pwd" "dirname" "pactl"
    "aplay" "upower"
)
required_count=${#required_deps[@]}

declare -a missing_deps     # variable stores the missing dependencies

#---------- getters -----------------
get_missing_deps() {
    # function gets missing dependencies
    for dep in "${required_deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    [[${#missing_deps[@]} -eq 0 ]] && return 0 || return 1
}
