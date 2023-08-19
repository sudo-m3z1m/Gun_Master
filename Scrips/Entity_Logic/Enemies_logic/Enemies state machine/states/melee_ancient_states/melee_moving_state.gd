extends EnemyMovingState

var dash_area: Area2D

func enter_state() -> void:
	super()
	dash_area = enemy.area_for_dashes
	dash_area.body_entered.connect(check_player)

func update(delta) -> void:
	turn_to_direction()
	enemy.move()

func exit_state() -> void:
	super()
	dash_area.body_entered.disconnect(check_player)

func update_target_position() -> void:
	var player_pos: Vector2 = enemy.player.global_position
	agent.set_target_position(player_pos)
#	raycast
	
	var direction: Vector2
	var next_path_pos: Vector2 = agent.get_next_path_position()
	direction = enemy.global_position.direction_to(next_path_pos)
	
	enemy.velocity = direction * max_speed

func check_player(_player) -> void:
	if !(_player is character) or raycast.get_collider() is TileMap:
		return
	change_state_to("Prepare")
