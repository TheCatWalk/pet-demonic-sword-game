extends Node
@export var target_node: Node2D
@export var rotation_degrees: float = 6.0
@export var rotation_duration_a: float = 2.0
@export var rotation_duration_b: float = 3.0
@export var vertical_offset: float = 8.0
@export var vertical_duration_a: float = 1.0
@export var vertical_duration_b: float = 2.0

func _ready() -> void:
	if target_node == null:
		target_node = get_parent() as Node2D

	if target_node == null:
		return
	var tween_rotate = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_rotate.tween_property(target_node, "rotation_degrees", rotation_degrees, rotation_duration_a)
	tween_rotate.tween_property(target_node, "rotation_degrees", -rotation_degrees, rotation_duration_b)

	var tween_vertical = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_vertical.tween_property(target_node, "position:y", vertical_offset, vertical_duration_a)
	tween_vertical.tween_property(target_node, "position:y", -vertical_offset, vertical_duration_b)
	tween_vertical.tween_property(target_node, "position:y", vertical_offset / 2.5, vertical_duration_a)
