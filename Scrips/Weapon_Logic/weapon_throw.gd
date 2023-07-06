@icon("res://Sprites/Weapons/Gun.png")
extends RigidBody2D

class_name WEAPON_THROW

@export var damage: float

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
	DAMAGE_MANAGER._give_damage(self, _body, Vector2.ZERO, 2)
	collision_mask = 4
