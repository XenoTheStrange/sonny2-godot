extends Control

@onready var modtext = $RightPanel/ScrollContainer/ManualScreenBlurb

func _ready() -> void:
	$BackButton.onclick_handler = _on_back_btn_pressed
	
	modtext.text = U.lang("EXPLAINEXTRA")
	$LeftPanel/HowToPlayBtn/HowToPlayText.text = U.lang("MANUAL")[0]
	$LeftPanel/WhatDoesItMeanBtn/WhatDoesItMeanText.text = U.lang("MANUAL")[1]
	$LeftPanel/TeamControlBtn/TeamControlText.text = U.lang("MANUAL")[2]
	$LeftPanel/StatExplanationBtn/StatExplanationText.text = U.lang("MANUAL")[3]
	$LeftPanel/HelpAmStuckBtn/HelpAmStuckText.text = U.lang("MANUAL")[4]

func _on_how_to_play_btn_pressed() -> void:
	modtext.text = U.lang("MANUALEX")[0]

func _on_what_does_it_mean_btn_pressed() -> void:
	modtext.text = U.lang_colored("MANUALEX", 1)

func _on_team_control_btn_pressed() -> void:
	modtext.text = U.lang("MANUALEX")[2]

func _on_stat_explanation_btn_pressed() -> void:
	modtext.text = U.lang("MANUALEX")[3]

func _on_help_am_stuck_btn_pressed() -> void:
	modtext.text = U.lang("MANUALEX")[4]

func _on_back_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../SonnyLogo")
	U.toggle_visibility($"../TitleScreenUI")
	modtext.text = U.lang("EXPLAINEXTRA")
