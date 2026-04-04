extends CharacterBody2D

@onready var actor_sprite: Sprite2D = $Visuals/ActorSprite
@onready var wander_component: Timer = $Systems/WanderComponent
@onready var collector_component: Area2D = $Collision/CollectorComponent
@onready var mouth_marker: Marker2D = $Visuals/MouthMarker

var is_input_active: bool = false
var chase_position: Vector2 = Vector2.ZERO
var items_collected: int = 0
var current_target: Node2D = null
var current_stage_index: int = -1

@export var movement_smoothness: float = 0.02
@export var manifest: ActorManifest

signal visuals_updated(new_texture: Texture2D, scale_mult: float, sfx: AudioStream)

func _ready() -> void:
	visuals_updated.connect(actor_sprite.apply_evolution_visuals)
	collector_component.item_collected.connect(on_interaction_success)
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

	if manifest == null:
		push_warning("SimulationActor: No ActorManifest assigned!")
		return

	var next_stage_index = current_stage_index + 1
	if next_stage_index < manifest.stages.size():
		var next_stage = manifest.stages[next_stage_index]
		if items_collected >= next_stage.threshold_value:
			current_stage_index = next_stage_index
			visuals_updated.emit(next_stage.sprite, next_stage.scale_multiplier, next_stage.evolution_sfx)
