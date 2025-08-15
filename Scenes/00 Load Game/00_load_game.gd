extends Node2D

var loading_done = false
var resources_loading: Array[Array]
var resources_failed_to_load: Array[ResourceLoader]
var loading_stage := 0
@onready var progress_bar = $TextureProgressBar
@onready var start_button = $PlayButton

func _ready():
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
	progress_bar.max_value = resources_loading.size()
	progress_bar.value = 0
	loading_stage = 1

"""Grab from file an index of known scenes in object notation, NAME: "res://path.
Start loading them. _process() will poll for their status and call a function when the're all done."""
func queue_load_scenes():
	var Scenes = load("res://Scripts/Scenes.gd").new()
	progress_bar.max_value = Scenes.scene_paths.size()
	var value: String
	for key in Scenes.scene_paths:
		value = Scenes.scene_paths[key]
		print("[DEBUG] Starting load of resource -- " + key, ": ", value)
		ResourceLoader.load_threaded_request(value)
		resources_loading.append([key, value])



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
	pass

func handle_thread_load_failed(LoadData: Array):
	resources_failed_to_load.append(LoadData)
	print("[ERROR] Resource failed to load at: " + LoadData[0][0] + LoadData[0][1])
	resources_loading.erase(LoadData)

func handle_invalid_resource_error(LoadData: Array):
	print("[ERROR] Resource is invalid at  + LoadData[0][0] + LoadData[0][1]")
	resources_loading.erase(LoadData)
	pass

func handle_resouce_load_finished(LoadData: Array):
	print("[DEBUG] Resource finished loading at \"" + LoadData[1] + "\" with key + \"" + LoadData[0] + "\"")
	var data = ResourceLoader.load_threaded_get(LoadData[1])
	Data.Scenes[LoadData[0]] = data
	resources_loading.erase(LoadData)
	progress_bar.value += progress_bar.step

# BUTTONS
func _on_start_button_pressed() -> void:
	for i in Data.Scenes:
		print(i)
	if G.DEVMODE:
		U.go_to_scene(Data.Scenes["DEV_SANDBOX"])
	else:
		U.go_to_scene(Data.Scenes["TITLE"])
