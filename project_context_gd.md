# [Feed The Sword] Project Context File: .gd

## res://

### scripts

**actor_sprite.gd**
```gdscript
extends Sprite2D

@export var level_up_audio: AudioStreamPlayer2D
@onready var mouth_marker: Marker2D = $"../MouthMarker"

var _base_scale: Vector2

func _ready() -> void:
	_base_scale = scale

func apply_evolution_visuals(new_texture: Texture2D, scale_mult: float, sfx: AudioStream) -> void:
	texture = new_texture
	scale = _base_scale * scale_mult
	var half_width = (texture.get_width() * scale.x) / 2.0
	if mouth_marker:
		mouth_marker.position.x = half_width
	if level_up_audio and sfx:
		level_up_audio.stream = sfx
		level_up_audio.play()

```

**ambient_particle.gd**
```gdscript
extends CPUParticles2D

@export var image: CompressedTexture2D
@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer
@onready var timer: Timer = $Timer

func _ready() -> void:
	if image:
		texture = image
	timer.timeout.connect(on_timeout)
	timer.wait_time = randf_range(1, 10)
	timer.start()

func on_timeout():
	timer.wait_time = randf_range(7, 30)
	audio_player.play()

```

**collectable_item.gd**
```gdscript
extends CharacterBody2D

@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sound_drop: AudioStreamPlayer2D = $AudioPlayer

func _ready() -> void:
	timer.timeout.connect(enable_collision)

func setup(drop_sound: AudioStream) -> void:
	if sound_drop and drop_sound:
		sound_drop.stream = drop_sound
		sound_drop.play()

func enable_collision() -> void:
	collision_shape_2d.disabled = false

func consume() -> void:
	queue_free()

```

**collector_component.gd**
```gdscript
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

```

**desktop_pet_wrapper.gd**
```gdscript
extends Node2D

func _ready() -> void:
	get_window().min_size = Vector2i(150, 150)
	$World.drag_requested.connect(_on_drag_requested)
	$World.resize_requested.connect(_on_resize_requested)

func _physics_process(_delta: float) -> void:
	get_window().size.x = get_window().size.y

func _on_drag_requested() -> void:
	get_window().start_drag()

func _on_resize_requested() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_BOTTOM_RIGHT)

```

**env_drag_button.gd**
```gdscript
extends TextureButton
@export var sound_glass_slide: AudioStreamPlayer2D
@export var sound_glass_place: AudioStreamPlayer2D

signal drag_requested
signal hovered(index)
signal unhovered

func _ready() -> void:
	button_down.connect(on_button_down)
	button_up.connect(on_button_up)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

	if texture_normal:
		var image = texture_normal.get_image()
		var bitmap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap

func on_button_down():
	drag_requested.emit()
	sound_glass_slide.play()

func on_button_up():
	sound_glass_place.play()

func on_mouse_entered():
	hovered.emit(1)

func on_mouse_exited():
	unhovered.emit()

```

**environment_manager.gd**
```gdscript
extends Node2D

signal drag_requested
signal resize_requested

@onready var input_area_button = $"InputLayers/InputAreaButton"
@onready var item_spawner = $"Gameplay/ItemSpawner"
@onready var tooltip = $"Interface/Tooltip"
@onready var resize_button = $"Interface/ResizeButton"
@onready var env_drag_button = $"InputLayers/EnvDragButton"
@onready var mute_button = $"Interface/MuteButton"

func _ready() -> void:
	input_area_button.zone_entered.connect(_on_zone_entered)
	input_area_button.zone_exited.connect(_on_zone_exited)
	input_area_button.zone_pressed.connect(_on_zone_pressed)

	resize_button.resize_requested.connect(resize_requested.emit)
	resize_button.hovered.connect(_on_button_hovered)
	resize_button.unhovered.connect(_on_button_unhovered)

	env_drag_button.drag_requested.connect(drag_requested.emit)
	env_drag_button.hovered.connect(_on_button_hovered)
	env_drag_button.unhovered.connect(_on_button_unhovered)

	mute_button.hovered.connect(_on_button_hovered)
	mute_button.unhovered.connect(_on_button_unhovered)

func _process(_delta: float) -> void:
	var actor = get_node_or_null("Gameplay/MainActor")
	if actor == null: return

	# Handle Manual Input (Mouse)
	if actor.is_input_active:
		actor.chase_position = get_global_mouse_position()

	# Handle Item Targeting (Check children directly instead of groups)
	var items = item_spawner.get_children()
	if items.size() > 0:
		actor.current_target = items[0]
	else:
		actor.current_target = null

func _on_zone_entered():
	var actor = get_node_or_null("Gameplay/MainActor")
	if actor:
		actor.is_input_active = true
	tooltip.show_tooltip(4)

func _on_zone_exited():
	var actor = get_node_or_null("Gameplay/MainActor")
	if actor:
		actor.is_input_active = false
	tooltip.hide_tooltip()

func _on_zone_pressed(pos):
	item_spawner.spawn_item(pos)

func _on_button_hovered(index):
	tooltip.show_tooltip(index)

func _on_button_unhovered():
	tooltip.hide_tooltip()

```

