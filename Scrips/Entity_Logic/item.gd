extends Area2D

class_name ITEM

@export var ID: int

func add_self_to_inventory(_player: character) -> void:
	PlayerInventory.add_item(self)
	give_effect(_player)

func give_effect(_player) -> void:
	pass
