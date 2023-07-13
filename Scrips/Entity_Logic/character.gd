extends CharacterBody2D
class_name character

@export var max_speed: float
@export var health_points: float:
	set(hp):
		$Camera/HPBar._check_value(hp)
		health_points = hp
@export var money: int:
	set(mon):
		money = mon
		$Camera/MoneyScore.update_score(mon)

var friction: float = 45
var acceleration: float = 90
var direction: Vector2

@onready var scene = get_tree().current_scene
#@onready var screen = $Camera.get_viewport_rect().size
@onready var weapon_handler = $WeaponHandler

#func _ready():
#	$AnimatedSprite2D.frame_changed.connect(play_steps_audio)

func _physics_process(delta):
	set_character_velocity()
	move_and_slide()

func set_direction(_direction):
	flip_handler(_direction)
	direction = _direction

func flip_handler(_new_dir: Vector2):#, _old_dir: Vector2):
	if _new_dir.x < 0:
		$AnimatedSprite2D.flip_h = true #Суть в том, что вектор направления движ. выступает
	else:                               #чем-то вроде состояния, где > 0 это напр. вправо,
		$AnimatedSprite2D.flip_h = false#а < 0 - влево. Как по мне эта формулировка попроще.
#	if signi(_new_dir.x) != signi(_old_dir.x):
#		match signi(_new_dir.x):
#			-1:
#				$AnimatedSprite2D.flip_h = true
#			1:
#				$AnimatedSprite2D.flip_h = false

func set_character_velocity() -> void:
	if direction.length() != 0:
		velocity = velocity.move_toward(direction.normalized() * max_speed, acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)

func attack():
	weapon_handler.attack()	# IDLT

func throw_weapon(_target_global_pos: Vector2):	# IDLT
	weapon_handler.throw(_target_global_pos)

func _collision_checker(area):
	if area.is_in_group("Weapon"):
		PlayerInventory.add_item(area)

func bodies_collision_checker(body):
	weapon_handler.take_throwed_weapon(body)

func pause():
	get_tree().paused = true
	var pause_screen = $Camera/HUD
	pause_screen._enable()

func check_hp(_damage) -> void:	# IDLT
	health_points -= _damage
	if health_points <= 0:
		kill()

func kill():
	GameManager.stop_game()
	queue_free()

#func update_ammo(ammo):
#	$Camera/AmmoScore.update_ammo_score(ammo)	# IDLT

#func play_steps_audio():
#	if $AnimatedSprite2D.animation == "IDLE":	# IDLT
#		return
#	var pitch = randf_range(1, 1.5)
#	if $AnimatedSprite2D.frame == 2 or $AnimatedSprite2D.frame == 5:
#		SoundManager.steps_player.play()
