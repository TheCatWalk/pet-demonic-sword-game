extends Node2D
const FOOD = preload("uid://cjwu5caouwots")

func _ready() -> void:
	GLOBAL.water_clicked.connect(on_water_clicked)

func on_water_clicked(_global_position):
	var new_food = FOOD.instantiate()
	add_child(new_food)
	new_food.global_position = _global_position
