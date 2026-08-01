#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
# shellcheck source=/dev/null
# shellcheck disable=2034

# script performs a wrapper to sudo


# gives a process super user privileges
run_privileged() {
    # control user decision
    if ! sudo -n true 2> /dev/null; then 
        read -rp "Process requires super user privileges: proceed with sudo? [y/n]: " response
        if [[ $response =~ ^[Yy]$ ]]; then
            sudo "$@"
            return $?
        else 
            printf "permission denied -- process aborted\n" >&2
            return 1
        fi
    else
        sudo "$@"
        return $?
    
    fi
}

# remove sudo privileges
kill_sudo() {
    if sudo -n true 2> /dev/null; then
        sudo -k
        clear
    fi
    return $?
}