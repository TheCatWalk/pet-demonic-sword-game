extends Sprite2D

@export var images: Array[CompressedTexture2D]
func _ready() -> void:
	GLOBAL.show_tooltip.connect(set_image)
	GLOBAL.hide_tooltip.connect(remove_image)

func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, get_global_mouse_position() + Vector2(20,-15), 0.5)

func set_image(_index):
	texture = images[_index]

func remove_image():
	texture = null
