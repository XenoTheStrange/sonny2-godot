extends Node2D

func _ready():
	$ArmorGamesIntro.play()
	$ArmorGamesIntro/ArmorGamesAudio.play()

func go_to_title():
	print("[INFO] Switching to scene: Title")
	U.go_to_scene(Data.Scenes.TITLE)

func _on_armor_games_intro_animation_finished() -> void:
	go_to_title()
