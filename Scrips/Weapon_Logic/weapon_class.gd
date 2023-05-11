@icon("res://Sprites/Weapons/Gun.png")
extends RigidBody2D

class_name WEAPON

@export_category("Weapon properties")
@export var damage: int
@export var length_from_player: float
@export var animation: String
@export var throw_strength: float #might be a const :>

@onready var pivot = $Pivot
@onready var hitbox = $HitBox

const ENEMY_GROUP = ["Player", "Mob", "Projectile"]

var _is_picked: bool = false:
	set(picked):
		_is_picked = picked
		take_weapon()
var size: Vector2:
	set(_new_size):
		size = _new_size
		_resize(_new_size)

func _ready():
	size = Vector2(0.3, 0.3)

func _resize(_scale: Vector2) -> void:
	pivot.set_scale(_scale)
	hitbox.set_scale(_scale)
	#If we have more nodes we will append it later :|

func take_weapon() -> void:
	if _is_picked == true:
		pivot.position.x = length_from_player
		hitbox.set_deferred("disabled", true)
		return
	else:
		pivot.position.x = 0
		hitbox.set_deferred("disabled", false)
		return
	
func rotate_to_target(angle_to_target, target_position: Vector2) -> void:
	rotation = angle_to_target
	#print(position, get_parent())
	if target_position.x < 0:
		size.y = -size.y

	if target_position.x > 0:
		size.y = -size.y 
	#it may drop some conflicts >:

func throw_self(aim_position: Vector2, target_position: Vector2) -> void:
	var throw_velocity = aim_position.direction_to(target_position) * 100000
	if throw_velocity.length() < 1:
		throw_velocity *= 100000
	
	throw_velocity = throw_velocity.limit_length(throw_strength)
	
	_is_picked = false
	self.apply_impulse(throw_velocity)
