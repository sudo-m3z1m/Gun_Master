extends EnemyState

class_name EnemyAttackState

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)

func enter_state() -> void:
	pass

func update(delta) -> void:
	pass

func exit_state() -> void:
	pass

func randomise_property(prop_from: float, prop_to: float) -> float:
	var random_property: float
	random_property = randf_range(prop_from, prop_to)

	return random_property
