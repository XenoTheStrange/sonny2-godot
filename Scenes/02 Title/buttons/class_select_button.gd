extends Node

@export var data: ClassData

func _ready():
	if data:
		$ClassName.text = data.name
		self.texture = data.icon
		$ClassName.self_modulate = data.glow_color
	if self.material:
		self.material = self.material.duplicate(true)  # deep copy, including subresources

var current_tween = null
var saturation: float = 0.0

func _on_button_mouse_entered() -> void:
	if current_tween: current_tween.kill()
	current_tween = get_tree().create_tween()
	current_tween.tween_property(self.material, "shader_parameter/saturation", 1.0, 0.25)

func _on_button_mouse_exited() -> void:
	if current_tween: current_tween.kill()
	current_tween = get_tree().create_tween()
	current_tween.tween_property(self.material, "shader_parameter/saturation", 0.0, 0.25)

func _on_button_pressed(title_root) -> void:
	print(title_root)
	print("[TODO] Clicked ClassSelectButton " + "\"" + data.name + "\"")
	for classname in G.PLAYER_CLASSES.keys():
		var class_res = G.PLAYER_CLASSES[classname]
		if class_res.name == data.name:
			G.STATE.PlayerClass = class_res
			break
	$"../../../../ClassSelectionUI".visible = false
	$"../../../../ChooseSettingsUI".visible = true
