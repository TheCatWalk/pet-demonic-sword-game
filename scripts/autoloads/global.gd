extends Node

var mouse_in_water: bool = false

signal water_clicked (_global_position)
#	water_button -> food_container

signal show_tooltip(_index)
signal hide_tooltip
#called from water-button, resize-button, fishbowl-button, mute-button -> tooltip
