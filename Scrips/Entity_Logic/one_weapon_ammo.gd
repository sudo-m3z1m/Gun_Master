extends ITEM

func give_effect(_player: PhysicsBody2D) -> void:
	var weapon_handler = _player.get_node_or_null("WeaponHandler")
	if weapon_handler.current_weapon.get("ammo"):
		weapon_handler.current_weapon.ammo = weapon_handler.current_weapon.maximum_ammo_amount
		return
