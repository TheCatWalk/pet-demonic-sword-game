extends CPUParticles2D

@export var image: CompressedTexture2D
@onready var sound_bubble: AudioStreamPlayer2D = $sound_bubble
@onready var timer: Timer = $Timer

func _ready() -> void:
	if image:
		texture = image
	timer.timeout.connect(on_timeout)
	timer.wait_time = randf_range(1,10)
	timer.start()

func on_timeout():
	timer.wait_time = randf_range(7, 30)
	sound_bubble.play_sound()
