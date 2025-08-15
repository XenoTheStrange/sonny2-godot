@tool
extends Node

var DEVMODE: bool = true
var DEVMODE_TARGET_SCENE = "DEV_SANDBOX"
var LANG = {}

var PLAYER_CLASSES := {
	PSYCHOLOGICAL = load("res://Resources/Classes/Psychological.tres"),
	BIOLOGICAL    = load("res://Resources/Classes/Biological.tres"),
	HYDRAULIC     = load("res://Resources/Classes/Hydraulic.tres"),
	DUMMY         = load("res://Resources/Classes/Dummy.tres")
}

enum DIFFICULTIES {
	EASY = 1,
	CHALLENGING = 2,
	HEROIC = 3
}

var STATE = {
	PlayerName = "Name",
	PlayerClass = PLAYER_CLASSES.PSYCHOLOGICAL
}

func set_language(lang):
	var script = load("res://Languages/" + lang + ".gd").new()
	LANG = script.define_texts()
