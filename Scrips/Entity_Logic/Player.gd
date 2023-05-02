extends CharacterBody2D
class_name character

signal killed

@export var speed = 400
@export var throwable_speed = 24
@export var health_points: float:
	set(hp):
		$HPBar._check_value(hp)
		health_points = hp

var weapon
var melee_atack_animation
var weapon_scale
var k
var mouse_pos
var weapon_animation_player
var id_for_weapons: Dictionary
var id_for_rigid: Dictionary

var _weapon_is_picked: bool = false

var _is_killed: bool = false

@onready var id = preload("res://Scrips/Game_Logic/Identifiers.gd")
@onready var scene = get_tree().current_scene
@onready var screen = $Camera3D.get_viewport_rect().size
#@onready var hp_bar = scene.get_node("/root/HpBar")

func _ready():
	k = scene.get_scale() / get_scale()

func _physics_process(delta):
	mouse_pos = get_global_mouse_position()
	rotate_weapon()
	#hp_bar._check_value()

func choose_velocity(velocity, flip):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	$AnimatedSprite2D.flip_h = flip
	
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
	
func actions_handler(action):
	if action == "Escape":
		pause()
	
	if !weapon:
		return
	
	if _weapon_is_picked and _is_killed == false:
		match action:
			"Attack":
				attack()
			"Throw":
				throw_weapon(id_for_rigid[weapon.id], weapon)
				
func attack():
	weapon._attack(get_global_mouse_position())

func _collision_area_checker(area):
	if _is_killed == false:
		if area.is_in_group("Weapon") and area.\
		get_parent().get_parent()._is_picked == false:
			var almost_weapon = area.get_parent().get_parent()
			
			id_for_weapons.merge(\
			almost_weapon.return_identifiers("Weapon"), false)
			id_for_rigid.merge(\
			almost_weapon.return_identifiers("Rigid"), false)
			
			weapon_scale = area.get_parent().get_parent().set_hand_scale(k)
			take_weapon(id_for_weapons[almost_weapon.id], almost_weapon)

func take_weapon(root, picked):
	scene.remove_child(picked)
	weapon = root
	weapon_animation_player = weapon.get_node("AnimationPlayer")
	call_deferred("add_child", weapon)
	
	weapon.position = Vector2()
	
	weapon.set_scale(weapon_scale)
	
	weapon._make_ready(200)
	
	weapon.set_deferred("_is_picked", true)

func _collision_checker(body):
	if _is_killed == false:
		if _weapon_is_picked == false and body\
		.is_in_group("Weapon_throw"):
			take_weapon(id_for_weapons[body.id], body)

func throw_weapon(root, _weapon):
	var weapon_rigid
	weapon_rigid = root
	
	var throw_velocity
	throw_velocity = (mouse_pos - global_position) * throwable_speed
	throw_velocity = throw_velocity.limit_length(1700)
	
	weapon_rigid.position = weapon._throwable_weapon_start_pos().global_position
	weapon_rigid.rotation = _weapon.rotation
	
	_weapon._is_picked = false
	remove_child(_weapon)
	
	scene.add_child(weapon_rigid)
	weapon_rigid.apply_impulse(throw_velocity, Vector2(0.0, 0.0))

func pause():
	var pause_screen = $Camera3D/HUD
	pause_screen._enable()
	get_tree().paused = true

func kill():
	hide()
	$Camera3D.set_enabled(false)
	$HitBox.set_deferred("disabled", true)
	$Area_for_Hurt_Box/HurtBox.set_deferred("disabled", true)

	_is_killed = true

	emit_signal("killed", _is_killed)

func rotate_weapon():
	if _is_killed or _weapon_is_picked == false:
		return
	var target_angle = get_angle_to(get_global_mouse_position())
	weapon.rotation = target_angle
	
	if get_local_mouse_position().x < 0:
		weapon.scale.y = -weapon_scale.y
		
	if get_local_mouse_position().x > 0:
		weapon.scale.y = weapon_scale.y
