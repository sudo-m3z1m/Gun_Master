extends Mob_class

var dash_strength: float = 1000
var _attack: bool = false

func _ready():
	$PathUpdateTimer.timeout.connect(make_path)

func _physics_process(delta):
	move()

func _on_dash_range_timeout():
	velocity = Vector2()
	
	#Cooldown
	#Animatons
	
	$PathUpdateTimer.start()

func make_path():
	var path
	$Agent.set_target_position(player.global_position)
	path = $Agent.get_next_path_position()
	var _velocity = global_position.direction_to(path).normalized() * speed
	if $Agent.is_target_reachable():
		velocity = _velocity

func _on_area_for_dashes_body_entered(body):
	if body.is_in_group("Player"): #and love == false#
		attack(player.global_position)

func attack(target_position:Vector2):
	$PathUpdateTimer.stop()
	$DashRange.start()
	
	var attack_velocity = global_position.direction_to(target_position)\
	.normalized() * dash_strength
	
	attack_velocity = attack_velocity.limit_length(dash_strength)
	
	#Cooldown
	#Animations
	
	velocity = attack_velocity
