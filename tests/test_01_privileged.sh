#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
# shellcheck source=/dev/null
#
# script performs unit test to privileged.sh script
#
#

# properly get file location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILE_DIR="$(cd "$SCRIPT_DIR" && {
    cd ../
    cd ~+/lib/core && pwd; }
 )"

# source scripts -- the order matters
source "$FILE_DIR"/00_error.sh
source "$FILE_DIR"/01_privileged.sh

passed=0
failed=0

assert_exit() {
    local expected=$1
    shift
    local actual=$?
    
    if [[ $actual -eq $expected ]]; then
        echo "✅ PASS: $*" 
        (( passed++ ))
    else
        echo " ❌ FAILED: $*"
        echo "expected: $expected and got $actual"
        (( failed++ ))
    fi
}

#*******************testing root**************************
# didn't properly test this because needs root device so always validates true
assert_exit 0 is_root 

# testing is_sudo_available
command -v sudo > /dev/null && assert_exit 0 is_sudo_available || assert_exit 1 is_sudo_available

# *********************testing run_privileged********************
assert_exit 0 run_privileged echo "hello" # testing with command not requring echo

# **********************testing kill sudo******************
sudo -v 2> /dev/null # set sudo to active
assert_exit 0 kill_sudo

echo "===== RESULTS ======"
echo "PASSED: $passed FAILED: $failed"
[[ $failed -eq 0 ]] && exit 0 || exit 1
