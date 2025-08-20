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
	if label.text == U.lang("MENU")[29]: # On
		label.text = U.lang("MENU")[30] # Off
	else:
		label.text = U.lang("MENU")[29]

func _on_button_pressed() -> void:
	var btn = %SettingLabel
	var label = %SettingValueLabel
	var setting = btn.text.substr(0, btn.text.length() - 1)
	print("[DEBUG] Button clicked: Settings: " + setting)
	match setting:
		"Tutorial Level":
			if G.Do_Tutorial:
				G.Do_Tutorial = not G.Do_Tutorial
				label.text = U.lang("MENU")[83] # No thanks
			else:
				G.Do_Tutorial = not G.Do_Tutorial
				label.text = U.lang("MENU")[84] # Yea sure
		"Difficulty":
			G.Difficulty = G.DIFFICULTIES.values()[(int(G.Difficulty) + 1) % G.DIFFICULTIES.size()]
			label.text = U.lang("MENU")[79 + G.Difficulty] #Easy
		"Autosave":
			G.Autosave_Enabled = not G.Autosave_Enabled
			toggle_on_off(label)
		"Sound":
			G.Sound_Enabled = not G.Sound_Enabled
			toggle_on_off(label)
