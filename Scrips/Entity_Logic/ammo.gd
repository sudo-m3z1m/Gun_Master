extends ITEM

@export var ammo_quant: int

func give_effect(_player) -> bool:
	if _player.current_weapaon.ammo:
		_player.current_weapon.ammo += ammo_quant
		return true
	else:
		return false
