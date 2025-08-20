extends BoxContainer

@export var lang: String = "ENGLISH":
	set(value):
		$HBoxContainer/LangSelectButton.lang = value
	get:
		return $HBoxContainer/LangSelectButton.lang
@export var glow_color: Color = Color(1,1,1,1):
	set(value):
		$HBoxContainer/LangSelectButton.glow_color = value
	get:
		return $HBoxContainer/LangSelectButton.glow_color
@export var texture: Texture2D:
	set(value):
		$HBoxContainer/LangSelectButton.texture = value
	get:
		return $HBoxContainer/LangSelectButton.texture
