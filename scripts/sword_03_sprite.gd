extends Sprite2D

func _physics_process(delta: float) -> void:
	if GLOBAL.mouse_in_water:
		if get_global_mouse_position().x > global_position.x:
			flip_h = false
		else:
			flip_h = true
