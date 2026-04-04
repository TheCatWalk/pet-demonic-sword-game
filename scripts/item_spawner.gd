extends Node2D

@export var registry: ItemRegistry

func spawn_item(_global_position: Vector2) -> void:
	if registry == null or registry.items.is_empty():
		push_warning("Spawner: No ItemRegistry assigned or registry is empty!")
		return

	var item_data: ItemData = registry.items.pick_random()

	if item_data == null or item_data.scene == null:
		push_warning("Spawner: ItemData or its scene is null!")
		return

	var new_item = item_data.scene.instantiate()
	add_child(new_item)
	new_item.global_position = _global_position

	if new_item.has_method("setup"):
		new_item.setup(item_data.sfx)
