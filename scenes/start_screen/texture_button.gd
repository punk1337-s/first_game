extends TextureButton

var original_scale := Vector2.ONE
var hover_scale := Vector2(1.2, 1.2)

func _on_mouse_entered() -> void:
	scale = hover_scale


func _on_mouse_exited() -> void:
	scale = original_scale

func _ready():
	pivot_offset = size / 2

func _init() -> void:
	print('idi_naxui')
