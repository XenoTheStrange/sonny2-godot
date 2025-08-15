@tool
extends Control

@export var label_text: String:
	set(value):
		label_text = value
		$HBoxContainer/SettingLabel.text = value

@export var selected_text: String:
	set(value):
		selected_text = value
		$HBoxContainer/SettingSelectedLabel.text = value
