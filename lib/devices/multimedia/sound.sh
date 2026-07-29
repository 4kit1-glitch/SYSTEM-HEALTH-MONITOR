#!/usr/bin/env bash

#------------ vars ------------------------
declare -r output_count=$(pactl list sinks short | wc -l)
declare -r input_count=$(pactl list sources short | wc -l)

#---------------- Getters   -----------------

get_sound_ouput_info() {
    
}

get_sound_input_sources() {

}

#------------ processes -----------------------
get_audio_info_summary() {

}