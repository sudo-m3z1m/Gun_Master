@icon("res://Sprites/Weapons/Gun.png")
extends Area2D

class_name WEAPON

signal shot

@export_category("Weapon properties")
@export var ID: int
@export var damage: int
@export var cooldown: float
@export var maximum_ammo_amount: int
@export var ammo: int
@export var length_from_player: float
@export var shake_strength: float
@export var shake_time: float
@export var throwable_weapon: PackedScene
@export var main_animation: StringName
@export var attack_animation: StringName
@export var player_animation: StringName

@onready var pivot: Node = $Pivot
@onready var hitbox: Node = $HitBox
@onready var cooldown_timer: Timer = $Cooldown_Timer

const ENEMY_GROUP: Array = ["Mob", "Projectile"]
const throw_strength: float = 600

var _scale = get_scale()
var _is_active: bool = false:
	set(is_active):
		_is_active = is_active
		change_state()

func attack(_global_target_pos: Vector2):
	pass

func change_state() -> void:
	if _is_active == true:
		pivot.position.x = length_from_player
		hitbox.set_deferred("disabled", true)
		self.visible = true
		return
	else:
		pivot.position.x = 0
		self.visible = false
		return

func rotate_to_target(angle_to_target) -> void:
	if _is_active == false:
		return
	rotation = angle_to_target
	if abs(rotation_degrees) >= 90:
		scale.y = -_scale.y
	else:
		scale.y = _scale.y

func throw_self(global_target_position: Vector2) -> void:
	if !_is_active:
		return
		
	var throw_velocity := _get_vector_to_target(global_target_position)
	var throw_weap: RigidBody2D = inst_and_set_thr()
	get_tree().current_scene.add_child(throw_weap)
	throw(throw_weap, throw_velocity)
	
	_is_active = false
	return

func _get_vector_to_target(_global_target_pos: Vector2) -> Vector2:
	var vector_to_target = global_position.direction_to(_global_target_pos).normalized()
	vector_to_target *= throw_strength
	return vector_to_target

func inst_and_set_thr() -> RigidBody2D:
	var rigid_weapon = throwable_weapon.instantiate()
	
	rigid_weapon.global_position = pivot.global_position
	rigid_weapon.rot_degrees = rotation_degrees
	return rigid_weapon

func throw(_weapon: RigidBody2D, throw_vel: Vector2) -> void:
	_weapon.set_owner(get_tree().current_scene)
	_weapon.apply_impulse(throw_vel)

func _check_cooldown() -> bool:
	if cooldown_timer.is_stopped():
		return false
	return true

func add_self_to_inventory(_player: character) -> void:
	_player.weapon_handler.take_weapon(self)
