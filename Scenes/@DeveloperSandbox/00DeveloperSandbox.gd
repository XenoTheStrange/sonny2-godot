extends Node2D

@export var background_color: Color:
	set(value):
		$Background.color = value

func _ready():
	pass

func _on_color_picker_color_changed(color: Color) -> void:
	background_color = color
	pass # Replace with function body.

func _on_change_background_color_button_pressed() -> void:
	U.toggle_visibility(%BGColorPicker)
