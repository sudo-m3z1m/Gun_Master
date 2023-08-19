extends EnemyState

var prepare_timer: Timer
var prepare_time: float = 1
#const ANIMATION: String

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)

func enter_state() -> void:
	prepare_timer = enemy.general_timer
	prepare_timer.timeout.connect(end_prepare)
	prepare_timer.start(prepare_time)
	
	enemy.velocity = Vector2.ZERO

func update(delta) -> void:
	pass

func exit_state() -> void:
	prepare_timer.stop()
	prepare_timer.timeout.disconnect(end_prepare)

func end_prepare() -> void:
	change_state_to("Attack")
