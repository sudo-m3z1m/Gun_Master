@icon("res://Sprites/Weapons/Gun.png")
extends RigidBody2D

class_name WEAPON_THROW

const ENEMY_GROUP = ["Mob", "Projectile"]

func _throwing_collision_checker(body):
	for i in ENEMY_GROUP:
		if body.is_in_group(i):
			body.queue_free()
