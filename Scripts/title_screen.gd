extends Node2D

var screen = "Title"

func toggle_visibility(node, force=null):
	if not force == null:
		node.visible = force
		return
	node.visible = not node.visible
	
func _on_start_button_pressed() -> void:
	screen = "PostStart"
	toggle_visibility($TitleScreenUI)
	toggle_visibility($PostStartUI)
	toggle_visibility($BackBtn)

func _on_game_manual_button_pressed() -> void:
	screen = "Manual"
	toggle_visibility($Sonnylogo)
	toggle_visibility($TitleScreenUI)
	toggle_visibility($GameManualUI)
	toggle_visibility($BackBtn)

func _on_play_more_games_button_pressed() -> void:
	OS.shell_open("https://www.armorgames.com/")

func _on_play_sonny_1_button_pressed() -> void:
	OS.shell_open("https://armorgames.com/play/505/sonny")

func _on_back_button_pressed() -> void:
	if screen == "Manual":
		modtext.text = G.LANG['ManualDefault']
		toggle_visibility($Sonnylogo)
		toggle_visibility($GameManualUI)
		toggle_visibility($TitleScreenUI)
		toggle_visibility($BackBtn)
		screen = "Title"
	if screen == "Credits":
		toggle_visibility($CreditsUI)
		toggle_visibility($TitleScreenUI)
		toggle_visibility($BackBtn)
		screen = "Title"
	if screen == "PostStart":
		toggle_visibility($PostStartUI)
		toggle_visibility($TitleScreenUI)
		toggle_visibility($BackBtn)
		screen = "Title"
	if screen == "New Game":
		toggle_visibility($NewGameUI)
		toggle_visibility($PostStartUI)
		toggle_visibility($Sonnylogo)
		screen = "PostStart"
	if screen == "Load Game":
		toggle_visibility($LoadGameUI)
		toggle_visibility($PostStartUI)
		toggle_visibility($Sonnylogo)
		destroy_slot_instances($LoadGameUI/ScrollContainer/VBoxContainer)
		screen = "PostStart"
	if screen == "PVP Arena":
		toggle_visibility($PVPArenaUI)
		toggle_visibility($PostStartUI)
		toggle_visibility($Sonnylogo)
		destroy_slot_instances($PVPArenaUI/ScrollContainer/VBoxContainer 
		
		
		
		
		
		
		)
		screen = "PostStart"

@onready var modtext = $GameManualUI/RightPanel/ScrollContainer/ManualScreenBlurb

func _on_how_to_play_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx0']

func _on_what_does_it_mean_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx1']

func _on_credits_button_pressed() -> void:
	screen = "Credits"
	toggle_visibility($TitleScreenUI)
	toggle_visibility($CreditsUI)
	toggle_visibility($BackBtn)

func _on_team_control_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx2']

func _on_stat_explanation_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx3']

func _on_help_am_stuck_btn_pressed() -> void:
	modtext.text = G.LANG['ManualEx4']

func _on_load_game_btn_pressed() -> void:
	screen = "Load Game"
	toggle_visibility($Sonnylogo)
	toggle_visibility($PostStartUI)
	toggle_visibility($LoadGameUI)
	#TODO create loading function and make these buttons actually do something based on what slot they're targeting, etc.
	add_button_instance($LoadGameUI/ScrollContainer/VBoxContainer, 1) #filler for now
	
func _on_button_pressed(num):
	print(num)

func add_spacer(target):
	var spacer = ColorRect.new()
	spacer.color = Color(0, 0, 0, 0)  # fully transparent
	spacer.custom_minimum_size = Vector2(0, 1)
	# It doens't need to be big since the seperation in the scroll box elements will increase it by like 50
	target.add_child(spacer)


func add_button_instance(target, num=0):
	var button_scene := preload("res://Components/save_file_text_1.tscn")
	var instance = button_scene.instantiate()
	var button = instance.get_node("SlotLoadBtn")  # adjust path if deeper
	var slotlabel = instance.get_node("SlotLoadBtn/SlotNumber")
	slotlabel.text += str(num)
	button.pressed.connect(func():
		_on_button_pressed(num)
)  # bind for context
	target.add_child(instance)
	return instance

func destroy_slot_instances(container):
	for child in container.get_children():
		child.queue_free()

func _on_new_game_btn_pressed() -> void:
	screen = "New Game"
	toggle_visibility($Sonnylogo)
	toggle_visibility($PostStartUI)
	toggle_visibility($NewGameUI)

func _on_pvp_arena_btn_pressed() -> void:
	screen = "PVP Arena"
	toggle_visibility($Sonnylogo)
	toggle_visibility($PostStartUI)
	toggle_visibility($PVPArenaUI)
	#TODO add logic to get game data or something with the buttons.
	add_button_instance($PVPArenaUI/ScrollContainer/VBoxContainer)
