extends CharacterBody2D

@onready var actor_sprite: Sprite2D = $Visuals/ActorSprite
@onready var wander_component: Timer = $Systems/WanderComponent
@onready var collector_component: Area2D = $Collision/CollectorComponent
@onready var mouth_marker: Marker2D = $Visuals/MouthMarker

var is_input_active: bool = false
var chase_position: Vector2 = Vector2.ZERO
var items_collected: int = 0
var current_target: Node2D = null

@export var movement_smoothness: float = 0.02
@export var evolution_thresholds: Array[int] = [10, 20, 30]

signal leveled_up(stage_index)

func _ready() -> void:
	leveled_up.connect(actor_sprite.on_evolved)

func _physics_process(_delta: float) -> void:
	if is_input_active:
		update_orientation(chase_position)
		global_position = lerp(global_position, chase_position - collector_component.position, movement_smoothness)
	elif is_instance_valid(current_target):
		global_position = lerp(global_position, current_target.global_position - collector_component.position, movement_smoothness)
		update_orientation(current_target.global_position)
	else:
		position = lerp(position, wander_component.target_position, movement_smoothness)
		update_orientation(wander_component.target_position + global_position)

func update_orientation(_target_position: Vector2) -> void:
	if _target_position.x >= global_position.x:
		actor_sprite.flip_h = false
		collector_component.position.x = mouth_marker.position.x
	else:
		actor_sprite.flip_h = true
		collector_component.position.x = -mouth_marker.position.x

func on_interaction_success() -> void:
	items_collected += 1
	for i in evolution_thresholds.size():
		if items_collected == evolution_thresholds[i]:
			leveled_up.emit(i)
			return
