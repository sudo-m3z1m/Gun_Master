extends Node2D

class_name inputHandler

var moving_inputs:Array = ["Up", "Down", "Left", "Right"]
var actions_inputs: Array = ["Attack", "Throw", "Escape"]
var mouse_actions: Array = ["ScrollUp", "ScrollDown"]
@onready var player = get_parent()
@onready var state_machine = player.get_node("StateMachine")

func _physics_process(delta):
	input_reciever()

func input_reciever() -> void:
	var _dir: Vector2 = Vector2.ZERO
	var _need_flip: bool = false
	for mov_inp in moving_inputs:
		if Input.is_action_pressed(mov_inp):
			_dir += moving_input_handler(mov_inp)
			_need_flip = flip_handler(mov_inp)
	_dir = _dir.normalized()
	state_machine.define_state(_dir)
	player.choose_velocity(_dir, _need_flip)

	for act_inp in actions_inputs:
		if Input.is_action_pressed(act_inp):
			actions_input_handler(act_inp)

	for mouse_inp in mouse_actions:
		if Input.is_action_just_released(mouse_inp):
			actions_input_handler(mouse_inp)

func moving_input_handler(_mov_inp) -> Vector2:
	var _is_flipped: bool = false
	var _direction: Vector2
	match _mov_inp:
		"Up":
			_direction.y -= 1
		"Down":
			_direction.y += 1
		"Left":
			_direction.x -= 1
		"Right":
			_direction.x += 1
	_direction = _direction.normalized()
	return _direction

func flip_handler(_mov_input: String) -> bool:
	if _mov_input == "Left":
		return true
	else:
		return false

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
