extends Node2D

func _ready():
	pass

func _on_back_btn_pressed() -> void:
	self.visible = false
	$"../ClassSelectionUI".visible = true
	pass # Replace with function body.
