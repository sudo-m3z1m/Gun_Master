extends Node

class_name EFFECTS_MANAGER

var EFFECTS = GlobalScope.EFFECTS

func give_effect(_effect: int, apply_to: PhysicsBody2D, _damage: float = 1, _dur: float = 1, t: float = 1) -> void:
	match _effect:
		EFFECTS.POISON:
			POISON.new(apply_to, _damage, _dur, t)

func _deactivate_effect(_effect: Node) -> void:
	_effect._deactivate_some_effects()
	_effect.queue_free()
