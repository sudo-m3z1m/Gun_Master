extends Node

class_name EFFECTS_MANAGER

var EFFECTS = GlobalScope.EFFECTS

func give_effect(effect: int, apply_to: PhysicsBody2D, _damage: float, _dur: float, t: float) -> void:
	match effect:
		EFFECTS.POISON:
			POISON.new(apply_to, _damage, _dur, t)
