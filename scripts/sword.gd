extends CharacterBody2D
@onready var sword_sprite: Sprite2D = $sword_sprite


func _physics_process(delta: float) -> void:
	if GLOBAL.mouse_in_water:
		flip_sword_sprite(get_global_mouse_position())
		global_position = lerp(global_position, get_global_mouse_position(), 0.02)
	elif get_tree().get_nodes_in_group("food").size() > 0:
		var target_food = get_tree().get_nodes_in_group("food")[0]
		var target_pos = target_food.global_position - Vector2(sword_sprite.sword_area.position.x, 0)
		global_position = lerp(global_position, target_pos, 0.02)
		flip_sword_sprite(target_food.global_position)

func flip_sword_sprite(_target_position):
	# called from _physics_process()
	if _target_position.x < global_position.x:
		sword_sprite.flip_h = true
	else:
		sword_sprite.flip_h = false
