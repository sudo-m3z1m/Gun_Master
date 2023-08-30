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
#@onready var screen = $Camera.get_viewport_rect().sizea
@onready var weapon_handler = $WeaponHandler

#func _ready():
#	EffectsManager.try_apply_effect(GlobalScope.EFFECTS.POISON, self, 1, 1, 0.1)

func _physics_process(delta):
	set_character_velocity()
	move_and_slide()

func set_direction(_direction):
	flip_handler(_direction)
	direction = _direction

func flip_handler(_new_dir: Vector2):
	if _new_dir.x < 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func set_character_velocity() -> void:
	if direction.length() != 0:
		velocity = velocity.move_toward(direction.normalized() * max_speed, acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)

func _collision_checker(area):
	PlayerInventory.add_item(area)

func bodies_collision_checker(body):
	weapon_handler.take_throwed_weapon(body)

func kill():
	GameManager.stop_game()
	call_deferred("queue_free")

func change_modulate(_modulate: Color):
	$Sprite.set_modulate(_modulate)
