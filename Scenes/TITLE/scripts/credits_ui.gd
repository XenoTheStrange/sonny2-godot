extends Control

func _ready():
	$BackButton.onclick_handler = _on_back_btn_pressed
	$JobLabels/ProducerText.text = U.lang("MENU")[92]
	$JobLabels/ProductionAssistantText.text = U.lang("MENU")[93]
	$JobLabels/SoundAndMusicText.text = U.lang("MENU")[94]
	$JobLabels/AnimationText.text = U.lang("MENU")[95]
	$JobLabels/GraphicsAndArtworkText.text = U.lang("MENU")[96]
	$JobLabels/MaleCastText.text = U.lang("MENU")[97]
	$JobLabels/FemaleCastText.text = U.lang("MENU")[98]

func _on_back_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../TitleScreenUI")
