extends Timer

@export var min_wait: float = 3.0
@export var max_wait: float = 8.0
@export var bounds_min: Vector2 = Vector2(-110, -100)
@export var bounds_max: Vector2 = Vector2(140, 200)

var target_position: Vector2 = Vector2(0, 0)

func _ready() -> void:
	timeout.connect(on_timeout)

func on_timeout():
	wait_time = randf_range(min_wait, max_wait)
	target_position = Vector2(randf_range(bounds_min.x, bounds_max.x), randf_range(bounds_min.y, bounds_max.y))
