extends Control

func _ready():
	$BackButton.onclick_handler = _on_back_btn_pressed

func Load():
	add_button_instance($"../PVPArenaUI/ScrollContainer/VBoxContainer", 1, "FAKE_ENTRY")

func _on_button_pressed(num):
	print("[TODO] Clicked slot number " + str(num))

func add_button_instance(target, num=0, fname=false):
	var button_scene := preload("res://Scenes/TITLE/buttons/save_file_text_1.tscn")
	var instance = button_scene.instantiate()
	var button = instance.get_node("MarginContainer/SlotLoadBtn")  # adjust path if deeper
	var slotlabel = instance.get_node("MarginContainer/HBoxContainer/SlotNumber")
	var filenamelabel = instance.get_node("MarginContainer/HBoxContainer/FileName")
	slotlabel.text += (" " + str(num)) 
	if fname is String:
		filenamelabel.text = fname
	button.pressed.connect(func():
		_on_button_pressed(num)
)  # bind for context
	target.add_child(instance)
	return instance

func _on_back_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../PostStartUI")
	U.toggle_visibility($"../SonnyLogo")
	U.destroy_slot_instances($ScrollContainer/VBoxContainer)
