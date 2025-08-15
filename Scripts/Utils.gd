extends Node

"""Takes a node, either toggle its visibility or force it to be true or false. Optionally call some function afterward"""
func toggle_visibility(node, force=false):
	if not force == false:
		node.visible = force
		return
	node.visible = not node.visible

func destroy_slot_instances(container):
	for child in container.get_children():
		child.queue_free()

func go_to_scene(scene_object):
	var new_scene = scene_object.instantiate()
	get_tree().root.add_child(new_scene)  # add to tree first
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene

func go_to_scene_by_path(scene_path):
	get_tree().change_scene_to_file.call_deferred(scene_path)
