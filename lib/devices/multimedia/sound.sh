#!/usr/bin/env bash


# the programs used are presence are already verified in check_deps.sh
#------------ vars ------------------------
declare -ri output_count=$(pactl list sinks short | wc -l)
declare -ri input_count=$(pactl list sources short | wc -l)
declare -ri bluetooth_count=$(pactl list sinks short | grep "bluez" | wc -l)
declare -r active_device="$(pactl list sinks short  | grep -Ei "running" |
 awk '{printf "%s is active\n", $2} END{if( NR == 0) {printf "No audio device active\n"}')"

#---------------- Getters   -----------------

get_sound_output_info() {
    printf "Sound output information\n"
    printf "no of output sinks: %d\n" "$output_count"
    sound_output_info=$(
        pactl list sinks | sed -E -n -f $FEATURE_DIR/sound_info.sed | 
        sed '/State/i\device'
    )
     printf "%s\n" "$sound_output_info"
}

get_sound_input_sources() {
    printf "Sound input information\n"
    printf "no of input sinks: %d\n" "$input_count"
    sound_input_info=$(
        pactl list sources | sed -E -n -f $FEATURE_DIR/sound_info.sed |
        sed '/state/i\device'
    )
    printf "%s/n" "$sound_input_info"                                                                                                                                                                                                                                                                                                                                                  
}

#------------ processes -----------------------
get_audio_info_summary() {
    printf "output devices connected: %d\n" "$output_count"
    printf "input devices connected: %d\n" "$input_count"
    printf "bluetooth divices: %d\n" "$bluetooth_count"
    printf "active device: %s\n" "$active_device" 
    printf "volume: "
}