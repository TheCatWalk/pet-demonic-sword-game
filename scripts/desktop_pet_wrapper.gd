extends Node2D

func _ready() -> void:
	get_window().min_size = Vector2i(150, 150)
	$World.drag_requested.connect(_on_drag_requested)
	$World.resize_requested.connect(_on_resize_requested)
	$World.quit_requested.connect(on_quit)
	$World.reset_requested.connect(on_reset)

func _physics_process(_delta: float) -> void:
	get_window().size.x = get_window().size.y

func _on_drag_requested() -> void:
	get_window().start_drag()

func _on_resize_requested() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_BOTTOM_RIGHT)

func on_quit() -> void:
	get_tree().quit()

func on_reset() -> void:
	get_tree().reload_current_scene()
