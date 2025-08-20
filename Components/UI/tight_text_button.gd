@tool
extends BoxContainer

@export var text: String:
	set(value):
		_text_value = value
		if is_inside_tree() and %Text:
			%Text.text = value
	get:
		return _text_value

@export var onclick_handler: Callable

var _text_value: String = ""

func _ready():
	if %Text:
		%Text.text = _text_value
		if %Text.has_node("Button"):
			%Text/Button.pressed.connect(_on_pressed)

func _on_pressed():
	if onclick_handler and onclick_handler.is_valid():
		onclick_handler.call()
