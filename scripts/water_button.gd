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
func on_mouse_exited():
	GLOBAL.mouse_in_water = false
func on_pressed():
	GLOBAL.water_clicked.emit(get_global_mouse_position())
