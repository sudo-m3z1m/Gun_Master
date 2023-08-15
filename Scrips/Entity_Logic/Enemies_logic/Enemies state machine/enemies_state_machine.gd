extends Node

class_name EnemyStateMachine

var first_state: EnemyState
var real_state: EnemyState = first_state

@onready var self_owner: Mob_class = get_parent()
@onready var variables_dict: Dictionary

func change_state(_state: GDScript):
	real_state.exit_state()
	real_state = _state.new()
	real_state.enter_state()
