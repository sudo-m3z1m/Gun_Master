extends Mob_class

@export var bullet_scene: PackedScene
@export var cooldows_time: float
@export var damage: float
@export var poison_damage: float

enum MOB_STATES{IDLE, MOVING, STUN}

func _ready():
	path_timer.timeout.connect(make_path)

func _physics_process(delta):
	move()
	rotate_weapon()

func make_path() -> void:
	var direction: Vector2
	agent.set_target_position(player.global_position)
	direction = global_position.direction_to(agent.get_next_path_position())
	velocity = direction * max_speed
