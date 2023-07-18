extends Node
class_name INVENTORY

var weapons: Array[WEAPON]
var items: Array[Area2D]

var player: PhysicsBody2D

func add_item(item: Area2D) -> void:
	player = get_tree().get_first_node_in_group("Player")
	if item is WEAPON:
		player.get_node("WeaponHandler").take_weapon(item)
		return
	items.append(take_item(item))

func take_item(_prod: Area2D) -> Area2D:
	_prod.give_effect(player)
	return _prod

func get_player_cur_weapon() -> Area2D:
	if player:
		return player.current_weapon

	printerr("player's node is not found")
	return null

func set_player_cur_weapon(_weapon: Area2D) -> void:
	if player:
		player.current_weapon = _weapon
		return
	printerr("player's node is not found")
