extends Node

const PATH := "user://config.cfg"
var config := ConfigFile.new()

var default_settings := {
	"skip_intro": false,
	"fullscreen": "windowed",
	"volume": 1
}

func _ready():
	load_or_create_config()

func load_or_create_config():
	var err = config.load(PATH)
	if err != OK:
		# File doesn't exist; apply defaults
		for key in default_settings:
			config.set_value("settings", key, default_settings[key])
		save()
	else:
		# Fill in any missing keys
		for key in default_settings:
			if not config.has_section_key("settings", key):
				config.set_value("settings", key, default_settings[key])
		save()

func get_setting(key: String, fallback = null):
	return config.get_value("settings", key, fallback)

func set_setting(key: String, value):
	config.set_value("settings", key, value)
	save()

func save():
	config.save(PATH)
