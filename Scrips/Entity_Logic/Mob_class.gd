extends CharacterBody2D

class_name Mob_class

@export var health_points: float
@export var speed: float
@export_dir var weapon_path
@export_dir var money_path

@onready var player: Object = get_tree().get_nodes_in_group("Player")[0]

var weapon: Node2D
var _weapon_is_picked: bool = false
var reward: int = 0

var attacked_groups: Array = ["Player"]

func set_reward(_reward):
	reward = _reward

func move():
	move_and_slide()

func weapon_ready():
	if weapon_path:
		weapon = load(weapon_path).instantiate()
		weapon.set_scale(Vector2(0.5, 0.5))
		weapon._make_ready(350)
		add_child(weapon)
		weapon._is_picked = true

func rotate_weapon():
	$RayCast2D.set_target_position(player.global_position)
	var angle_to_target = get_angle_to(player.global_position)
	weapon.set_rotation(angle_to_target)

func spawn(position: Vector2, scene):
	global_position = position
	scene.call_deferred("add_child", self)
	weapon_ready()
	#Animations

func instantiate_money() -> void:
	for rew_count in reward:
		var coin: Area2D = load(money_path).instantiate()
		coin.position = position
		get_tree().current_scene.call_deferred("add_child", coin)

func attack(target):
	weapon._attack(target.global_position)

func check_hp(_damage) -> void:
	health_points -= _damage
	if health_points <= 0:
		kill()

func kill():
	instantiate_money()
	queue_free()
