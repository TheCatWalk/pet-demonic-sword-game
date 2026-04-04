extends CPUParticles2D

@export var image: CompressedTexture2D
@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer
@onready var timer: Timer = $Timer

func _ready() -> void:
	if image:
		texture = image
	timer.timeout.connect(on_timeout)
	timer.wait_time = randf_range(1, 10)
	timer.start()

func on_timeout():
	timer.wait_time = randf_range(7, 30)
	audio_player.play()
