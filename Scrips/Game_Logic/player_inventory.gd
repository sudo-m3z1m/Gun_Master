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
