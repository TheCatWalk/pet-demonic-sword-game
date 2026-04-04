extends Node2D

signal drag_requested
signal resize_requested
signal quit_requested
signal reset_requested

func _ready() -> void:
	var env = $Environment
	env.drag_requested.connect(drag_requested.emit)
	env.resize_requested.connect(resize_requested.emit)
	env.quit_requested.connect(func(): quit_requested.emit())
	env.reset_requested.connect(func(): reset_requested.emit())
