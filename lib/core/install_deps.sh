#!/usr/bin/env bash

# script does procedues to install missing dependencies
# script runs from main.sh so running from here will cause a path failure

# to be modified to support more package managers in future
declare -r PACKAGE_MANAGERS=(
    "apt" "dnf" "pacman" "zypper" "emerge"
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
    printf "installing missing dependencies\n"
    printf "using package manager: $os_pkg_manager\n"
    
    read -rp "do you want to install missing dependencies? (y/n): " answer
    if [[ ! $answer =~ ^[Yy]$ ]]; then
        printf "installation cancelled by user\n"
        printf "program wont run without :${missing_deps[*]}\n" >&2
        printf "please install missing dependencies manually\n" >&2
        exit 0
    fi
    for dep in "${missing_deps[@]}"; do
        case $os_pkg_manager in
            "apt") run_privileged apt install -y $dep ;;
            "dnf") run_privileged dnf install -y $dep ;;
            "pacman") run_privileged pacman -S --noconfirm $dep ;;
            "zypper") run_privileged zypper install -y $dep ;;
            "emerge") run_privileged emerge --ask $dep ;;
            *) 
                printf "unknown package manager aborting...../n" >&2
                printf "pls add package manager to shm open source project/n" >&2
                exit 1 ;;
        esac
    done
}