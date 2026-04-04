extends Node2D


func _ready() -> void:
	get_window().min_size = Vector2i(150,150)

func _physics_process(delta: float) -> void:
	get_window().size.x = get_window().size.y
