@icon("res://Sprites/Weapons/Bullet.png")
extends RigidBody2D

class_name Projectile

@export var projectile_speed: float
@export var damage: float
@export var disapear_time: float
@export var effect_duration: float
@export var T: float

@onready var disapear_timer = $DisapearTimer

var direction: Vector2

func shot(_damage: float, _target_pos: Vector2, speed: float = 500.0, effect_dur: float = 0.0, t: float = 0.0):
	projectile_speed = speed
	damage = _damage
	effect_duration = effect_dur
	T = t
	direction = global_position.direction_to(_target_pos)
	rotation = direction.angle()
	
	linear_velocity = direction * projectile_speed
	disapear_timer.start(disapear_time)

func check_bodies(_body) -> void:
	if _body.get("health_points"):
		_give_damage(_body)
	despawn()

func _give_damage(_body) -> void:
	DAMAGE_MANAGER._give_damage(self, _body, direction * 10, 0.1)

func despawn():
	queue_free()
