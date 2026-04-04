extends Sprite2D

@export var images: Array[CompressedTexture2D]

func _physics_process(_delta: float) -> void:
	global_position = lerp(global_position, get_global_mouse_position() + Vector2(20, -15), 0.5)

func show_tooltip(_index):
	texture = images[_index]

func hide_tooltip():
	texture = null
