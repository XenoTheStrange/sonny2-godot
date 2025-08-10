extends Control

func _ready():
	#Create buttons for all of the classes
	for class_data in G.PLAYER_CLASSES:
		_spawn_class_button($ClassesContainer/HBoxContainer, class_data)

# In the scene where you're creating it
func _spawn_class_button(parent, class_data):
	var btn_scene = preload("res://Components/buttons/ClassSelectButton.tscn")
	var btn = btn_scene.instantiate()
	btn.data = class_data
	parent.add_child(btn)

func _on_back_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../NewGameUI")
