extends Node

class_name PickupManager

static func give_item_to_target(_target: PhysicsBody2D, _item) -> void:
	if _item is WEAPON:
		_target.weapon_handler.take_weapon(_item) #Now it need to be here
	if _item is ITEM:
		_item.activate(_target)
	if _item is DisposableItem:
		_item.activate(_target)
