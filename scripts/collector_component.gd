extends Area2D
@export var sound_interaction: AudioStreamPlayer2D

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body):
	if body.has_method("consume"):
		body.consume()
		sound_interaction.play_sound()
		owner.on_interaction_success()
