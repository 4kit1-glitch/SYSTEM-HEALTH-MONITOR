#!/usr/bin/env bash

# script performs a wrapper to sudo

# the is_privileged var works with 1 or 0 -- 0 for no 1-255 for yes
declare -i is_privileged=0

# gives a process super user privileges
run_privileged() {
    # control user decision
    if sudo -n true 2> /dev/null; then 
        read -rp "Process requires super user privileges: proceed with sudo? [y/n]: " response

        if [[ $response =~ ^[Yy]$ ]]; then
            sudo "$@"
            is_privileged=1
            return $?
        else 
            printf "permission denied -- process aborted" >&2
            is_privileged=0
            return 1
        fi
    elif [[ ($is_privileged == 0) ]]; then
        sudo "$@"
        return $?
    fi
}

# remove sudo privileges
kill_sudo() {
    [[ $EUID -eq 0 ]] && sudo -k
    return $?
}