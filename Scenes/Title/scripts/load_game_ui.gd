extends Node2D

func Load():
	add_button_instance($"../LoadGameUI/ScrollContainer/VBoxContainer", 1, "I am jesus christ, your lord and savior") #filler for now
	return

func _on_back_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../PostStartUI")
	U.toggle_visibility($"../Sonnylogo")
	U.destroy_slot_instances($ScrollContainer/VBoxContainer)
	
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

func add_spacer(target):
	var spacer = ColorRect.new()
	spacer.color = Color(0, 0, 0, 0)  # fully transparent
	spacer.custom_minimum_size = Vector2(0, 1)
	# It doens't need to be big since the seperation in the scroll box elements will increase it by like 50
	target.add_child(spacer)
