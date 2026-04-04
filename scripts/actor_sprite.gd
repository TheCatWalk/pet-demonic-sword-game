extends Sprite2D

@export var level_up_audio: AudioStreamPlayer2D
@onready var mouth_marker: Marker2D = $"../MouthMarker"

var _base_scale: Vector2

func _ready() -> void:
	_base_scale = scale

func apply_evolution_visuals(new_texture: Texture2D, scale_mult: float, sfx: AudioStream) -> void:
	var shrink_tween = create_tween()
	shrink_tween.tween_property(self, "scale", Vector2.ZERO, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)

	await shrink_tween.finished

	texture = new_texture
	var target_scale = _base_scale * scale_mult

	var half_width = (texture.get_width() * target_scale.x) / 2.0
	if mouth_marker:
		mouth_marker.position.x = half_width

	if level_up_audio and sfx:
		level_up_audio.stream = sfx
		level_up_audio.play()

	var pop_tween = create_tween()
	pop_tween.tween_property(self, "scale", target_scale, 0.4).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
