@icon("res://Sprites/Weapons/Bullet.png")
extends RigidBody2D

class_name projectile

@export var projectile_speed: float
@export var damage: float

var direction: Vector2

func shot(_target_position):
	rotation = get_angle_to(_target_position)
	
	direction = _target_position - global_position
	direction = direction.limit_length(1)
	
	var velocity = direction * projectile_speed
	linear_velocity = velocity
	$DisapearTimer.start()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("Mob"):
		Damage_MANAGE._give_damage(self, body, direction)
		queue_free()

func disapear():
	call_deferred("queue_free")
