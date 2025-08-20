extends Node

@export var data: ClassData

func _ready():
	if data:
		if data.ID < U.lang("CLASS").size():
			$ClassName.text = U.lang("CLASS")[data.ID]
		else:
			$ClassName.text = data.lang[G.LANGC]
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
	for classname in Data.PlayerCLasses.keys():
		var class_res = Data.PlayerCLasses[classname]
		if class_res.name == data.name:
			G.STATE.PlayerClass = class_res
			break
	$"../../../../ClassSelectionUI".visible = false
	$"../../../../ChooseSettingsUI".visible = true
