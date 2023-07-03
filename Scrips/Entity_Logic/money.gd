extends Area2D

var magnet_target_position: Vector2
const MAGNET_SPEED: float = 600

var player: PhysicsBody2D

func _ready():
	body_entered.connect(give_money_to_player)

func _process(delta):
	apply_magnet_velocity(delta)

func give_money_to_player(body) -> void:
	if body.is_in_group("Player"):
		body.money += 1
		queue_free()

func set_player(_player):
	player = _player

func apply_magnet_velocity(delta) -> void:
	if !player:
		return
	magnet_target_position = player.global_position
	global_position += global_position.direction_to(magnet_target_position)\
	.normalized() * MAGNET_SPEED * delta
