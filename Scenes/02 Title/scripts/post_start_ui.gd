extends Node2D

func _on_load_game_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../SonnyLogo")
	U.toggle_visibility($"../LoadGameUI")
	$"../LoadGameUI".Load()
	#TODO create loading function and make these buttons actually do something based on what slot they're targeting, etc.

func _on_new_game_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../SonnyLogo")
	U.toggle_visibility($"../NewGameUI")

func _on_pvp_arena_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../SonnyLogo")
	U.toggle_visibility($"../PVPArenaUI")
	$"../PVPArenaUI".Load()

func _on_back_btn_pressed() -> void:
		U.toggle_visibility($"../TitleScreenUI")
		U.toggle_visibility(self)
