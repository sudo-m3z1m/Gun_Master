extends ITEM

class_name DisposableItem

func add_self_to_inventory(_player: character) -> void:
	give_effect(_player)

func give_effect(_player) -> void:
	pass
