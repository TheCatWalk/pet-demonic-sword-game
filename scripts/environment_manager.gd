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
