extends Node

"""Takes a node, either toggle its visibility or force it to be true or false"""
func toggle_visibility(node):
	node.visible = not node.visible

func destroy_slot_instances(container):
	for child in container.get_children():
		child.queue_free()

"""Takes a scene object, instantiates it, frees the last/current scene if there is one, then sets the new scene as current."""
func go_to_scene(scene_object):
	var new_scene = scene_object.instantiate()
	get_tree().root.add_child(new_scene)  # add to tree first
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene

func go_to_scene_by_path(scene_path):
	get_tree().change_scene_to_file.call_deferred(scene_path)

func print_nested_dict(d: Dictionary, indent: String = ""):
	for key in d.keys():
		var value = d[key]
		if typeof(value) == TYPE_DICTIONARY:
			print(indent + str(key) + ":")
			print_nested_dict(value, indent + "  ")
		else:
			print(indent + str(key) + " -> ", value)

# Load a JSON file from disk
func load_json(path: String) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Failed to open JSON file: " + path)
		return {}
	
	var json_text = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var err = json.parse(json_text)
	if err != OK:
		print("[ERROR] JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())
		push_error("[ERROR] JSON parse error in " + path + ": " + str(err))
		return {}
	
	return json.get_data()

func color(text: String) -> String:
	for nam in G.ELEMENTS:
		var element = G.ELEMENTS[nam]
		var hex_color = G.ELEMENT_COLORS[element]
		var tag = "[color=" + nam + "]"
		while text.find(tag) != -1:
			text = text.replace(tag, "[color=" + hex_color + "]")
	return text

func lang(key):
	return G.LANG.get(G.LANGC, null).get(key)

func lang_colored(key, subkey=null, subkey2=null):
	if subkey == null:
		return color(G.LANG.get(G.LANGC, null).get(key))
	elif subkey2 == null:
		return color(G.LANG.get(G.LANGC, null).get(key).get(subkey))
	else:
		return color(G.LANG.get(G.LANGC, null).get(key).get(subkey).get(subkey2))
