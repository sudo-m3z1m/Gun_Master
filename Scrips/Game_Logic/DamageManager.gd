extends Node

class_name Damage_MANAGE

static func _give_damage(damage_from, damage_to, recoil_velocity):
	var damage = damage_from.damage
	var hp = damage_to.health_points
	
	damage_to.move_and_collide(recoil_velocity * 40)
	
	if hp - damage != 0:
		damage_to.health_points = hp - damage
		
	else:
		damage_to.health_points = hp - damage
		damage_to.kill()
