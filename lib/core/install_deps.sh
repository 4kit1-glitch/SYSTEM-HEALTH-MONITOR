#!/usr/bin/env bash

# script does procedues to install missing dependencies
# script runs from main.sh so running from here will cause a path failure

declare -r PACKAGE_MANAGERS=(
    "apt" "dnf" "yum" "pacman" "zypper" "emerge"
    "apk" "nix" "snap" "flatpak"
)

# stores info of main package manager
os_pkg_manager=""

get_pkg_manager() {
    for pkg in ${PACKAGE_MANAGERS[@]}; do 
        if command -v "$pkg" &> /dev/null; then
            os_pkg_manager="$pkg"
            return 0
        fi
    done
    printf "unknown package manager aborting...../n" >&2
    printf "pls add package manager to shm open source project/n" >&2
    exit 1
}

install_missing_deps() {
    for dep in "${missing_deps[@]}";
        case $os_pkg_manager in
            "apt") run_privileged apt install $dep;;
            "dnf") run_privileged dnf install $dep;;
            "yum") # to be filled;;
            "rpm") # to be filled;;
            "yum") # to be filled;;
            *) echo package not handled   ;;



}