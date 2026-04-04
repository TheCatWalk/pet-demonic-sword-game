extends Button
var muted = false

signal hovered(index)
signal unhovered

func _ready() -> void:
	toggled.connect(on_toggled)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_toggled(_toggled):
	muted = _toggled
	mute()
	on_mouse_entered()

func mute():
	AudioServer.set_bus_mute(0, muted)

func on_mouse_entered():
	if muted:
		hovered.emit(2)
	else:
		hovered.emit(3)

func on_mouse_exited():
	unhovered.emit()
