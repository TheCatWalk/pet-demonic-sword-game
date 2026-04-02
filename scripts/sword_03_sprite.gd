extends Sprite2D
@onready var sword_area: Area2D = $"../sword_area"

func _physics_process(delta: float) -> void:
	if GLOBAL.mouse_in_water:
		var actual_width: float = texture.get_width() * scale.x
		if get_global_mouse_position().x > global_position.x:
			flip_h = false
			sword_area.position.x = actual_width/2
		else:
			flip_h = true
			sword_area.position.x = -actual_width/2
