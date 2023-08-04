extends Node

class_name DAMAGE_MANAGER

static func _give_damage(damage_from, damage_to, recoil_velocity = Vector2.ZERO, _time = 1.0):
	var damage = damage_from.damage
	
	if damage_to.has_method("stun_after_damage_take"):
		damage_to.stun_after_damage_take(_time)
		damage_to.velocity = recoil_velocity * 40
	
	REWARD_MANAGER.set_reward(damage_to, 2)
	_check_hp(damage_to, damage)

static func _check_hp(_damage_to: PhysicsBody2D, _damage: int) -> bool:
	_damage_to.health_points -= _damage
	if _damage_to.health_points <= 0:
		_damage_to.call_deferred("kill")
		return true
	
	return false
