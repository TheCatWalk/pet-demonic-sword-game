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
