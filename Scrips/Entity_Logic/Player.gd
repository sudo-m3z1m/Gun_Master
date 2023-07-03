extends CharacterBody2D
class_name character

signal killed

@export var max_speed: float
@export var health_points: float:
	set(hp):
		$Camera/HPBar._check_value(hp)
		health_points = hp
@export var money: int:
	set(mon):
		money = mon
		$Camera/MoneyScore.update_score(mon)
const K = 1.2

var friction: float = 45
var acceleration: float = 90
var weapons: Array = []
var current_weapon = null
var weapon_scale
#var character_move_velocity: Vector2 = Vector2.ZERO


var _is_killed: bool = false

@onready var scene = get_tree().current_scene
@onready var screen = $Camera.get_viewport_rect().size

func _ready():
	weapon_scale = get_scale() / K

func _physics_process(delta):
	rotate_weapon()
#	velocity = lerp(velocity, Vector2.ZERO, friction)
#	velocity += character_move_velocity
#	velocity = velocity.limit_length(max_speed) # * delta
	move_and_slide()

func choose_velocity(_direction, flip):
	if _direction.length() != 0:
		velocity = velocity.move_toward(_direction.normalized() * max_speed, acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)
#	character_move_velocity = _direction * player_acceleration
	$AnimatedSprite2D.flip_h = flip

func actions_handler(action):
	if action == "Escape":
		pause()
	
	if !current_weapon:
		return
	
	if current_weapon._is_active and _is_killed == false:
		match action:
			"Attack":
				attack()
			"Throw":
				throw_weapon(get_global_mouse_position())
	if weapons[0] and _is_killed == false:
		match action:
			"ScrollUp":
				change_weapon_from_array(weapons.find(current_weapon) + 1)
			"ScrollDown":
				change_weapon_from_array(weapons.find(current_weapon) - 1)

func attack():
	current_weapon.attack(get_global_mouse_position())

func _collision_checker(area):
	if area.is_in_group("Weapon"):
		take_weapon(area)
		scene.remove_child(area)

func bodies_collision_checker(body):
	if _is_killed == true:
		return
	for weapon in weapons:
		if weapon._is_throwed == true\
		and weapon.get_name() == body.get_name():
			body.queue_free()
			weapon._is_throwed = false
			change_weapon_from_array(weapons.find(weapon))

func take_weapon(_weapon):
	weapons.append(_weapon)
	
	change_weapon_from_array(-1)
	current_weapon.scale = weapon_scale
	call_deferred("add_child", current_weapon)
	current_weapon.call_deferred("set_owner", scene)
	current_weapon.position = Vector2(0, 0)
	if current_weapon.ammo:
		update_ammo(current_weapon.ammo)

func throw_weapon(target_position):
	current_weapon.throw_self(target_position)
	current_weapon._is_throwed = true

func rotate_weapon():
	if _is_killed == true or !current_weapon:
		return
	var angle_to_target = get_angle_to(get_global_mouse_position())
	current_weapon.rotate_to_target(angle_to_target, weapon_scale)

func pause():
	var pause_screen = $Camera/HUD
	pause_screen._enable()
	get_tree().paused = true

func check_hp(_damage) -> void:
	health_points -= _damage
	if health_points <= 0:
		kill()

func kill():
	hide()
	$Camera.set_enabled(false)
	$HitBox.set_deferred("disabled", true)
	$Area_for_Hurt_Box/HurtBox.set_deferred("disabled", true)

	_is_killed = true

	emit_signal("killed", _is_killed)
	GameManager.stop_game()

func change_weapon_from_array(next_gun_index) -> void:
	if !current_weapon:
		current_weapon = weapons[-1]
		weapons[-1]._is_active = true
		return
	
	next_gun_index %= weapons.size()
	for buff_weapon in weapons:
		buff_weapon._is_active = false
	current_weapon = weapons[next_gun_index]
	weapons[next_gun_index]._is_active = true
	return

func update_ammo(ammo):
	$Camera/AmmoScore.update_ammo_score(ammo)
