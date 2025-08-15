extends Node2D

@onready var modtext = $RightPanel/ScrollContainer/ManualScreenBlurb

func _ready() -> void:
	modtext.text = G.LANG['ManualDefault']

func _on_how_to_play_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx0']

func _on_what_does_it_mean_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx1']

func _on_team_control_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx2']

func _on_stat_explanation_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx3']

func _on_help_am_stuck_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx4']

func _on_back_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../SonnyLogo")
	U.toggle_visibility($"../TitleScreenUI")
	modtext.text = G.LANG['ManualDefault']
