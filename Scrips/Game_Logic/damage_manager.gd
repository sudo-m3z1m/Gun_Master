extends Node

class_name DAMAGE_MANAGER

static func _give_damage(damage_from, damage_to, recoil_velocity):
	var damage = damage_from.damage
	
	if damage_to.has_method("stun_after_damage_take"):
		damage_to.stun_after_damage_take()
		damage_to.velocity = recoil_velocity * 160
	
	damage_to.check_hp(damage)
	REWARD_MANAGER.set_reward(damage_to, 2)
