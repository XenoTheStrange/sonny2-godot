extends Control

func _ready():
	$BackButton.onclick_handler = _on_back_btn_pressed
	#Create buttons for all of the classes
	var classes = Data.PlayerCLasses.values()  # now an Array
# Sort using a lambda with Godot 4's `sort()` that takes a comparison function
	classes.sort_custom(func(a, b):
		return a.ID < b.ID  # ascending
)
	for class_data in classes:
		_spawn_class_button($ClassesContainer/HBoxContainer, class_data)

# In the scene where you're creating it
func _spawn_class_button(parent, class_data):
	var btn_scene = preload("res://Scenes/TITLE/buttons/ClassSelectButton.tscn")
	var btn = btn_scene.instantiate()
	btn.data = class_data
	parent.add_child(btn)

func _on_back_btn_pressed() -> void:
	U.toggle_visibility(self)
	U.toggle_visibility($"../NewGameUI")
