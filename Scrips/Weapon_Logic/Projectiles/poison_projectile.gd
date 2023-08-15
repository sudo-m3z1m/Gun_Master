extends PROJECTILE

@export var _poison_damage: float

func _give_damage(_body) -> void:
	super(_body)
	EffectsManager.give_effect(GlobalScope.EFFECTS.POISON, _body, _poison_damage, effect_duration, T)
