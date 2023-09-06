extends EnemyState

class_name EnemyIdleState

const ANIMATION: String = "IDLE"

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)
