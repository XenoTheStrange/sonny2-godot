extends Node

var LANG = {}

func set_language(lang):
	var script = load("res://Languages/" + lang + ".gd").new()
	LANG = script.define_texts()
