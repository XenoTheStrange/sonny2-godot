extends Node2D

func _ready():
	$StartButton.text = U.lang("MENU")[18]
	$StartButton.onclick_handler = _on_start_button_pressed
	$VBoxContainer/GameManualButton.text = U.lang("MENU")[20]
	$VBoxContainer/GameManualButton.onclick_handler = _on_game_manual_button_pressed
	$VBoxContainer/PlayMoreGamesButton.text = U.lang("MENU")[19]
	$VBoxContainer/PlayMoreGamesButton.onclick_handler = _on_play_more_games_button_pressed
	$VBoxContainer/PlaySonny1Button.text = U.lang("MENU")[90]
	$VBoxContainer/PlaySonny1Button.onclick_handler = _on_play_sonny_1_button_pressed
	$VBoxContainer/CreditsButton.text = U.lang("MENU")[91]
	$VBoxContainer/CreditsButton.onclick_handler = _on_credits_button_pressed

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
