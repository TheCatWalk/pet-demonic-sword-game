extends Button
var muted = false
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
		GLOBAL.show_tooltip.emit(2)
	else:
		GLOBAL.show_tooltip.emit(3)

func on_mouse_exited():
	GLOBAL.hide_tooltip.emit()
