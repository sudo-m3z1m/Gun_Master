extends Node

static func identifiers_for_weapon(_id, _weapon)-> Dictionary:
	var id: Dictionary
	print(_weapon)
	_weapon = "res://Prefabs/Weapons/" + _weapon + ".tscn"
	_weapon = load(_weapon).instantiate()
	id[_id] = _weapon
	return id

static func identifiers_for_rigid(_id, _rigid) -> Dictionary:
	var id_for_rigid: Dictionary
	_rigid = "res://Prefabs/Weapons/Throwable_weapons/" + _rigid + ".tscn"
	_rigid = load(_rigid).instantiate()
	id_for_rigid[_id] = _rigid
	return id_for_rigid
