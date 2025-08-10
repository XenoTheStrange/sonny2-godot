@tool
extends Node

var LANG = {}
var STATE = {
	"PLAYER": {}
}
var PLAYER_CLASSES = [
	load("res://Resources/Classes/Psychological.tres"),
	load("res://Resources/Classes/Biological.tres"),
	load("res://Resources/Classes/Hydraulic.tres"),
	load("res://Resources/Classes/Dummy.tres")
	]

func set_language(lang):
	var script = load("res://Languages/" + lang + ".gd").new()
	LANG = script.define_texts()
