extends Control

@export var text: String = ""
var _text_node: Label

@export var onclick_handler: Callable  # just store the function

func _ready():
	_text_node = $BoxContainer/Text
	_text_node.text = text
	_text_node.text = U.lang("MENU")[26] # Back
	_text_node.get_node("Button").pressed.connect(self._on_pressed)

func _on_pressed():
	if onclick_handler != null:
		onclick_handler.call()
