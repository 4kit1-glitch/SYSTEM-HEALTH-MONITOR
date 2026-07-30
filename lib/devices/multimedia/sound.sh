#!/usr/bin/env bash


# the programs used are presence are already verified in check_deps.sh
#------------ vars ------------------------
declare -ri output_count=$(pactl list sinks short | wc -l)
declare -ri input_count=$(pactl list sources short | wc -l)

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
                                                                                                                                                                                                                                                                                                                                                                         
}

#------------ processes -----------------------
get_audio_info_summary() {
    echo p
}