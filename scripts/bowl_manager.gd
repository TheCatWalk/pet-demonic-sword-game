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
	if sword == null: return

	# Handle Manual Input (Mouse)
	if sword.is_chasing_manual:
		sword.chase_position = get_global_mouse_position()

	# Handle Food Targeting (Check children directly instead of groups)
	var foods = food_container.get_children()
	if foods.size() > 0:
		sword.current_target = foods[0]
	else:
		sword.current_target = null

func _on_water_entered():
	var sword = get_node_or_null("Gameplay/Sword")
	if sword:
		sword.is_chasing_manual = true
	tooltip.show_tooltip(4)

func _on_water_exited():
	var sword = get_node_or_null("Gameplay/Sword")
	if sword:
		sword.is_chasing_manual = false
	tooltip.hide_tooltip()

func _on_water_pressed(pos):
	food_container.spawn_food(pos)

func _on_button_hovered(index):
	tooltip.show_tooltip(index)

func _on_button_unhovered():
	tooltip.hide_tooltip()
