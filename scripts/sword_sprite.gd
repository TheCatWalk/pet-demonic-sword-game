extends Sprite2D
@export var sword_area: Area2D
@export var images: Array[CompressedTexture2D]
@export var sound_pop: AudioStreamPlayer2D

var food_counter: int = 0

func _ready() -> void:
	var tween_rotate = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_rotate.tween_property(self, "rotation_degrees", 6, 2)
	tween_rotate.tween_property(self, "rotation_degrees", -6, 3)

	var tween_vertical = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_vertical.tween_property(self, "position:y", 8, 1)
	tween_vertical.tween_property(self, "position:y", -8, 2)
	tween_vertical.tween_property(self, "position:y", 3, 1)


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
	sound_pop.play_sound()

func grow():
	food_counter += 1
	if food_counter == 10:
		set_image(0)
	elif food_counter == 20:
		set_image(1)
	elif food_counter == 30:
		set_image(2)
