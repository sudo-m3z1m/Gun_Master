extends DisposableItem

@export var hp_quant: int

func activate(_player) -> void:
	if _player.health_points < 100:
		_player.health_points += hp_quant
