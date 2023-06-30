extends Node2D

class_name inputHandler

var moving_inputs:Array = ["Up", "Down", "Left", "Right"]
var actions_inputs: Array = ["Attack", "Throw", "Escape"]
var mouse_actions: Array = ["ScrollUp", "ScrollDown"]
var _velocity: Vector2
@onready var player = get_parent()
@onready var state_machine = player.get_node("StateMachine")

func _physics_process(delta):
	_velocity = Vector2.ZERO
	input_reciever()

func input_reciever() -> void:
	for mov_inp in moving_inputs:
		if Input.is_action_pressed(mov_inp):
			moving_input_handler(mov_inp)
		if Input.is_action_just_released(mov_inp):
			moving_input_handler(null)
	for act_inp in actions_inputs:
		if Input.is_action_pressed(act_inp):
			actions_input_handler(act_inp)
	for mouse_inp in mouse_actions:
		if Input.is_action_just_released(mouse_inp):
			actions_input_handler(mouse_inp)

func moving_input_handler(_mov_inp) -> void:
	var _is_flipped: bool = false
	match _mov_inp:
		"Up":
			_velocity.y -= 1
		"Down":
			_velocity.y += 1
		"Left":
			_velocity.x -= 1
			_is_flipped = true #because this is one state which need to flip sprite
		"Right":
			_velocity.x += 1
	player.choose_velocity(_velocity, _is_flipped)
	state_machine.define_state(_velocity)

func actions_input_handler(_act_inp):
	match _act_inp:
		"Attack":
			player.actions_handler("Attack")
		"Throw":
			player.actions_handler("Throw")
		"Escape":
			player.actions_handler("Escape")
		"ScrollUp":
			player.actions_handler("ScrollUp")
		"ScrollDown":
			player.actions_handler("ScrollDown")
