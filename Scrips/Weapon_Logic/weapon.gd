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

@onready var pivot: Node = $Pivot
@onready var hitbox: Node = $HitBox
@onready var weapon_dict = get_parent().get_node("/root/WeaponDict")

const ENEMY_GROUP: Array = ["Mob", "Projectile"]
const throw_strength: float = 600

var _is_throwed: bool = false
var _is_active: bool = false:
	set(is_active):
		if _is_throwed == true:
			return
		_is_active = is_active
		change_state()

func _ready():
	load_to_items()
	throwable_load()

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

func rotate_to_target(angle_to_target, global_scale: Vector2) -> void:
	if _is_active == false:
		return
	rotation = angle_to_target
	if abs(rotation_degrees) >= 90:
		scale.y = -global_scale.y
	else:
		scale.y = global_scale.y

func throwable_load():
	weapon_dict.main_dict[ID] = load(throwable_version_path) # it's literally useless. I need to rewrite this

func load_to_items():
	$"/root/Items".items[ID] = load(scene_file_path)

func throw_self(global_target_position: Vector2) -> void:
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
	
	_is_active = false
	return
