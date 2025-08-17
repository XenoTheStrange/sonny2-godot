extends Node2D

var loading_done = false
var resources_loading: Array[Array]
var resources_failed_to_load: Array[ResourceLoader]
var loading_stage := 0
@onready var progress_bar = $TextureProgressBar
@onready var start_button = $PlayButton

enum filetypes {
	SCENE,
	MODEL
}

func _ready():
	progress_bar.max_value = 0
	set_screen_window_type()
	G.set_language("english")
	load_game()

func set_screen_window_type():
	var setting = Config.get_setting("fullscreen")
	print("[INFO] Window setting is " + str(setting))
	if setting == "windowed":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if setting == "fullscreen" or setting == "borderless":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if setting == "borderless":
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

func load_game():
	queue_load_scenes()
	queue_load_models()
	progress_bar.value = 0
	loading_stage = 1

"""Grab from file an index of known scenes in object notation, NAME: "res://path.
Start loading them. _process() will poll for their status and call a function when the're all done."""
func queue_load_scenes():
	var Scenes = load("res://Scripts/Scenes.gd").new()
	progress_bar.max_value += Scenes.scene_paths.size()
	var value: String
	for key in Scenes.scene_paths:
		value = Scenes.scene_paths[key]
		print("[DEBUG] Starting load of resource -- " + key, ": ", value)
		ResourceLoader.load_threaded_request(value)
		resources_loading.append([filetypes.SCENE, value, key])

func queue_load_models():
	var dir := DirAccess.open("res://Components/Models/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tscn"):
				progress_bar.max_value += 1
				var fullpath = "res://Components/Models/" + file_name
				var nam = file_name.get_basename()
				print("[DEBUG] Starting load of model -- " + nam)
				ResourceLoader.load_threaded_request(fullpath)
				resources_loading.append([filetypes.MODEL, fullpath, nam])
			file_name = dir.get_next()
		dir.list_dir_end()

func _process(_delta):
	match loading_stage:
		0: return # Have not started
		1: update_loading_bar()
		2: proceed()
		3: return # Finished

func update_loading_bar():
	for LoadData in resources_loading:
		check_resource_loaded_status(LoadData)
	if resources_loading.size() == 0:
		loading_stage = 2

func proceed():
	loading_stage = 3
	if Config.get_setting("skip_intro") == true:
		print("[INFO] Skipping Armor Games intro animation")
	if G.DEVMODE:
		U.go_to_scene(Data.Scenes[G.DEVMODE_TARGET_SCENE])
	else:
		progress_bar.visible = false
		start_button.visible = true


# HELPER FUNCTIONS FOR LOADING
func check_resource_loaded_status(LoadData: Array):
	var status = ResourceLoader.load_threaded_get_status(LoadData[1])
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS: pass
		ResourceLoader.THREAD_LOAD_FAILED: handle_thread_load_failed(LoadData)
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE: handle_invalid_resource_error(LoadData)
		ResourceLoader.THREAD_LOAD_LOADED: handle_resouce_load_finished(LoadData)

func handle_thread_load_failed(LoadData: Array):
	resources_failed_to_load.append(LoadData)
	print("[ERROR] Resource failed to load at: " + LoadData[1])
	resources_loading.erase(LoadData)

func handle_invalid_resource_error(LoadData: Array):
	print("[ERROR] Resource flagged as invalid at " + LoadData[1])
	resources_loading.erase(LoadData)
	pass

func handle_resouce_load_finished(LoadData: Array):
	print("[DEBUG] Resource finished loading at \"" + LoadData[1])
	var data = ResourceLoader.load_threaded_get(LoadData[1])
	if LoadData[0] == filetypes.SCENE:
		Data.Scenes[LoadData[2]] = data
	if LoadData[0] == filetypes.MODEL:
		Data.Models[LoadData[2]] = data
	resources_loading.erase(LoadData)
	progress_bar.value += progress_bar.step

# BUTTONS
func _on_start_button_pressed() -> void:
	if G.DEVMODE:
		U.go_to_scene(Data.Scenes["DEV_SANDBOX"])
	else:
		U.go_to_scene(Data.Scenes["TITLE"])
