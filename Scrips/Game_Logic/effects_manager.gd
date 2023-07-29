extends Node

class_name EFFECTS_MANAGER

var EFFECTS = GlobalScope.EFFECTS

func give_effect(_effect: int, apply_to: PhysicsBody2D, _damage: float, _dur: float, t: float) -> void:
	match _effect:
		EFFECTS.POISON:
			POISON.new(apply_to, _damage, _dur, t)

func _deactivate_effect(_effect: Node) -> void:
	_effect._deactivate_some_effects()
	_effect.queue_free()
