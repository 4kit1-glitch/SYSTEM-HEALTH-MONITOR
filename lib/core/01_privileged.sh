#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
# shellcheck source=/dev/null
# shellcheck disable=2034
#
# script performs a wrapper to sudo
# return err codes are assigned in 00_error.sh


is_root() {
    [[ $EUID -eq 0 ]] && {
        return "$ERR_SUCCESS"
    }
    return "$ERR_FAILURE"
}

is_sudo_available() {
    command -v sudo > /dev/null 2>&1 && {
        return "$ERR_SUCCESS"
    }
    return "$ERR_FAILURE"
}
is_sudo_active() {
    sudo -n true > /dev/null 2>&1 && {
        return "$ERR_SUCCESS"
    }
    return "$ERR_FAILURE"
}

# gives a process super user privileges
run_privileged() {
    # check if user runs as root 
    if is_root; then  
        "$@"
        return "$ERR_SUCCESS"   # maybe later this will be modified to show the command exit code  
    elif ( is_root || ! is_sudo_available ); then
        printf "sudo not available" >&2
        printf "run as root or set up sudo" >&2
        return "$ERR_NOT_FOUND"
    fi

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