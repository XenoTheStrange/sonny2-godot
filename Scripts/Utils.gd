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
