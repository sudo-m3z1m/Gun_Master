extends CharacterBody2D
class_name character

@export var max_speed: float
@export var health_points: float:
	set(hp):
		HUD.update_user_hud(hp, GlobalScope.GLOBAL_HUDS.HP)
		health_points = hp

@export var money: int:
	set(mon):
		HUD.update_user_hud(mon, GlobalScope.GLOBAL_HUDS.COIN)
		money = mon

var friction: float = 45
var acceleration: float = 90
var direction: Vector2

@onready var scene = get_tree().current_scene
#@onready var screen = $Camera.get_viewport_rect().size
@onready var weapon_handler = $WeaponHandler

func _ready():
	EffectsManager.give_effect(GlobalScope.EFFECTS.POISON, self, 20, 3.0, 1)

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

func _collision_checker(area):
	if area.is_in_group("Weapon"):
		PlayerInventory.add_item(area);

func bodies_collision_checker(body):
	weapon_handler.take_throwed_weapon(body)

func kill():
	GameManager.stop_game()
	call_deferred("queue_free")
