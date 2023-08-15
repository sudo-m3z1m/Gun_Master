extends Node

class_name EFFECT

var particle_path: String
var damage: float = 40.0 #damage/period
#var shader_effect: StringName
var effect_color: Color
var duration: float = 3.0
var period: float = 1.0
var target: PhysicsBody2D
var period_timer: Timer

func _init(_target: PhysicsBody2D, _damage: float, _dur: float, T: float) -> void:
	target = _target
	damage = _damage
	duration = _dur
	period = T
#	shader_effect
	period_timer = Timer.new()
	target.add_child(period_timer)
	period_timer.timeout.connect(_use_effect)
	period_timer.start(period)					#IDLT

func _use_effect() -> void:
	duration -= period
	if duration <= 0:
		period_timer.timeout.disconnect(_use_effect)
		period_timer.queue_free()
		EffectsManager._deactivate_effect(self)
	DAMAGE_MANAGER._give_damage(self, target)

func _give_some_effects() -> void:
	pass

func _deactivate_some_effects() -> void:
	pass
