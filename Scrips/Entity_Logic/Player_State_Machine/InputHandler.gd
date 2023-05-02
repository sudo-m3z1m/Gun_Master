extends Node2D

class_name inputHandler

var inputs:Array = ["Up", "Down", "Left", "Right", "Attack", "Throw", "Escape"]

@onready var player = get_parent()
@onready var state_machine = player.get_node("StateMachine")

func _physics_process(delta):
	input_reciever()

func input_reciever():
	for i in inputs:
		if Input.is_action_pressed(i):
			input_handler(i)
		if Input.is_action_just_released(i):
			state_machine.define_state(false)
	
func input_handler(input):
	var velocity = Vector2.ZERO
	
	match input:
		"Up":
			velocity.y -= 1
			player.choose_velocity(velocity, false)
			state_machine.define_state(true)
		"Down":
			velocity.y += 1
			player.choose_velocity(velocity, false)
			state_machine.define_state(true)
		"Left":
			velocity.x -= 1
			player.choose_velocity(velocity, true)
			state_machine.define_state(true)
		"Right":
			velocity.x += 1
			player.choose_velocity(velocity, false)
			state_machine.define_state(true)
		
		"Attack":
			player.actions_handler("Attack")
		"Throw":
			player.actions_handler("Throw")
		"Escape":
			player.actions_handler("Escape")
