# [Feed The Sword] Project Context File: .gd

## res://

### scripts

#### autoloads

**global.gd**
```gdscript
extends Node

var mouse_in_water: bool = false

signal water_clicked (_global_position)
#	water_button -> food_container

signal show_tooltip(_index)
signal hide_tooltip
#called from water-button, resize-button, fishbowl-button, mute-button -> tooltip

```

### scripts

**bowl_manager.gd**
```gdscript
extends Node2D

@onready var water_button = $"InputLayers/WaterButton"
@onready var food_container = $"Gameplay/FoodContainer"
@onready var tooltip = $"Interface/Tooltip"
@onready var resize_button = $"Interface/ResizeButton"
@onready var fishbowl_button = $"InputLayers/FishbowlButton"
@onready var mute_button = $"Interface/MuteButton"

func _ready() -> void:
	water_button.water_entered.connect(_on_water_entered)
	water_button.water_exited.connect(_on_water_exited)
	water_button.water_pressed.connect(_on_water_pressed)

	resize_button.hovered.connect(_on_button_hovered)
	resize_button.unhovered.connect(_on_button_unhovered)

	fishbowl_button.hovered.connect(_on_button_hovered)
	fishbowl_button.unhovered.connect(_on_button_unhovered)

	mute_button.hovered.connect(_on_button_hovered)
	mute_button.unhovered.connect(_on_button_unhovered)

func _process(_delta: float) -> void:
	var sword = get_node_or_null("Gameplay/Sword")
	if sword == null:
		return
	var foods = get_tree().get_nodes_in_group("food")
	if foods.size() > 0:
		sword.current_target = foods[0]
	else:
		sword.current_target = null

func _on_water_entered():
	var sword = get_node_or_null("Gameplay/Sword")
	if sword:
		sword.mouse_in_water = true
	tooltip.show_tooltip(4)

func _on_water_exited():
	var sword = get_node_or_null("Gameplay/Sword")
	if sword:
		sword.mouse_in_water = false
	tooltip.hide_tooltip()

func _on_water_pressed(pos):
	food_container.spawn_food(pos)

func _on_button_hovered(index):
	tooltip.show_tooltip(index)

func _on_button_unhovered():
	tooltip.hide_tooltip()

```

**bubble.gd**
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
	audio_player.play_sound()

```

**eater_component.gd**
```gdscript
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

```

**fishbowl_button.gd**
```gdscript
extends TextureButton
@export var sound_glass_slide: AudioStreamPlayer2D
@export var sound_glass_place: AudioStreamPlayer2D

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
	get_window().start_drag()
	sound_glass_slide.play_sound()

func on_button_up():
	sound_glass_place.play_sound()

func on_mouse_entered():
	hovered.emit(1)

func on_mouse_exited():
	unhovered.emit()

```

**food.gd**
```gdscript
extends CharacterBody2D
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sound_drop: AudioStreamPlayer2D = $AudioPlayer

func _ready() -> void:
	timer.timeout.connect(enable_collision)
	add_to_group("food")
	sound_drop.play_sound()

func enable_collision():
	collision_shape_2d.disabled = false

func consume():
	queue_free()

```

**food_container.gd**
```gdscript
extends Node2D
const FOOD = preload("uid://cjwu5caouwots")

func spawn_food(_global_position):
	var new_food = FOOD.instantiate()
	add_child(new_food)
	new_food.global_position = _global_position

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
		hovered.emit(2)
	else:
		hovered.emit(3)

func on_mouse_exited():
	unhovered.emit()

```

**random_audio_player.gd**
```gdscript
extends AudioStreamPlayer2D

@export var sounds: Array[AudioStream]

func play_sound():
	sounds.shuffle()
	stream = sounds[0]
	pitch_scale = randf_range(1.0, 1.3)
	play()

```

**resize_button.gd**
```gdscript
extends Button
@export var sound_glass_slide: AudioStreamPlayer2D
@export var sound_glass_place: AudioStreamPlayer2D

signal hovered(index)
signal unhovered

func _ready() -> void:
	button_down.connect(on_button_down)
	button_up.connect(on_button_up)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_button_down():
	get_window().start_resize(DisplayServer.WINDOW_EDGE_BOTTOM_RIGHT)
	sound_glass_slide.play_sound()

func on_button_up():
	sound_glass_place.play_sound()

func on_mouse_entered():
	hovered.emit(0)

func on_mouse_exited():
	unhovered.emit()

```

**sword.gd**
```gdscript
extends CharacterBody2D
@onready var sword_sprite: Sprite2D = $Visuals/SwordSprite
@onready var wander_component: Timer = $Systems/WanderComponent
@onready var eater_component: Area2D = $Collision/EaterComponent

var mouse_in_water: bool = false
var food_counter: int = 0
var current_target: Node2D = null

@export var movement_smoothness: float = 0.02
@export var evolution_thresholds: Array[int] = [10, 20, 30]

signal leveled_up(stage_index)

func _ready() -> void:
	leveled_up.connect(sword_sprite.on_evolved)

func _physics_process(_delta: float) -> void:
	if mouse_in_water:
		update_orientation(get_global_mouse_position())
		global_position = lerp(global_position, get_global_mouse_position() - eater_component.position, movement_smoothness)
	elif is_instance_valid(current_target):
		global_position = lerp(global_position, current_target.global_position - eater_component.position, movement_smoothness)
		update_orientation(current_target.global_position)
	else:
		position = lerp(position, wander_component.target_position, movement_smoothness)
		update_orientation(wander_component.target_position + global_position)

func update_orientation(_target_position):
	if _target_position.x >= global_position.x:
		sword_sprite.flip_h = false
		eater_component.position.x = 15
	else:
		sword_sprite.flip_h = true
		eater_component.position.x = -15

func advance_level():
	food_counter += 1
	for i in evolution_thresholds.size():
		if food_counter == evolution_thresholds[i]:
			leveled_up.emit(i)
			return

```

**sword_sprite.gd**
```gdscript
extends Sprite2D
@export var sword_area: Area2D
@export var images: Array[CompressedTexture2D]
@export var level_up_audio: AudioStreamPlayer2D

func set_image(_index):
	texture = images[_index]
	level_up_audio.play_sound()

func on_evolved(stage_index):
	set_image(stage_index)

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

**water_button.gd**
```gdscript
extends TextureButton

signal water_entered
signal water_exited
signal water_pressed(pos)

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
	water_entered.emit()

func on_mouse_exited():
	water_exited.emit()

func on_pressed():
	water_pressed.emit(get_global_mouse_position())

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


func _ready() -> void:
	get_window().min_size = Vector2i(150,150)

func _physics_process(delta: float) -> void:
	get_window().size.x = get_window().size.y

```

