extends DisposableItem

func activate(_player: PhysicsBody2D) -> void:
	var inventory: INVENTORY = PlayerInventory
	var weapon_handler: WEAPON_HANDLER = _player.get_node_or_null("WeaponHandler")
	for weapon in inventory.weapons:
		weapon.ammo = weapon.maximum_ammo_amount
	weapon_handler.update_ammo_hud(weapon_handler.current_weapon)
	queue_free()
