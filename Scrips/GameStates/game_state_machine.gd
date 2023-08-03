extends Node

class_name GAME_STATE_MACHINE

var start_state := WAVES_STATE.new()
var real_time: float
var real_state: GAME_STATE = GAME_OVER_STATE.new()

func change_state(_next_state: GDScript):
	if real_state.get_script() == _next_state:
		return
	real_state.exit_state()
	real_state = _next_state.new()
	real_state.enter_state()
