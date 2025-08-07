extends Node2D

func Load():
	add_button_instance($"../PVPArenaUI/ScrollContainer/VBoxContainer", 1, "FAKE_ENTRY")

func _on_button_pressed(num):
	print("[TODO] Clicked slot number " + str(num))

func add_button_instance(target, num=0, name=false):
	var button_scene := preload("res://Components/buttons/save_file_text_1.tscn")
	var instance = button_scene.instantiate()
	var button = instance.get_node("MarginContainer/SlotLoadBtn")  # adjust path if deeper
	var slotlabel = instance.get_node("MarginContainer/CenterContainer/HBoxContainer/SlotNumber")
	var filenamelabel = instance.get_node("MarginContainer/CenterContainer/HBoxContainer/FileName")
	slotlabel.text += (" " + str(num)) 
	if name is String:
		filenamelabel.text = name
	button.pressed.connect(func():
		_on_button_pressed(num)
)  # bind for context
	target.add_child(instance)
	return instance

func _on_back_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../PostStartUI")
	U.toggle_visibility($"../Sonnylogo")
	U.destroy_slot_instances($ScrollContainer/VBoxContainer)
