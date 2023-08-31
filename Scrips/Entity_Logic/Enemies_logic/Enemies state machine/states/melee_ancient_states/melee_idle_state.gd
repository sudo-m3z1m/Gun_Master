extends EnemyIdleState

var idle_timer: Timer

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)

func enter_state() -> void:
	sprite = enemy.sprite
	idle_timer = enemy.general_timer
	
	sprite.set_animation(ANIMATION)
	idle_timer.timeout.connect(end_idle)
	idle_timer.start()
	enemy.velocity = Vector2.ZERO

func exit_state() -> void:
	idle_timer.timeout.disconnect(end_idle)

func end_idle() -> void:
	change_state_to("Moving")
