extends Node

var _lang: String = "ENGLISH"
var _glow_color: Color = Color(1,1,1,1)

@export var lang: String:
	set(value):
		_lang = value
		$"../LangName".text = value
	get:
		return _lang

@export var glow_color: Color:
	set(value):
		_glow_color = value
		$"../LangName".self_modulate = value
	get:
		return _glow_color

func _ready():
	if self.material:
		self.material = self.material.duplicate(true)  # deep copy, including subresources

var current_tween = null
var saturation: float = 0.0

func _on_button_mouse_entered() -> void:
	if current_tween: current_tween.kill()
	current_tween = get_tree().create_tween()
	current_tween.tween_property(self.material, "shader_parameter/saturation", 1.0, 0.25)

func _on_button_mouse_exited() -> void:
	if current_tween: current_tween.kill()
	current_tween = get_tree().create_tween()
	current_tween.tween_property(self.material, "shader_parameter/saturation", 0.0, 0.25)

func _on_button_pressed() -> void:
	G.LANGC = lang
	print(lang)
	if Config.get_setting("skip_intro") == true:
		print("[INFO] Skipping Armor Games intro animation")
		U.go_to_scene(Data.Scenes.TITLE)
	else:
		U.go_to_scene(Data.Scenes.ARMOR_INTRO)
