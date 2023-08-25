extends Projectile

class_name EffectProjectile

@export var effect: GlobalScope.EFFECTS

var effect_damage: float
var effect_duration: float
var T: float

func shot(_damage: float, _target_pos: Vector2, speed: float = 500.0, effect_dur: float = 0.0, t: float = 0.0):
	super(_damage, _target_pos, speed)
	effect_duration = effect_dur
	T = t

func _give_damage(_body) -> void:
	super(_body)
	EffectsManager.try_apply_effect(effect, _body, effect_damage, effect_duration, T)
