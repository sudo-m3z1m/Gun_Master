extends Node2D

var idle_state = load("res://Scrips/Entity_Logic/Player_State_Machine/idle_state.gd")
var move_state = load("res://Scrips/Entity_Logic/Player_State_Machine/move_state.gd")
var main_state = idle_state

@onready var player = get_parent()

func _ready():
	main_state.start(player)

func define_state(have_input):
	var _next_state
	match have_input:
		true:
			_next_state = move_state
			change_state(_next_state)
		false:
			_next_state = idle_state
			change_state(_next_state)

func change_state(next_state):
	if main_state == next_state:
		return
	if main_state != next_state:
		main_state = next_state
		main_state.start(player)
