extends Area2D
@export var sound_chomp: AudioStreamPlayer2D
@export var sword_sprite: Sprite2D

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body):
	if body.has_method("consume"):
		body.consume()
		sound_chomp.play_sound()
		owner.advance_level()
