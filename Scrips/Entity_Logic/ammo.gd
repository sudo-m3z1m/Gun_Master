extends ITEM

@export var ammo_quant: int

func give_effect(_player: PhysicsBody2D) -> bool:
	var weapon_handler = _player.get_node_or_null("WeaponHandler")
	if weapon_handler.current_weapon:
		weapon_handler.current_weapon.ammo += ammo_quant
		return true
	else:
		return false
