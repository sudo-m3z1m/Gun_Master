extends CharacterBody2D
class_name character

signal killed

@export var speed = 400
@export var health_points: float:
	set(hp):
		$Camera/HPBar._check_value(hp)
		health_points = hp

var weapon = null
var weapon_scale
var k
var id_for_weapons: Dictionary
var id_for_rigid: Dictionary

var _weapon_is_picked: bool = false

var _is_killed: bool = false

@onready var scene = get_tree().current_scene
@onready var screen = $Camera.get_viewport_rect().size

func _ready():
	k = scene.get_scale() / get_scale()

func _physics_process(delta):
	rotate_weapon()
	pass

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
				throw_weapon(get_global_mouse_position())
				
func attack():
	weapon._attack(get_global_mouse_position())

func _collision_checker(body):
	if body.is_in_group("Weapon") and _weapon_is_picked == false:
		take_weapon(body)
		scene.remove_child(body)

func take_weapon(_weapon):
	_weapon_is_picked = true
	weapon = _weapon
	weapon._is_picked = _weapon_is_picked
	weapon.size = get_scale() / k
	call_deferred("add_child", weapon)
	weapon.position = Vector2(0, 0)

func throw_weapon(target_position):
	_weapon_is_picked = false
	weapon.throw_self(self.global_position, target_position)

func pause():
	var pause_screen = $Camera/HUD
	pause_screen._enable()
	get_tree().paused = true

func kill():
	hide()
	$Camera.set_enabled(false)
	$HitBox.set_deferred("disabled", true)
	$Area_for_Hurt_Box/HurtBox.set_deferred("disabled", true)

	_is_killed = true

	emit_signal("killed", _is_killed)

func rotate_weapon():
	if _is_killed or _weapon_is_picked == false:
		return
		
	var angle = get_angle_to(get_global_mouse_position())
	weapon.rotate_to_target(angle, global_position)

func save():
	var save_dict = {
		"parent": get_parent(),
		"scene": get_scene_file_path(),
		"pos_x": global_position.x,
		"pos_y": global_position.y,
		"weapon": weapon,
		"current_hp": health_points,
		"size_x": get_scale().x,
		"size_y": get_scale().y
	}
	return save_dict
