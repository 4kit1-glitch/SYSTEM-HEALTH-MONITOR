#!/usr/bin/env bash


#---- vars ----------
declare -r disk_num="$(lsblk -d -o name,size,model | sed /^NAME/d | grep -v zram | wc -l)"

# ------ getters -----------
get_storage_info() {
    lsblk -d -o name,size,model | grep -v zram
}
get_ext_storage_info() {
    lsblk
}

#---------- OVERALL ----------------------------
get_storage_summary() {
    printf "Number of drives: %d\n" "$disk_num"
    get_storage_info
}

disk_type_check() {
    lsblk -d -o name,rota | grep -v "zram" |awk '{print}$2==0{print "SSD"} $2==1{print "HDD"}'
}