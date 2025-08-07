extends Node

var LANG = {}
var STATE = {
	"PLAYER": {}
}

func set_language(lang):
	var script = load("res://Languages/" + lang + ".gd").new()
	LANG = script.define_texts()
