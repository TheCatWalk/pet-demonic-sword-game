extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sound_drop: AudioStreamPlayer2D = $AudioPlayer

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	collision_shape_2d.disabled = false

func setup(drop_sound: AudioStream) -> void:
	if sound_drop and drop_sound:
		sound_drop.stream = drop_sound
		sound_drop.play()

func enable_collision() -> void:
	collision_shape_2d.disabled = false

func consume() -> void:
	collision_shape_2d.set_deferred("disabled", true)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	await tween.finished
	queue_free()
