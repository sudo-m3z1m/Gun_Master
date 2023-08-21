extends EnemyState

var prepare_timer: Timer
var min_prepare_time: float = 0.1
var max_prepare_time: float = 1
var prepare_time: float
const ANIMATION: String = "IDLE"

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)

func enter_state() -> void:
	prepare_timer = enemy.general_timer
	prepare_timer.timeout.connect(end_prepare)
	prepare_time = pick_random_prepare_time()
	prepare_timer.start(prepare_time)
	sprite = enemy.sprite
	
	enemy.velocity = Vector2.ZERO
	sprite.set_animation(ANIMATION)

func update(delta) -> void:
	pass

func exit_state() -> void:
	prepare_timer.stop()
	prepare_timer.timeout.disconnect(end_prepare)

func end_prepare() -> void:
	change_state_to("Attack")

func pick_random_prepare_time() -> float:
	return randf_range(min_prepare_time, max_prepare_time)
