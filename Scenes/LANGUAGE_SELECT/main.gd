extends Node2D

func _ready():
	for lang in G.LANG:
		_spawn_lang_button($ScrollContainer/VBoxContainer, lang)

"""Expects the language dictionary to hold a path to its icon image at dict['LANGUAGE_FLAG_ICON']"""
func _spawn_lang_button(parent, lang):
	var btn_scene = preload("res://Scenes/LANGUAGE_SELECT/language_select_button.tscn")
	var btn = btn_scene.instantiate()
	btn.texture = load(G.LANG[lang]["LANGUAGE_FLAG_ICON"])
	btn.lang = lang
	parent.add_child(btn)
