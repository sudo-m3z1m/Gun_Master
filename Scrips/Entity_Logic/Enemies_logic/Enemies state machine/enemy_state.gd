extends RefCounted

class_name EnemyState

var enemy: Mob_class
var state_machine: EnemyStateMachine
var next_state: String

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	enemy = _enemy
	state_machine = _state_machine

func enter_state() -> void:
	pass

func update(delta) -> void:
	pass

func change_state_to(next_state: String) -> void:
#	var self_name = self.get_class()
	exit_state()
	state_machine.change_state(next_state)

func exit_state() -> void:
	pass
