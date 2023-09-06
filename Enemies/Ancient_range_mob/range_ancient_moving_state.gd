extends EnemyMovingState

var player_range_radius: float

func enter_state() -> void:
	super()
	cooldown_timer.timeout.connect(shot)
	player_range_radius = enemy.player_radius

func update(delta) -> void:
	enemy.move()
	turn_to_direction()
	enemy.rotate_weapon()

func exit_state() -> void:
	super()

func update_target_position() -> void:
	check_length_between_target(agent.get_target_position())
	var player_pos: Vector2 = enemy.player.global_position
	agent.set_target_position(player_pos)
	
	var direction: Vector2
	var next_path_pos: Vector2 = agent.get_next_path_position()
	direction = enemy.global_position.direction_to(next_path_pos)
	
	enemy.velocity = direction * max_speed

func check_length_between_target(target_pos: Vector2) -> void:
	var length_between_target: float
	length_between_target = (target_pos - enemy.global_position).length() - player_range_radius
	
	if length_between_target > 0:
		return
	
	change_state_to("Idle")

func shot():
	change_state_to("Attack")
