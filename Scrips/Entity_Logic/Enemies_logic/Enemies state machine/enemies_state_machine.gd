extends Node

class_name EnemyStateMachine

var first_state: EnemyState
var current_state: EnemyState = first_state

@onready var self_owner: Mob_class = get_parent()
@onready var variables_dict: Dictionary

func _physics_process(delta):
	current_state.update(delta)

func change_state(_next_state: String):
	var state_path = self_owner.states[_next_state]
	current_state = load(state_path).new()
	current_state.enter_state()

func interrupt_state(_next_state: String):
	current_state.exit_state()
	change_state(_next_state)
#	var previous_state: EnemyState = current_state
