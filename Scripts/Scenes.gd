extends Node

var	scene_paths = {
		DEV_SANDBOX = "res://Scenes/@DeveloperSandbox/00DeveloperSandbox.tscn",
		LOAD_GAME = "res://Scenes/00 Load Game/00LoadGame.tscn",
		ARMOR_INTRO = "res://Scenes/01 Intro/01Intro.tscn",
		TITLE = "res://Scenes/02 Title/02TitleMain.tscn"
	}

func load_scene(path):
	return load(path)
