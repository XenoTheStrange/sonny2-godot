extends Node2D

func _ready():
	#TODO move this shit to a dedicated init function maybe idk man.
	#Also, make the language select screen. OH WAIT I CAN DO IT THERE LMAO
	set_screen_window_type()
	G.set_language("english")
	
	if Config.get_setting("skip_intro") == true:
		print("[INFO] Skipping Armor Games intro animation")
		go_to_title()
	else:
		$ArmorGamesIntro.play()
		$ArmorGamesIntro/ArmorGamesAudio.play()

func go_to_title():
	print("[INFO] Loading Title")
	get_tree().change_scene_to_file.call_deferred("res://Scenes/Title/title_main.tscn")

func set_screen_window_type():
	var setting = Config.get_setting("fullscreen")
	print("[INFO] Window setting is " + str(setting))
	if setting == "windowed":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if setting == "fullscreen" or setting == "borderless":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if setting == "borderless":
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

func _on_armor_games_intro_animation_finished() -> void:
	go_to_title()
