extends DisposableItem

func give_effect(_player: PhysicsBody2D) -> void:
	var weapon_handler = _player.get_node_or_null("WeaponHandler")
	var cur_weapon_max_ammo: int = weapon_handler.current_weapon.maximum_ammo_amount
	
	weapon_handler.current_weapon.ammo = cur_weapon_max_ammo
	
	queue_free()
