@icon("res://Sprites/Weapons/Gun.png")
extends Area2D

class_name WEAPON

@export_category("Weapon properties")
@export var ID: int = 0
@export var damage: int
@export var cooldown: float
@export_dir var throwable_version_path
@export var length_from_player: float
@export var animation: String
@export var throw_strength: float #might be a const :>

@onready var pivot = $Pivot
@onready var hitbox = $HitBox
@onready var weapon_dict = get_parent().get_node("/root/WeaponDict")

var _ready_to_shot: bool

const ENEMY_GROUP = ["Player", "Mob", "Projectile"]

var _is_picked: bool = false:
	set(is_picked):
		_is_picked = is_picked
		change_state()

func _ready():
	throwable_load()

func change_state() -> void:
	if _is_picked == true:
		pivot.position.x = length_from_player
		hitbox.set_deferred("disabled", true)
		_ready_to_shot = true
		return
	else:
		pivot.position.x = 0
		self.visible = false
		return
	
func rotate_to_target(angle_to_target, global_scale: Vector2) -> void:
	if _is_picked == false:
		return
	rotation = angle_to_target
	if abs(rotation_degrees) >= 90:
		scale.y = -global_scale.y
	else:
		scale.y = global_scale.y

func throwable_load():
	weapon_dict.main_dict[ID] = load(throwable_version_path)

func throw_self(global_target_position: Vector2) -> void: #I need to write it in player script
	var throw_velocity = global_position.\
	direction_to(global_target_position) * 100000
	if throw_velocity.length() < 1:
		throw_velocity *= 100000

	throw_velocity = throw_velocity.limit_length(throw_strength)
	
	var throwable_weapon = weapon_dict.main_dict[ID].instantiate()
	throwable_weapon.global_position = pivot.global_position
	throwable_weapon.rotation = rotation
	get_tree().current_scene.add_child(throwable_weapon)
	throwable_weapon.set_owner(get_tree().current_scene)
	throwable_weapon.apply_impulse(throw_velocity)
	
	_is_picked = false

func _on_cooldown_timer_timeout():
	_ready_to_shot = true
