extends Control

func _ready():
	$BackButton.onclick_handler = _on_back_btn_pressed
	%DifficultyToggle.selected_text = U.lang("MENU")[79] # Easy
	%TutorialToggle.selected_text = U.lang("MENU")[84] # Yea, Sure!
	%SoundToggle.selected_text = U.lang("MENU")[29] # On
	%AutosaveToggle.selected_text = U.lang("MENU")[29] # On

func _on_back_btn_pressed() -> void:
	self.visible = false
	$"../ClassSelectionUI".visible = true

func _on_play_button_pressed() -> void:
	print("[DEBUG] Difficulty set to: ", str(G.Difficulty))
	print("[DEBUG] Tutorial enabled: ", str(G.Do_Tutorial))
	print("[DEBUG] Sound_Enabled set to: " + str(G.Sound_Enabled))
	print("[DEBUG] Autosave_Enabled set to: " + str(G.Autosave_Enabled))
	print("[DEBUG] Player class is set to: ", G.STATE.PlayerClass.name)
	#TODO Start the combat scene with tutorial values, ignoring whatever class was selected and shit.
