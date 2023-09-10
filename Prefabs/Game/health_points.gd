extends RefCounted

class_name HealthPoints

var health_points: int
var self_owner

func _init(_owner, _hp: int = 100) -> void:
	self_owner = _owner
	health_points = _hp

func take_damage(damage: int) -> void:
	self_owner.set_damage_effect()
	health_points -= damage
	if health_points <= 0:
		self_owner.kill()

func heal(healt_points: int) -> void:
#	self_owner.set_heal_effect()
	healt_points += healt_points
