extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if GLOBAL.mouse_in_water:
		global_position = lerp(global_position, get_global_mouse_position(), 0.02)
