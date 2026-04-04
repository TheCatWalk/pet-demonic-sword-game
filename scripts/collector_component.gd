extends Area2D
@export var sound_interaction: AudioStreamPlayer2D

signal item_collected

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body) -> void:
	if body.has_method("consume"):
		body.consume()
		if sound_interaction:
			sound_interaction.play()
		item_collected.emit()
