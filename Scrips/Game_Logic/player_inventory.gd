extends Node
class_name INVENTORY

var weapons: Array[WEAPON]
var items: Array[Area2D]

var player: PhysicsBody2D

func add_item(item: Area2D) -> void:
	if item is WEAPON:
		weapons.append(item)
	if item is ITEM:
		items.append(item)

func delete_item(item: Area2D) -> void:
	if item is WEAPON:
		weapons.erase(item)
	if item is ITEM:
		items.erase(item)
