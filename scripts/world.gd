extends Node2D

signal drag_requested
signal resize_requested

func _ready() -> void:
	var env = $Environment
	env.drag_requested.connect(drag_requested.emit)
	env.resize_requested.connect(resize_requested.emit)
