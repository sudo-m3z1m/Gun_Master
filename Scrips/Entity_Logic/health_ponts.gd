extends ITEM

@export var hp_quant: int

func give_effect(_player) -> void:
	if _player.health_points < 100:
		_player.health_points += hp_quant
