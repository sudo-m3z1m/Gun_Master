extends Node2D

var idle_state = IDLE_STATE
var move_state = MOVE_STATE
var main_state = idle_state

@onready var player = get_parent()

func _ready():
	main_state = main_state.new(player)

func define_state(velocity):
	var _next_state
	match velocity:
		Vector2(0, 0):
			_next_state = idle_state
			change_state(_next_state)
		_:
			_next_state = move_state
			change_state(_next_state)

func change_state(next_state):
	if main_state == next_state:
		return
	if main_state != next_state:
		main_state.free()
		main_state = next_state
		main_state = main_state.new(player)
