extends EnemyState

var max_speed: float
var agent: NavigationAgent2D
var path_timer: Timer
#var cooldown_timer: Timer
var raycast: RayCast2D
var dash_area: Area2D
var sprite: AnimatedSprite2D

const ANIMATION: String = "Moving"

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)

func enter_state() -> void:
	max_speed = enemy.max_speed
	agent = enemy.agent
	path_timer = enemy.path_timer
	raycast = enemy.raycast
	sprite = enemy.sprite
	dash_area = enemy.area_for_dashes
	
	dash_area.body_entered.connect(check_player)
	path_timer.timeout.connect(update_target_position)
	path_timer.start()
	sprite.set_animation(ANIMATION)

func update(delta) -> void:
	enemy.move()

func exit_state() -> void:
	path_timer.stop()
	dash_area.body_entered.disconnect(check_player)
	path_timer.timeout.disconnect(update_target_position)

func update_target_position() -> void:
	var player_pos: Vector2 = enemy.player.global_position
	agent.set_target_position(player_pos)
	
	var direction: Vector2
	var next_path_pos: Vector2 = agent.get_next_path_position()
	direction = enemy.global_position.direction_to(next_path_pos)
	
	enemy.velocity = direction * max_speed

func check_player(_player) -> void:
	if !(_player is character) or raycast.get_collider() is TileMap:
		return
	change_state_to("Prepare")
