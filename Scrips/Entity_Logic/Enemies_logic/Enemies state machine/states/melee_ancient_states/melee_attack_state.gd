extends EnemyAttackState

var dash_timer: Timer
var cooldown_timer: Timer
var area_for_attack: Area2D
var damage: float
var dash_speed: float #need be here
var dash_time: float = 0.2
var agent: NavigationAgent2D

func _init(_enemy: Mob_class, _state_machine: EnemyStateMachine):
	super(_enemy, _state_machine)

func enter_state() -> void:
	area_for_attack = enemy.area_for_attack
	agent = enemy.agent
	dash_timer = enemy.general_timer
	dash_speed = enemy.dash_strength #it's need be in this script
	
	area_for_attack.body_entered.connect(_give_damage)
	dash_timer.timeout.connect(_end_dash)
	dash_timer.start(dash_time)
	
	make_dash_dir()

func update(delta) -> void:
	enemy.move()

func exit_state() -> void:
	enemy.velocity = Vector2.ZERO
	dash_timer.timeout.disconnect(_end_dash)
	area_for_attack.body_entered.disconnect(_give_damage)

func _end_dash() -> void:
	change_state_to("Idle")

func make_dash_dir() -> void:
	var dir: Vector2
	var target_pos: Vector2
	target_pos = choose_dash_dir()
	dir = enemy.global_position.direction_to(target_pos)
	enemy.velocity = dir * dash_speed
	
func choose_dash_dir() -> Vector2:
	var target_bias: Vector2
	target_bias.x = randf_range(-50, 50)
	target_bias.y = randf_range(-50, 50)
	
	var target_position: Vector2
	target_position = agent.get_target_position()
	
	return target_position + target_bias

func _give_damage(_body) -> void:
	if !(_body is character):
		return
	DAMAGE_MANAGER._give_damage(enemy, _body)
