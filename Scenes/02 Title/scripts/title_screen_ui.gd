extends Node2D

func _on_start_button_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../PostStartUI")

func _on_game_manual_button_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../SonnyLogo")
	U.toggle_visibility($"../GameManualUI")

func _on_play_more_games_button_pressed() -> void:
	OS.shell_open("https://www.armorgames.com/")

func _on_play_sonny_1_button_pressed() -> void:
	OS.shell_open("https://armorgames.com/play/505/sonny")

func _on_credits_button_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../CreditsUI")
