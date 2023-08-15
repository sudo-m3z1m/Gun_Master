extends EnemyState

var player: character
var dash_timer: Timer
var dash_speed: float #need be here
var dash_time: float

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)

func enter_state() -> void:
	player = enemy.player
	dash_timer = enemy.general_timer
	dash_speed = enemy.dash_strength #it's need be in this script
	dash_time = enemy.dash_time #That's too
	
	dash_timer.timeout.connect(_end_dash)
	dash_timer.start(dash_time)
	
	make_dash_dir()

func update(delta) -> void:
	enemy.move()

func exit_state() -> void:
	enemy.velocity = Vector2.ZERO
	dash_timer.stop() #Isn't Nesseserily
	dash_timer.timeout.disconnect(_end_dash)

func _end_dash() -> void:
	change_state_to("Idle")

func make_dash_dir() -> void:
	var dir: Vector2
	var target_pos: Vector2
	target_pos = choose_dash_dir()
	dir = enemy.global_position.direction_to(target_pos)
	enemy.velocity = dir * dash_speed
	
func choose_dash_dir() -> Vector2:
	var target_bias: Vector2
	target_bias.x = randi_range(-5, 5)
	target_bias.y = randi_range(-5, 5)
	
	return player.global_position + target_bias
