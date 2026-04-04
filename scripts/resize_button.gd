extends Button
@export var sound_glass_slide: AudioStreamPlayer2D
@export var sound_glass_place: AudioStreamPlayer2D

signal hovered(index)
signal unhovered

func _ready() -> void:
	button_down.connect(on_button_down)
	button_up.connect(on_button_up)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_button_down():
	get_window().start_resize(DisplayServer.WINDOW_EDGE_BOTTOM_RIGHT)
	sound_glass_slide.play_sound()

func on_button_up():
	sound_glass_place.play_sound()

func on_mouse_entered():
	hovered.emit(0)

func on_mouse_exited():
	unhovered.emit()
