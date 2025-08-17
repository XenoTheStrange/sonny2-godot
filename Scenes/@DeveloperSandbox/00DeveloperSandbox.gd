extends Node2D

@export var background_color: Color:
	set(value):
		$Background.color = value

@onready var model1_animations = $Model1.animation_player.get_animation_list()
@onready var template_button = $AnimationsHelper/AnimationPanel/TemplateButton
@onready var anim_panel_vbox = %AnimationHelperPanelVBox

func _ready():
	populate_animations_list()

func populate_animations_list():
	$Model1.animation_player.current_animation = model1_animations[0] #RESET animation
	for anim_name in model1_animations:
		new_animation_button(anim_name)

func new_animation_button(anim_name):
	var btn = template_button.duplicate()
	btn.text = anim_name
	btn.show()
	btn.pressed.connect(on_new_animation_button_pressed.bind(anim_name))
	anim_panel_vbox.add_child(btn)
	
func on_new_animation_button_pressed(anim_name):
	$Model1.animation_player.current_animation = "RESET"
	$Model1.animation_player.current_animation = anim_name
	pass

func _on_color_picker_color_changed(color: Color) -> void:
	background_color = color
	pass # Replace with function body.

func _on_change_background_color_button_pressed() -> void:
	U.toggle_visibility(%BGColorPicker)

func _on_play_animation_pressed() -> void:
	$Model1.animation_player.play()

func _on_pause_animation_pressed() -> void:
	$Model1.animation_player.pause()

func _on_select_animation_pressed() -> void:
	if %AnimationHelperPanelVBox.visible == true:
		U.toggle_visibility(%AnimationHelperPanelVBox)
		U.toggle_visibility($AnimationsHelper/AnimationPanel)
	else:
		$AnimationsHelper/AnimationPanel.visible = true
		%AnimationHelperPanelVBox.visible = true
		%ModelsHelperPanelVbox.visible = false

func _on_select_model_pressed() -> void:
	if %ModelsHelperPanelVbox.visible == true:
		U.toggle_visibility(%ModelsHelperPanelVbox)
		U.toggle_visibility($AnimationsHelper/AnimationPanel)
	else:
		$AnimationsHelper/AnimationPanel.visible = true
		%AnimationHelperPanelVBox.visible = false
		%ModelsHelperPanelVbox.visible = true
