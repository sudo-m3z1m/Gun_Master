extends Node2D

class_name SAVE_HANDLER

const SAVE_FILE_DIRECTORY = "res://Saves/saves.save"
const GROUP = "Persist"

func save_game():
	var save_file = FileAccess.open(SAVE_FILE_DIRECTORY, FileAccess.WRITE)
	if save_file == null:
		return

	var save_nodes = get_tree().get_nodes_in_group(GROUP)
	var json_object = JSON.new()
	
	var json_str
	
	for node in save_nodes:
		if node.has_method("save") == false:
			return
		
		json_str = json_object.stringify(node.save())
		save_file.store_line(json_str)
	save_file.close()
	
func load_game():
	if !FileAccess.file_exists(SAVE_FILE_DIRECTORY):
		printerr("Error, file not exist!")
	
	var save_nodes = get_tree().get_nodes_in_group(GROUP)
	
	for n in save_nodes:
		n.queue_free()
	
	var save_file = FileAccess.open(SAVE_FILE_DIRECTORY, FileAccess.READ)
	var json_object = JSON.new()
	
	while save_file.get_position() < save_file.get_length():
		var json_parse = json_object.parse(save_file.get_line())
			
		if json_parse != OK:
			printerr("Parsing error")
		
		var save_data = json_object.get_data()
		
		var new_saved_object = load(save_data["scene"]).instantiate()
		if str(get_parent()) == save_data["parent"]:
			get_parent().add_child(new_saved_object)
		else:
			get_parent().get_node(save_data["parent"]).add_child(new_saved_object)#call_deferred("add_child", new_saved_object)
			print(new_saved_object)
		new_saved_object.position.x = save_data["pos_x"]
		new_saved_object.position.y = save_data["pos_y"]
		new_saved_object.scale.x = save_data["size_x"]
		new_saved_object.scale.y = save_data["size_y"]
		
		#print(new_saved_object.position, new_saved_object.scale)
		
		for i in save_data.keys():
			if i == "pos_x" or i == "pos_y" or i == "parent" or i == "scene":
				continue
			set(i, save_data[i])
