extends Timer
var target_position: Vector2 = Vector2(0,0)
func _ready() -> void:
	timeout.connect(on_timeout)

func on_timeout():
	wait_time = randf_range(3,8)
	target_position = Vector2(randf_range(-110,140), randf_range(-100,200))
