@icon("res://Sprites/Weapons/Gun.png")
extends RigidBody2D

class_name WEAPON_THROW

@export var damage: float
@export var rot_degrees: float:
	set(new_degrees):
		rot_degrees = new_degrees
		rotation_degrees = new_degrees
		flip(new_degrees)

const ENEMY_GROUPS = ["Mob"]

func _init():
	collision_layer = 2

func _throwing_collision_checker(body):
	for group in ENEMY_GROUPS:
		if body.is_in_group(group):
			give_damage_to_body(body)

func give_damage_to_body(_body: PhysicsBody2D) -> void:
	if linear_velocity.length() < 0.5:
		return
	REWARD_MANAGER.set_reward(_body, 1)
	_body.health_points.take_damage(damage)
	collision_mask = 4

func flip(_new_degrees: float) -> void:
	if abs(_new_degrees) >= 90:
		$Sprite.flip_v = true
		return
