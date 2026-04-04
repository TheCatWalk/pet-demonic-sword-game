extends CharacterBody2D
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sound_drop: AudioStreamPlayer2D = $sound_drop
@onready var food_sprite: Sprite2D = $TboneSteak2

func _ready() -> void:
	timer.timeout.connect(on_timeout)
	add_to_group("food")
	sound_drop.play_sound()
	await get_tree().process_frame

	var tween_rotate = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_rotate.tween_property(food_sprite, "rotation_degrees", 6, 2)
	tween_rotate.tween_property(food_sprite, "rotation_degrees", -6, 3)

	var tween_vertical = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_vertical.tween_property(food_sprite, "position:y", 8, 1)
	tween_vertical.tween_property(food_sprite, "position:y", -8, 2)
	tween_vertical.tween_property(food_sprite, "position:y", 3, 1)

func on_timeout():
	collision_shape_2d.disabled = false
