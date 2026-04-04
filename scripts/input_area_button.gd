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
