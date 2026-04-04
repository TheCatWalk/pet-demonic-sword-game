extends CharacterBody2D
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sound_drop: AudioStreamPlayer2D = $AudioPlayer

func _ready() -> void:
	timer.timeout.connect(enable_collision)
	sound_drop.play_sound()

func enable_collision():
	collision_shape_2d.disabled = false

func consume():
	queue_free()
