extends EFFECT

class_name POISON

var speed_down: float = 2

func _init(_target: PhysicsBody2D, _damage: float = 1.0, _dur: float = 1.0, T: float = 0.1):
	super(_target, _damage, _dur, T)
	_give_some_effects()

func _give_some_effects() -> void:
	target.max_speed /= speed_down

func _deactivate_some_effects() -> void:
	target.max_speed *= speed_down
