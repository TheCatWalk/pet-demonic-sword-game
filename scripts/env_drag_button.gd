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
