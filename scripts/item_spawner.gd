extends Node2D

@export var spawnable_items: Array[PackedScene] = []

func spawn_item(_global_position):
	if spawnable_items.is_empty():
		push_warning("Spawner: No spawnable items assigned in the Inspector!")
		return

	var scene_to_spawn = spawnable_items.pick_random()
	if scene_to_spawn:
		var new_item = scene_to_spawn.instantiate()
		add_child(new_item)
		new_item.global_position = _global_position
