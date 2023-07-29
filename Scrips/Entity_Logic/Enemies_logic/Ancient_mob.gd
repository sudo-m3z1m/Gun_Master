extends Mob_class

enum STATES{IDLE, MOVING, PREPARE, ATTACK, STUN}

@export var cooldown_time: float
@export var idle_time: float
@export var max_prepare_time: float
@export var damage: float

var stunning_time: float
var dash_strength: float = 1000
var _can_attack: bool = true
var real_state: int = STATES.MOVING

func _ready():
	$PathUpdateTimer.timeout.connect(make_path)
	$AttackArea.body_entered.connect(on_attack_body_entered)
	$RayCast2D.add_exception(get_tree().get_first_node_in_group("Player"))

func _physics_process(delta):
	move()

func change_state(next_state: int) -> void:
	if real_state == next_state:
		return

	real_state = next_state
	match next_state:
		STATES.IDLE:
			to_idle()
		STATES.MOVING:
			$PathUpdateTimer.start()
			$CooldownTimer.start(cooldown_time)
		STATES.PREPARE:
			prepare_to_attack()
		STATES.ATTACK:
			attack($Agent.get_target_position())
		STATES.STUN:
			$Agent.set_velocity(Vector2.ZERO)
			$IdleAndPrepareTimer.start(stunning_time)

func make_path() -> void:
	var direction_to_target: Vector2
	var next_navigate_point: Vector2
	
	$Agent.set_target_position(player.global_position)
	$RayCast2D.target_position = to_local(player.position)
	
	if $Agent.is_target_reachable() and real_state == STATES.MOVING:
		next_navigate_point = $Agent.get_next_path_position()
		direction_to_target = position.direction_to(next_navigate_point)
		$Agent.set_velocity(direction_to_target * max_speed)

func prepare_to_attack() -> void:
	var prepare_time: float = randomize_prepare_time()
	$PathUpdateTimer.stop()
	$IdleAndPrepareTimer.start(prepare_time)
	$Agent.set_target_position(player.global_position)
	velocity = Vector2.ZERO

func to_idle():
	$IdleAndPrepareTimer.start(idle_time)
	$AttackArea/AttackShape.disabled = true
	$Agent.target_reached.disconnect(attack_target_reached)
	velocity = Vector2.ZERO

func attack(target_position: Vector2) -> void:
	var dash_direction: Vector2
	$AttackArea/AttackShape.disabled = false
	$Agent.target_reached.connect(attack_target_reached)
	
	dash_direction = (global_position.direction_to(target_position) * 10000).\
	limit_length(dash_strength)
	
	_can_attack = false
	velocity = dash_direction

func attack_target_reached() -> void:
	change_state(STATES.IDLE)

func on_attack_body_entered(_body) -> void:
	if real_state == STATES.ATTACK and _body.is_in_group("Player"):
		DAMAGE_MANAGER._give_damage(self, _body, Vector2.ZERO)

func idle_prepare_timer_out() -> void:
	match real_state:
		STATES.PREPARE:
			change_state(STATES.ATTACK)
		STATES.IDLE:
			change_state(STATES.MOVING)
		STATES.STUN:
			change_state(STATES.MOVING)

func _on_area_for_dashes_body_entered(body) -> void:
	for group in attacked_groups:
		if body.is_in_group(group) and _can_attack\
		and $RayCast2D.is_colliding() == false:
			change_state(STATES.PREPARE)

func cooldown_out() -> void:
	_can_attack = true

func stun_after_damage_take(_stun_time) -> void:
	stunning_time = _stun_time
	change_state(STATES.STUN)

func _on_agent_velocity_computed(safe_velocity):
	match real_state:
		STATES.PREPARE:
			velocity = Vector2.ZERO
		STATES.IDLE:
			velocity = Vector2.ZERO
		STATES.MOVING:
			velocity = safe_velocity

func randomize_prepare_time() -> float:
	var random_time: float = randf_range(0.1, max_prepare_time)
	return random_time
