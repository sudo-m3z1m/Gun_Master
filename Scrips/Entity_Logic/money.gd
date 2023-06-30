extends Area2D

func _ready():
	body_entered.connect(give_money_to_player)
	
func give_money_to_player(body) -> void:
	if body.is_in_group("Player"):
		body.money += 1
		queue_free()
