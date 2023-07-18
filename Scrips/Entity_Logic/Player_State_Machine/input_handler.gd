extends Node2D

class_name inputHandler

var moving_inputs:Array = ["Up", "Down", "Left", "Right"]
var actions_inputs: Array = ["Attack", "Throw", "Escape"]
var mouse_circ_actions: Array = ["ScrollUp", "ScrollDown"]
@onready var player = get_parent()
@onready var state_machine = player.get_node("StateMachine")

func _physics_process(delta):
	input_reciever()

func _unhandled_input(event):
	if event is InputEventMouseButton or InputEventKey:
		for act_inp in actions_inputs:
			if Input.is_action_pressed(act_inp):
				actions_input_handler(act_inp)
	
	if event is InputEventMouseButton:
		for mouse_inp in mouse_circ_actions:
			if Input.is_action_just_released(mouse_inp):
				actions_input_handler(mouse_inp)

func input_reciever() -> void:
	var _dir := moving_input_handler()
	
	state_machine.define_state(_dir)
	player.set_direction(_dir)

func moving_input_handler() -> Vector2:
	var _direction = Input.get_vector("Left", "Right", "Up", "Down")
	return _direction

func actions_input_handler(_act_inp):
	match _act_inp:
		"Attack":
			player.get_node("WeaponHandler").attack()
		"Throw":
			player.get_node("WeaponHandler").throw()
		"Escape":
			HUD.set_enable_hud(GlobalScope.GLOBAL_HUDS.PAUSE, true)
		"ScrollUp":
			player.get_node("WeaponHandler").scroll_weapon(1)
		"ScrollDown":
			player.get_node("WeaponHandler").scroll_weapon(-1)
