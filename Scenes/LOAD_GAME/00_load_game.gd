extends Node2D

var loading_done = false
var resources_loading: Array[Array]
var resources_failed_to_load: Array[ResourceLoader]
var loading_stage := 0
@onready var progress_bar = $TextureProgressBar
@onready var start_button = $PlayButton

enum filetypes {
	SCENE,
	MODEL,
	SPRITE,
	CLASS
}

func _ready():
	progress_bar.max_value = 0
	set_screen_window_type()
	load_language_folder("res://Languages/")
	load_game()

func load_language_folder(path: String):
	var dir := DirAccess.open(path)
	if not dir:
		push_error("Cannot open folder: " + path)
		return

	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.to_lower().ends_with(".json"):
			var full_path = path.path_join(file_name)
			var data = U.load_json(full_path)
			if data.size() > 0:
				var key = file_name.get_basename()
				G.LANG[key] = data
				print("[DEBUG] Loaded JSON file at: ", full_path)
		file_name = dir.get_next()
	dir.list_dir_end()


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
	load_from_dir(filetypes.CLASS, "res://Resources/Classes/")
	load_from_dir(filetypes.SPRITE, "res://Sprites/")
	load_from_dir(filetypes.SCENE, "res://Scenes/")
	load_from_dir(filetypes.MODEL, "res://Components/Models/")
	progress_bar.value = 0
	loading_stage = 1

"""Grab from file an index of known scenes in object notation, NAME: "res://path.
Start loading them. _process() will poll for their status and call a function when the're all done."""


func load_from_dir(type, path: String):
	var dir := DirAccess.open(path)
	if not dir:
		return

	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		match type:
			filetypes.MODEL:
				if not dir.current_is_dir() and file_name.ends_with(".tscn"):
					var fullpath = path.path_join(file_name)
					progress_bar.max_value += 1
					var nam = file_name.get_basename()
					print("[DEBUG] Starting load of model " + nam)
					ResourceLoader.load_threaded_request(fullpath)
					resources_loading.append([type, fullpath, nam])

			filetypes.SCENE:
				if dir.current_is_dir() and not file_name.begins_with("."):
					var main_scene_path = path.path_join(file_name).path_join("MAIN.tscn")
					if ResourceLoader.exists(main_scene_path):
						progress_bar.max_value += 1
						var nam = file_name.get_basename()
						print("[DEBUG] Starting load of scene " + nam)
						ResourceLoader.load_threaded_request(main_scene_path)
						resources_loading.append([type, main_scene_path, nam])
			filetypes.SPRITE:
				var image_exts = [".png", ".jpg", ".jpeg", ".webp", ".bmp", ".tga"]
				if dir.current_is_dir() and not file_name.begins_with("."):
					# recurse into subdirectory
					load_from_dir(type, path.path_join(file_name))
				elif not dir.current_is_dir():
					for ext in image_exts:
						if file_name.to_lower().ends_with(ext):
							var fullpath = path.path_join(file_name)
							progress_bar.max_value += 1
							var nam = file_name.get_basename()
							print("[DEBUG] Starting load of sprite " + nam)
							ResourceLoader.load_threaded_request(fullpath)
							resources_loading.append([type, fullpath, nam])
							break
			filetypes.CLASS:
				if not dir.current_is_dir() and file_name.ends_with(".tres"):
					var fullpath = path.path_join(file_name)
					progress_bar.max_value += 1
					var nam = file_name.get_basename()
					print("[DEBUG] Starting load of Class data: " + nam)
					ResourceLoader.load_threaded_request(fullpath)
					resources_loading.append([type, fullpath, nam])


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

func _set_nested_dict(base: Dictionary, keys: Array[String], value):
	var current = base
	for i in range(keys.size() - 1):
		var k = keys[i]
		if not current.has(k):
			current[k] = {}
		current = current[k]
	current[keys.back()] = value

func handle_resouce_load_finished(LoadData: Array):
	print("[DEBUG] Resource finished loading at \"" + LoadData[1])
	var data = ResourceLoader.load_threaded_get(LoadData[1])
	match LoadData[0]:
		filetypes.SCENE:
			Data.Scenes[LoadData[2]] = data
		filetypes.MODEL:
			Data.Models[LoadData[2]] = data
		filetypes.SPRITE:
			# turn the relative path (without res:// and extension) into keys
			var rel_path = LoadData[1].trim_prefix("res://")      # Sprites/Armorsets/Ninja/arm.png
			var parts = rel_path.split("/")                       # ["Sprites","Armorsets","Ninja","arm.png"]
			parts.remove_at(0)                                    # optionally strip "Sprites" if you don’t want it
			parts[parts.size() - 1] = parts[-1].get_basename() # drop extension for last element
			_set_nested_dict(Data.Sprites, parts, data)
		filetypes.CLASS:
			Data.PlayerCLasses[LoadData[2].to_upper()] = data
	resources_loading.erase(LoadData)
	progress_bar.value += progress_bar.step

# BUTTONS
func _on_start_button_pressed() -> void:
	U.go_to_scene(Data.Scenes.LANGUAGE_SELECT)
