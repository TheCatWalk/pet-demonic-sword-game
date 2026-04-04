# [Feed The Sword] Project Context File: .gd

## res://

### scenes

**sound_drop.gd**
```gdscript
extends "res://scripts/sound_chomp.gd"

```

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

**bubble.gd**
```gdscript
extends CPUParticles2D

@export var image: CompressedTexture2D
@onready var sound_bubble: AudioStreamPlayer2D = $sound_bubble
@onready var timer: Timer = $Timer

func _ready() -> void:
	if image:
		texture = image
	timer.timeout.connect(on_timeout)
	timer.wait_time = randf_range(1,10)
	timer.start()

func on_timeout():
	timer.wait_time = randf_range(7, 30)
	sound_bubble.play_sound()

```

**fishbowl_button.gd**
```gdscript
extends TextureButton
@export var sound_glass_slide: AudioStreamPlayer2D
@export var sound_glass_place: AudioStreamPlayer2D

func _ready() -> void:
	button_down.connect(on_button_down)
	button_up.connect(on_button_up)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

	if texture_normal:
		# Get the image from the texture normal
		var image = texture_normal.get_image()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_click_mask = bitmap

func on_button_down():
	get_window().start_drag()
	sound_glass_slide.play_sound()
func on_button_up():
	sound_glass_place.play_sound()

func on_mouse_entered():
	GLOBAL.show_tooltip.emit(1)

func on_mouse_exited():
	GLOBAL.hide_tooltip.emit()

```

**food.gd**
```gdscript
extends CharacterBody2D
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sound_drop: AudioStreamPlayer2D = $sound_drop
@onready var food_sprite: Sprite2D = $TboneSteak2

func _ready() -> void:
	timer.timeout.connect(on_timeout)
	add_to_group("food")
	sound_drop.play_sound()
	await get_tree().process_frame

	var tween_rotate = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_rotate.tween_property(food_sprite, "rotation_degrees", 6, 2)
	tween_rotate.tween_property(food_sprite, "rotation_degrees", -6, 3)

	var tween_vertical = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_vertical.tween_property(food_sprite, "position:y", 8, 1)
	tween_vertical.tween_property(food_sprite, "position:y", -8, 2)
	tween_vertical.tween_property(food_sprite, "position:y", 3, 1)

func on_timeout():
	collision_shape_2d.disabled = false

```

**food_container.gd**
```gdscript
extends Node2D
const FOOD = preload("uid://cjwu5caouwots")

func _ready() -> void:
	GLOBAL.water_clicked.connect(on_water_clicked)

func on_water_clicked(_global_position):
	var new_food = FOOD.instantiate()
	add_child(new_food)
	new_food.global_position = _global_position

```

**mute_button.gd**
```gdscript
extends Button
var muted = false
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
		GLOBAL.show_tooltip.emit(2)
	else:
		GLOBAL.show_tooltip.emit(3)

func on_mouse_exited():
	GLOBAL.hide_tooltip.emit()

```

**random_position.gd**
```gdscript
extends Timer
var target_position: Vector2 = Vector2(0,0)
func _ready() -> void:
	timeout.connect(on_timeout)

func on_timeout():
	wait_time = randf_range(3,8)
	target_position = Vector2(randf_range(-110,140), randf_range(-100,200))

```

**resize_button.gd**
```gdscript
extends Button
@export var sound_glass_slide: AudioStreamPlayer2D
@export var sound_glass_place: AudioStreamPlayer2D

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
	GLOBAL.show_tooltip.emit(0)

func on_mouse_exited():
	GLOBAL.hide_tooltip.emit()

```

**sound_chomp.gd**
```gdscript
extends AudioStreamPlayer2D

@export var sounds: Array[AudioStream]

func play_sound():
	sounds.shuffle()
	stream = sounds[0]
	pitch_scale = randf_range(1.0, 1.3)
	play()

```

**sword.gd**
```gdscript
extends CharacterBody2D
@onready var sword_sprite: Sprite2D = $sword_sprite
@onready var random_position: Timer = $random_position
@onready var sword_area: Area2D = $sword_area


func _physics_process(delta: float) -> void:
	if GLOBAL.mouse_in_water:
		flip_sword_sprite(get_global_mouse_position())
		global_position = lerp(global_position, get_global_mouse_position() - sword_area.position, 0.02)
	elif get_tree().get_nodes_in_group("food").size() > 0:
		var target_food = get_tree().get_nodes_in_group("food")[0]
		#var target_pos = target_food.global_position - Vector2(sword_sprite.sword_area.position.x, 0)
		global_position = lerp(global_position, target_food.global_position - sword_area.position, 0.02)
		flip_sword_sprite(target_food.global_position)
	else:
		position = lerp(position, random_position.target_position, 0.02)
		flip_sword_sprite(random_position.target_position + global_position)

func flip_sword_sprite(_target_position):
	# called from _physics_process()
	if _target_position.x < global_position.x:
		sword_sprite.flip_h = true
	else:
		sword_sprite.flip_h = false

```

**sword_area.gd**
```gdscript
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

```

**sword_sprite.gd**
```gdscript
extends Sprite2D
@export var sword_area: Area2D
@export var images: Array[CompressedTexture2D]
@export var sound_pop: AudioStreamPlayer2D

var food_counter: int = 0

func _ready() -> void:
	var tween_rotate = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_rotate.tween_property(self, "rotation_degrees", 6, 2)
	tween_rotate.tween_property(self, "rotation_degrees", -6, 3)

	var tween_vertical = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween_vertical.tween_property(self, "position:y", 8, 1)
	tween_vertical.tween_property(self, "position:y", -8, 2)
	tween_vertical.tween_property(self, "position:y", 3, 1)


func _physics_process(delta: float) -> void:
	#if GLOBAL.mouse_in_water:
	#it was making the collision shape always fixed towards where the mouse last was
	var actual_width: float = texture.get_width() * scale.x
	if flip_h == false:
		sword_area.position.x = actual_width/2
	else:
		sword_area.position.x = -actual_width/2

func set_image(_index):
	texture = images[_index]
	sound_pop.play_sound()

func grow():
	food_counter += 1
	if food_counter == 10:
		set_image(0)
	elif food_counter == 20:
		set_image(1)
	elif food_counter == 30:
		set_image(2)

```

**tooltip.gd**
```gdscript
extends Sprite2D

@export var images: Array[CompressedTexture2D]
func _ready() -> void:
	GLOBAL.show_tooltip.connect(set_image)
	GLOBAL.hide_tooltip.connect(remove_image)

func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, get_global_mouse_position() + Vector2(20,-15), 0.5)

func set_image(_index):
	texture = images[_index]

func remove_image():
	texture = null

```

**water_button.gd**
```gdscript
extends TextureButton

func _ready() -> void:

	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	pressed.connect(on_pressed)
	if texture_normal:
		# Get the image from the texture normal
		var image = texture_normal.get_image()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_click_mask = bitmap

func on_mouse_entered():
	GLOBAL.mouse_in_water = true
	GLOBAL.show_tooltip.emit(4)

func on_mouse_exited():
	GLOBAL.mouse_in_water = false
	GLOBAL.hide_tooltip.emit()
func on_pressed():
	GLOBAL.water_clicked.emit(get_global_mouse_position())

```

**world.gd**
```gdscript
extends Node2D


func _ready() -> void:
	get_window().min_size = Vector2i(150,150)

func _physics_process(delta: float) -> void:
	get_window().size.x = get_window().size.y

```

