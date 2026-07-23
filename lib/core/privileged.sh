#!/usr/bin/env bash

# script performs a wrapper to sudo

# gives a process super user privileges
run_privileged() {
    if [[ $EUID -eq 0 ]]; then
        "$@"
        return $?
    fi
    # control user decision
    read -rp "Process requires super user privileges: proceed with sudo? [y/n]: " response
    if [[ $response =~ ^[Yy]$ ]]; then 
        sudo "$@"
    else 
        printf "permission denied -- process aborted" >&2
        return 1
    fi
}

# remove sudo privileges
kill_sudo() {
    [[ $EUID -eq 0 ]] && sudo -k
    return 
}