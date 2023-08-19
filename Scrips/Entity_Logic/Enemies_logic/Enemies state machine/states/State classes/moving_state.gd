extends EnemyState

class_name EnemyMovingState

var max_speed: float
var agent: NavigationAgent2D
var path_timer: Timer
#var cooldown_timer: Timer
var raycast: RayCast2D
var sprite: AnimatedSprite2D

const ANIMATION: String = "MOVING"

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)

func turn_to_direction() -> void:
	if enemy.velocity.x >= 0:
		sprite.flip_h = false
	if enemy.velocity.x < 0:
		sprite.flip_h = true

func enter_state() -> void:
	max_speed = enemy.max_speed
	agent = enemy.agent
	path_timer = enemy.path_timer
	raycast = enemy.raycast
	sprite = enemy.sprite
#	cooldown_timer = enemy.cooldown_timer

	path_timer.timeout.connect(update_target_position)
	path_timer.start()
	sprite.set_animation(ANIMATION)

func update_target_position() -> void:
	pass

func exit_state() -> void:
	path_timer.stop()
	path_timer.timeout.disconnect(update_target_position)
