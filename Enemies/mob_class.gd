extends CharacterBody2D

class_name Mob_class

@export var start_hp: int
@export var states: Dictionary
@export var max_speed: float
@export var cooldown_time: float #Don't touch this! It need to be here, try to think again
@export var weapon_scene: PackedScene
@export var money_scene: PackedScene

@onready var state_machine: EnemyStateMachine = $StateMachine
@onready var agent: NavigationAgent2D = $Agent
@onready var path_timer: Timer = $PathUpdateTimer
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var player: Object = get_tree().get_first_node_in_group("Player")
@onready var raycast: RayCast2D = $RayCast2D
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var health_points: HealthPoints = HealthPoints.new(self, start_hp)

var weapon: WEAPON
var reward: int = 0 #It will be in kill manager

func set_reward(_reward):
	reward = _reward

func move():
	move_and_slide()

func weapon_ready():
	weapon = weapon_scene.instantiate()
	add_child(weapon)
	weapon._is_active = true

func rotate_weapon():
	raycast.set_target_position(to_local(player.global_position))
	var angle_to_target = get_angle_to(player.global_position)
	weapon.rotate_to_target(angle_to_target)

func spawn(position: Vector2, scene):
	global_position = position
	scene.add_child(self)
	#Animations

func instantiate_money() -> void:
	for rew_count in reward:
		var coin: Area2D = money_scene.instantiate()
		coin.position = position
		get_tree().current_scene.call_deferred("add_child", coin)

func attack(target):
	weapon.attack(target.global_position)

func set_damage_effect() -> void:
	pass

func set_heal_effect() -> void:
	pass

func kill():
	instantiate_money()
	queue_free()
