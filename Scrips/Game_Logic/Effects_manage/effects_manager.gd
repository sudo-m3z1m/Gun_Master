extends Node

class_name EFFECTS_MANAGER

var active_effects: Dictionary
var EFFECTS_ENUM = GlobalScope.EFFECTS

var effects: Dictionary = {
	EFFECTS_ENUM.POISON: POISON
}

func try_apply_effect(_effect: GlobalScope.EFFECTS, apply_to: PhysicsBody2D, _damage: float = 1, _dur: float = 1, t: float = 1) -> void:
	if active_effects.get(apply_to) == null:
		active_effects[apply_to] = []

	if active_effects[apply_to].has(_effect):
		return

	active_effects[apply_to].append(_effect)
	effects[_effect].new(apply_to, _damage, _dur, t)

func _deactivate_effect(apply_to: PhysicsBody2D, _effect: EFFECT, effect_enum: GlobalScope.EFFECTS) -> void:
	_effect._deactivate_some_effects()
	active_effects[apply_to].erase(effect_enum)
	_effect.queue_free()