**input_area_button.gd**
```gdscript
extends TextureButton

signal zone_entered
signal zone_exited
signal zone_pressed(pos)

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	pressed.connect(on_pressed)
	if texture_normal:
		var image = texture_normal.get_image()
		var bitmap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap

func on_mouse_entered():
	zone_entered.emit()

func on_mouse_exited():
	zone_exited.emit()

func on_pressed():
	zone_pressed.emit(get_global_mouse_position())

```

**item_spawner.gd**
```gdscript
extends Node2D

@export var registry: ItemRegistry

func spawn_item(_global_position: Vector2) -> void:
	if registry == null or registry.items.is_empty():
		push_warning("Spawner: No ItemRegistry assigned or registry is empty!")
		return

	var item_data: ItemData = registry.items.pick_random()

	if item_data == null or item_data.scene == null:
		push_warning("Spawner: ItemData or its scene is null!")
		return

	var new_item = item_data.scene.instantiate()

	if new_item.has_method("setup"):
		new_item.setup(item_data.sfx)

	add_child(new_item)
	new_item.global_position = _global_position

```

**mute_button.gd**
```gdscript
extends Button
var muted = false

signal hovered(index)
signal unhovered

func _ready() -> void:
	toggled.connect(on_toggled)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_toggled(_toggled):
	muted = _toggled
	mute()
	on_mouse_entered()

func mute():
	AudioServer.set_bus_mute(0, muted)

func on_mouse_entered():
	if muted:
		hovered.emit(3)
	else:
		hovered.emit(2)

func on_mouse_exited():
	unhovered.emit()

```

**resize_button.gd**
```gdscript
extends Button
@export var sound_glass_slide: AudioStreamPlayer2D
@export var sound_glass_place: AudioStreamPlayer2D

signal resize_requested
signal hovered(index)
signal unhovered

func _ready() -> void:
	button_down.connect(on_button_down)
	button_up.connect(on_button_up)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_button_down():
	resize_requested.emit()
	sound_glass_slide.play()

func on_button_up():
	sound_glass_place.play()

func on_mouse_entered():
	hovered.emit(0)

func on_mouse_exited():
	unhovered.emit()

```

#### resources

**actor_manifest.gd**
```gdscript
class_name ActorManifest
extends Resource

@export var stages: Array[EvolutionData] = []

```

**evolution_data.gd**
```gdscript
class_name EvolutionData
extends Resource

@export var sprite: Texture2D
@export var scale_multiplier: float = 1.0
@export var threshold_value: int = 10
@export var evolution_sfx: AudioStream

```

**item_data.gd**
```gdscript
class_name ItemData
extends Resource

@export var name: String = ""
@export var scene: PackedScene
@export var value: int = 1
@export var sfx: AudioStream

```

**item_registry.gd**
```gdscript
class_name ItemRegistry
extends Resource

@export var items: Array[ItemData] = []

```

**sound_bank.gd**
```gdscript
class_name SoundBank
extends Resource

@export var sounds: Array[AudioStream] = []

```

### scripts

**simulation_actor.gd**
```gdscript
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

```

**tooltip.gd**
```gdscript
extends Sprite2D

@export var images: Array[CompressedTexture2D]

func _physics_process(_delta: float) -> void:
	global_position = lerp(global_position, get_global_mouse_position() + Vector2(20, -15), 0.5)

func show_tooltip(_index):
	texture = images[_index]

func hide_tooltip():
	texture = null

```

**wander_component.gd**
```gdscript
extends Timer

@export var min_wait: float = 3.0
@export var max_wait: float = 8.0
@export var bounds_min: Vector2 = Vector2(-110, -100)
@export var bounds_max: Vector2 = Vector2(140, 200)

var target_position: Vector2 = Vector2(0, 0)

func _ready() -> void:
	timeout.connect(on_timeout)

func on_timeout():
	wait_time = randf_range(min_wait, max_wait)
	target_position = Vector2(randf_range(bounds_min.x, bounds_max.x), randf_range(bounds_min.y, bounds_max.y))

```

**wobble_visual.gd**
```gdscript
extends Node

@export var rotation_degrees: float = 6.0
@export var rotation_duration_a: float = 2.0
@export var rotation_duration_b: float = 3.0
@export var vertical_offset: float = 8.0
@export var vertical_duration_a: float = 1.0
@export var vertical_duration_b: float = 2.0

func _ready() -> void:
	var tween_rotate = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_rotate.tween_property(get_parent(), "rotation_degrees", rotation_degrees, rotation_duration_a)
	tween_rotate.tween_property(get_parent(), "rotation_degrees", -rotation_degrees, rotation_duration_b)

	var tween_vertical = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_vertical.tween_property(get_parent(), "position:y", vertical_offset, vertical_duration_a)
	tween_vertical.tween_property(get_parent(), "position:y", -vertical_offset, vertical_duration_b)
	tween_vertical.tween_property(get_parent(), "position:y", vertical_offset / 2.5, vertical_duration_a)

```

**world.gd**
```gdscript
extends Node2D

signal drag_requested
signal resize_requested

func _ready() -> void:
	var env = $Environment
	env.drag_requested.connect(drag_requested.emit)
	env.resize_requested.connect(resize_requested.emit)

```

