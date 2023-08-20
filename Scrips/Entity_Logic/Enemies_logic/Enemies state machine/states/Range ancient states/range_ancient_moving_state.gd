extends EnemyMovingState

var shot_timer: Timer
var shot_time: float = 2
var player_range_radius: float = 400

func enter_state() -> void:
	super()
	shot_timer = enemy.shot_timer
	shot_timer.timeout.connect(shot)
	shot_timer.start(shot_time)

func update(delta) -> void:
	enemy.move()
	turn_to_direction()
	enemy.rotate_weapon()

func exit_state() -> void:
	super()

func update_target_position() -> void:
	var player_pos: Vector2 = enemy.player.global_position
	agent.set_target_position(player_pos)
	
	var direction: Vector2
	var next_path_pos: Vector2 = agent.get_next_path_position()
	direction = enemy.global_position.direction_to(next_path_pos)
	
	var k: float = get_length_between_player(player_pos)
	
	enemy.velocity = direction * max_speed * k

func get_length_between_player(player_pos: Vector2) -> float:
	var player_enemy_length: float
	player_enemy_length = (enemy.global_position - player_pos).length() - player_range_radius
	player_enemy_length = clamp(player_enemy_length, 0, 1)

	return player_enemy_length

func shot():
	if raycast.get_collider() is TileMap or !cooldown_timer.is_stopped():
		return
	change_state_to("Attack")
