extends Node2D

@export var food_scenes: Array[PackedScene] = []

func spawn_food(_global_position):
	if food_scenes.is_empty():
		push_warning("FoodContainer: No food scenes assigned in the Inspector!")
		return

	var scene_to_spawn = food_scenes.pick_random()
	if scene_to_spawn:
		var new_food = scene_to_spawn.instantiate()
		add_child(new_food)
		new_food.global_position = _global_position
