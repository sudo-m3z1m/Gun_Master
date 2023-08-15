extends RefCounted

class_name EnemyState

var enemy: Mob_class
var state_machine: EnemyStateMachine

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	enemy = _enemy
	state_machine = _state_machine

func enter_state() -> void:
	pass

func update() -> void:
	pass

func exit_state() -> void:
	pass
