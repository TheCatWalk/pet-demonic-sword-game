extends Sprite2D
@onready var sword_area: Area2D = $"../sword_area"
@export var images: Array[CompressedTexture2D]

var food_counter: int = 0

func _ready() -> void:
	set_image(0)

func _physics_process(delta: float) -> void:
	#if GLOBAL.mouse_in_water:
	#it was making the collision shape always fixed towards where the mouse last was
	var actual_width: float = texture.get_width() * scale.x
	if flip_h == false:
		sword_area.position.x = actual_width/2
	else:
		sword_area.position.x = -actual_width/2

func set_image(_index):
	texture = images[_index]

func grow():
	food_counter += 1
	if food_counter == 2:
		set_image(1)
	elif food_counter == 4:
		set_image(2)
	elif food_counter == 6:
		set_image(3)
