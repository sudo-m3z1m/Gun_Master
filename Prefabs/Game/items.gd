extends Node

class_name ITEMS

@export var items: Dictionary
@export var weapons: Dictionary

func fill_weapons_dict(_dir_path: String = "res://Weapons/Range/") -> void:
	var dir: DirAccess = DirAccess.open(_dir_path)
	if !dir:
		printerr("Weapon directory doesn't exist :(")

	var files: PackedStringArray = dir.get_files()
	for file_name in files:
		var file_path: String = _dir_path + file_name
		var file_id: int = get_file_id(file_path)
		weapons[file_id] = load(file_path)

func fill_items_dict(_dir_path: String = "res://Items/disposable_items/Scenes/") -> void:
	var dir: DirAccess = DirAccess.open(_dir_path)
	if !dir:
		printerr("Item directory doesn't exist :(")

	var files: PackedStringArray = dir.get_files()

	for file_name in files:
		var file_path: String = _dir_path + file_name
		var file_id: int = get_file_id(file_path)
		items[file_id] = load(file_path)

func get_file_id(_file_path) -> int:
	var item_prop = load(_file_path)._bundled
	var item_id: int
	var item_id_index: int
	
	item_id_index = item_prop["names"].find("ID")
	item_id = item_prop["variants"][item_id_index as int]
	
	return item_id
