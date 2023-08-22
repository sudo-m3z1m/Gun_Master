extends DisposableItem

func give_effect(_player: PhysicsBody2D) -> void:
	var inventory: INVENTORY = PlayerInventory
	for weapon in inventory.weapons:
		weapon.ammo = weapon.maximum_ammo_amount
	queue_free()
