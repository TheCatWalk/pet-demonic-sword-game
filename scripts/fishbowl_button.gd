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
