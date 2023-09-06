extends Area2D

class_name Coin

var magnet_target_position: Vector2
const MAGNET_SPEED: float = 600

var target: PhysicsBody2D
@onready var player: PhysicsBody2D = get_tree().get_first_node_in_group("Player")

func _ready():
	GameManager.magnetize.connect(set_magnetize_target)
	body_entered.connect(give_money_to_target)

func _process(delta):
	apply_magnet_velocity(delta)

func give_money_to_target(body) -> void:
	if body.is_in_group("Player"):
		SoundManager.coins_player.play()
		body.money += 1
		queue_free()

func set_magnetize_target():
	target = player

func apply_magnet_velocity(delta) -> void:
	if !target:
		return
	magnet_target_position = target.global_position
	global_position += global_position.direction_to(magnet_target_position)\
	.normalized() * MAGNET_SPEED * delta
