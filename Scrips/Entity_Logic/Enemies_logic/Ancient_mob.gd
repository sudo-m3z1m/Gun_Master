extends Mob_class

enum STATES{IDLE, MOVING, PREPARE, ATTACK, STUN}

@export var cooldown_time: float
@export var idle_time: float
@export var prepare_time: float
@export var stunning_time: float

var dash_strength: float = 1000
var _can_attack: bool = true
var real_state: int = STATES.MOVING

func _ready():
	$PathUpdateTimer.timeout.connect(make_path)
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
			velocity = Vector2()
			$IdleAndPrepareTimer.start(stunning_time)

func make_path() -> void:
	var direction_to_target: Vector2
	var next_navigate_point: Vector2
	
	$Agent.set_target_position(player.global_position)
	$RayCast2D.target_position = to_local(player.position)
	
	if $Agent.is_target_reachable() and real_state == STATES.MOVING:
		next_navigate_point = $Agent.get_next_path_position()
		direction_to_target = position.direction_to(next_navigate_point)
		velocity = direction_to_target * speed

func prepare_to_attack() -> void:
	$Agent.set_target_position(player.global_position)
	$PathUpdateTimer.stop()
	$IdleAndPrepareTimer.start(prepare_time)
	velocity = Vector2()

func to_idle():
	$IdleAndPrepareTimer.start(idle_time)
	velocity = Vector2()

func attack(target_position: Vector2) -> void:
	var dash_direction: Vector2
	dash_direction = (global_position.direction_to(target_position) * 10000).\
	limit_length(dash_strength)
	
	_can_attack = false
	velocity = dash_direction

func attack_target_reached() -> void:
	change_state(STATES.IDLE)

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

func stun_after_damage_take() -> void:
	change_state(STATES.STUN)
