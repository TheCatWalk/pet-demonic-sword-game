extends AudioStreamPlayer2D

@export var sounds: Array[AudioStream]

func play_sound():
	sounds.shuffle()
	stream = sounds[0]
	pitch_scale = randf_range(1.0, 1.3)
	play()
