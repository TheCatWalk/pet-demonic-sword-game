extends Sprite2D

@export var images: Array[CompressedTexture2D]
@export var level_up_audio: AudioStreamPlayer2D

@onready var mouth_marker: Marker2D = $"../MouthMarker"

func set_image(_index: int) -> void:
	if _index < images.size():
		texture = images[_index]

		var half_width = (texture.get_width() * scale.x) / 2.0

		if mouth_marker:
			mouth_marker.position.x = half_width

	if level_up_audio:
		level_up_audio.play_sound()

func on_evolved(stage_index: int) -> void:
	set_image(stage_index)
