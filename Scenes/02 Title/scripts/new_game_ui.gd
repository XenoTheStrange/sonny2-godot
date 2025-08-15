extends Node2D

func _on_line_edit_text_submitted(new_text: String) -> void:
	attempt_to_proceed(new_text)

func _on_ok_btn_pressed() -> void:
	attempt_to_proceed($LineEdit.text)

func attempt_to_proceed(char_name):
	if not char_name == "":
		print("[INFO] Character name is " + char_name)
		U.toggle_visibility(self)
		U.toggle_visibility($"../ClassSelectionUI")

func _on_back_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../SonnyLogo")
	U.toggle_visibility($"../PostStartUI")
