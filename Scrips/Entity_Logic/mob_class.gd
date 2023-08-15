extends CharacterBody2D

class_name Mob_class

@export var health_points: float
@export var states: Dictionary
@export var max_speed: float
@export_dir var weapon_path
@export_dir var money_path

@onready var agent: NavigationAgent2D = $Agent
@onready var path_timer: Timer = $PathUpdateTimer
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var player: Object = get_tree().get_first_node_in_group("Player")
@onready var raycast: RayCast2D = $RayCast2D
@onready var sprite: AnimatedSprite2D = $Sprite

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
		add_child(weapon)
		weapon._is_active = true

func rotate_weapon():
	$RayCast2D.set_target_position(player.global_position)
	var angle_to_target = get_angle_to(player.global_position)
	weapon.rotate_to_target(angle_to_target)

func spawn(position: Vector2, scene):
	global_position = position
	scene.add_child(self)
	weapon_ready()
	#Animations

func instantiate_money() -> void:
	for rew_count in reward:
		var coin: Area2D = load(money_path).instantiate()
		coin.position = position
		get_tree().current_scene.call_deferred("add_child", coin)

func attack(target):
	weapon._attack(target.global_position)

func kill():
	instantiate_money()
	queue_free()
