extends Node

class_name EFFECT

var damage: float = 25.0 #damage/period
#var shader_effect: StringName
var duration: float = 3.0
var period: float = 1.0
var target: PhysicsBody2D

func _init(_target: PhysicsBody2D, _damage: float = 1.0, _dur: float = 1.0, T: float = 0.1) -> void:
	target = _target
#	damage = _damage
#	duration = _dur
#	period = T
	#shader_effect
	var period_timer: Timer = Timer.new()
	_target.add_child(period_timer)
	period_timer.timeout.connect(_use_effect)
	period_timer.start(period)

func _use_effect() -> void:
	duration -= period
	if duration <= 0:
		queue_free()
	DAMAGE_MANAGER._give_damage(self, target)
