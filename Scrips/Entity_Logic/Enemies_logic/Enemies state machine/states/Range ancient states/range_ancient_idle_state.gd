extends EnemyIdleState

var cooldown_timer: Timer
var raycast: RayCast2D
var player_length: float

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)

func enter_state() -> void:
	enemy.velocity = Vector2.ZERO
	player_length = enemy.player_radius
	cooldown_timer = enemy.cooldown_timer
	raycast = enemy.raycast
	
	cooldown_timer.timeout.connect(shot)
	enemy.sprite.set_animation(ANIMATION)
	
func update(delta) -> void:
	enemy.rotate_weapon()
	check_length_between_player()

func exit_state() -> void:
	cooldown_timer.timeout.disconnect(shot)

func shot() -> void:
	change_state_to("Attack")

func check_length_between_player() -> void:
	var target_pos: Vector2
	target_pos = enemy.player.global_position
	
	var length_to_target: float = (target_pos - enemy.global_position).length()
	if length_to_target < player_length:
		return
	change_state_to("Moving")
