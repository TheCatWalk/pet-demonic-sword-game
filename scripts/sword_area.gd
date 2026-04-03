extends Area2D
@export var sound_chomp: AudioStreamPlayer2D
@export var sword_sprite: Sprite2D

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body):
	if body.is_in_group("food"):
		body.queue_free()
		sound_chomp.play_sound()
		sword_sprite.grow()
