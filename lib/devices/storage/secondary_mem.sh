#!/usr/bin/env bash


#---- vars ----------
declare -r disk_num="$(lsblk -d -o name,size,model | sed /^NAME/d | wc -l)"

# ------ getters -----------
get_storage_info() {
    lsblk -d -o name,size,model
}
get_ext_storage_info() {
    lsblk
}

#---------- OVERALL ----------------------------
get_memory_summary() {
    echo p
}

disk_type_check() {
}