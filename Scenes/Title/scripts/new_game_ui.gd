extends Node2D

func _on_line_edit_text_submitted(new_text: String) -> void:
	attempt_to_proceed(new_text)

func _on_ok_btn_pressed() -> void:
	attempt_to_proceed($LineEdit.text)

func attempt_to_proceed(name):
	if not name == "":
		print("[INFO] Character name is " + name)
		U.toggle_visibility(self)
		U.toggle_visibility($"../ClassSelectionUI")
