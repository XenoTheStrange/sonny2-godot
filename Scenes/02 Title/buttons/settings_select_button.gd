@tool
extends Control

var _label_text := ""
var _selected_text := ""

@export var label_text: String:
	set(value):
		_label_text = value
		#if Engine.is_editor_hint():
		%SettingLabel.text = value
	get():
		return _label_text

@export var selected_text: String:
	set(value):
		_selected_text = value
		#if Engine.is_editor_hint():
		%SettingValueLabel.text = value
	get():
		return _selected_text

func toggle_config_bool(setting):
	var value = Config.get_setting(setting)
	print("[DEBUG] Value of setting " + "\"" + setting + "\" " + "changing from " + str(value) +  " to " + str(not value))
	value = not value
	Config.set_setting(setting, value)

func toggle_on_off(label):
	if label.text == "On":
		label.text = "Off"
	else:
		label.text = "On"

func _on_button_pressed() -> void:
	var btn = %SettingLabel
	var label = %SettingValueLabel
	var setting = btn.text.substr(0, btn.text.length() - 1)
	print("[DEBUG] Button clicked: Settings: " + setting)
	if setting == "Autosave":
		toggle_on_off(label)
		toggle_config_bool("Autosave")
	if setting == "Sound":
		toggle_on_off(label)
		toggle_config_bool("sound_on")
