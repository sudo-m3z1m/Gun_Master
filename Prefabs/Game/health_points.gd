extends Node

var health_points: int
var self_owner

func _init(_owner, _hp: int = 100) -> void:
	self_owner = _owner
	health_points = _hp

func take_damage(damage: int) -> void:
	self_owner.after_damage_effect_activate()
	health_points -= damage

func heal(healt_points: int) -> void:
#	self_owner.heal_effect()
	healt_points += healt_points
