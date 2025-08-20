extends Node

var	scene_paths = {
		DEV_SANDBOX = "res://Scenes/DEV_SANDBOX/MAIN.tscn",
		LOAD_GAME = "res://Scenes/LOAD_GAME/MAIN.tscn",
		ARMOR_INTRO = "res://Scenes/INTRO/MAIN.tscn",
		TITLE = "res://Scenes/TITLE/MAIN.tscn"
	}

func load_scene(path):
	return load(path)
