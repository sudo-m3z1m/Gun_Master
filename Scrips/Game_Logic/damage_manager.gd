extends Node

class_name DAMAGE_MANAGER

static func _give_damage(damage_from, damage_to, recoil_velocity):
	var damage = damage_from.damage
	var hp = damage_to.health_points
	
	if damage_to.has_method("stun_after_damage_take"):
		damage_to.stun_after_damage_take()
		damage_to.velocity = recoil_velocity * 160
	
	if hp - damage != 0:
		damage_to.health_points = hp - damage
		
	else:
		damage_to.health_points = hp - damage
		damage_to.kill()
