extends Node
class_name INVENTORY

var weapons: Array[WEAPON]
var items: Array[Area2D]

var player: character

func add_item(item: Area2D) -> void:
	if item is WEAPON:
		player.weapon_handler.take_weapon(item)
		return
	item.activate(player)

func delete_item(item: Area2D) -> void:
	if item is WEAPON:
		weapons.erase(item)
	if item is ITEM:
		items.erase(item)
