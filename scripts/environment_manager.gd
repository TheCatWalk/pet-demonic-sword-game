extends Node2D

signal drag_requested
signal resize_requested
signal reset_requested
signal quit_requested

@onready var input_area_button = $"InputLayers/InputAreaButton"
@onready var item_spawner = $"Gameplay/ItemSpawner"
@onready var tooltip = $"Interface/Tooltip"

@export var ui_audio_player: AudioStreamPlayer2D
@export var sound_glass_slide: AudioStream
@export var sound_glass_place: AudioStream

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var actor = get_node_or_null("Gameplay/MainActor")
	if actor == null: return

	if actor.is_input_active:
		actor.chase_position = get_global_mouse_position()

	var items = item_spawner.get_children()
	if items.size() > 0:
		actor.current_target = items[0]
	else:
		actor.current_target = null

func _on_quit_button_pressed() -> void:
	quit_requested.emit()

func _on_quit_button_mouse_entered() -> void:
	tooltip.show_tooltip(6)

func _on_quit_button_mouse_exited() -> void:
	tooltip.hide_tooltip()

func _on_reset_button_pressed() -> void:
	reset_requested.emit()

func _on_reset_button_mouse_entered() -> void:
	tooltip.show_tooltip(5)

func _on_reset_button_mouse_exited() -> void:
	tooltip.hide_tooltip()

func _on_resize_button_down() -> void:
	if ui_audio_player and sound_glass_slide:
		ui_audio_player.stream = sound_glass_slide
		ui_audio_player.play()
	resize_requested.emit()

func _on_resize_button_up() -> void:
	if ui_audio_player and sound_glass_place:
		ui_audio_player.stream = sound_glass_place
		ui_audio_player.play()

func _on_resize_button_mouse_entered() -> void:
	tooltip.show_tooltip(0)

func _on_resize_button_mouse_exited() -> void:
	tooltip.hide_tooltip()

func _on_mute_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)
	_on_mute_button_mouse_entered()

func _on_mute_button_mouse_entered() -> void:
	if AudioServer.is_bus_mute(0):
		tooltip.show_tooltip(3)
	else:
		tooltip.show_tooltip(2)

func _on_mute_button_mouse_exited() -> void:
	tooltip.hide_tooltip()

func _on_env_drag_button_down() -> void:
	if ui_audio_player and sound_glass_slide:
		ui_audio_player.stream = sound_glass_slide
		ui_audio_player.play()
	drag_requested.emit()

func _on_env_drag_button_up() -> void:
	if ui_audio_player and sound_glass_place:
		ui_audio_player.stream = sound_glass_place
		ui_audio_player.play()

func _on_env_drag_button_mouse_entered() -> void:
	tooltip.show_tooltip(1)

func _on_env_drag_button_mouse_exited() -> void:
	tooltip.hide_tooltip()

func _on_input_area_button_mouse_entered() -> void:
	var actor = get_node_or_null("Gameplay/MainActor")
	if actor:
		actor.is_input_active = true
	tooltip.show_tooltip(4)

func _on_input_area_button_mouse_exited() -> void:
	var actor = get_node_or_null("Gameplay/MainActor")
	if actor:
		actor.is_input_active = false
	tooltip.hide_tooltip()

func _on_input_area_button_pressed() -> void:
	item_spawner.spawn_item(get_global_mouse_position())
