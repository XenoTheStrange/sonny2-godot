extends AnimatedSprite2D

func _ready():
	#TODO move this shit to a dedicated init function maybe idk man.
	#Also, make the language select screen. OH WAIT I CAN DO IT THERE LMAO
	set_screen_window_type()
	G.set_language("english")
	
	if Config.get_setting("skip_intro") == true:
		go_to_title()
	else:
		play("ArmorGamesIntro")

func _on_animation_finished() -> void:
	go_to_title()

func go_to_title():
	get_tree().change_scene_to_file.call_deferred("res://Scenes/title_screen.tscn")

func set_screen_window_type():
	var setting = Config.get_setting("fullscreen")
	if setting == "windowed":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if setting == "fullscreen" or setting == "borderless":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if setting == "borderless":
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
