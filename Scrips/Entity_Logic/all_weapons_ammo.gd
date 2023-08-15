extends ITEM

func give_effect(_player: PhysicsBody2D) -> void:
	var inventory: INVENTORY = PlayerInventory
	for weapon in inventory.weapons:
		if weapon.get("ammo"):
			weapon.ammo = weapon.maximum_ammo_amount
