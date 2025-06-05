#!/bin/bash
current_space_index=$(yabai -m query --spaces --space | jq -r '.index')

yabai -m space --create

new_space_index=$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')

yabai -m space $new_space_index --move $((current_space_index + 1))

