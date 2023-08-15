extends RefCounted

class_name EnemyState

var variables: Dictionary
var enemy: Mob_class
var state_machine: EnemyStateMachine

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine, _variables: Dictionary):
	enemy = _enemy
	state_machine = _state_machine
	variables = _variables

func enter_state() -> void:
	pass

func update() -> void:
	pass

func exit_state() -> void:
	pass
