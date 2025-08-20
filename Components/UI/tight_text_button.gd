@tool
extends BoxContainer

@export var text: String:
	set(value):
		%Text.text = value
	get:
		return %Text.text

@export var onclick_handler: Callable  # just store the function

func _ready():
	%Text/Button.pressed.connect(self._on_pressed)

func _on_pressed():
	if onclick_handler != null:
		onclick_handler.call()
