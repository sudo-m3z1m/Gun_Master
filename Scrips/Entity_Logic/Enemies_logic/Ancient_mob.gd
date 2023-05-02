extends Mob_class

var dash_strength: float = 600
var _attack: bool = false

func _ready():
	$PathUpdateTimer.timeout.connect(make_path)

func _physics_process(delta):
	pass
	#make_path()

func _on_area_for_dashes_body_exited(body):
	if body.is_in_group("Player"): #and love == false#
		attack(player.global_position)

func attack(target_position:Vector2):
	$PathUpdateTimer.stop()
	$DashRange.start()
	
	var attack_velocity = global_position.direction_to(target_position)\
	.normalized() * dash_strength
	
	attack_velocity = attack_velocity.limit_length(dash_strength)
	print(attack_velocity.length(), " Attack velocity")
	
	#Cooldown
	#Animations
	
	$Agent.set_velocity(attack_velocity)
	#move_and_collide(attack_velocity)

func _on_dash_range_timeout():
	$Agent.set_velocity(Vector2())
	
	#Cooldown
	#Animatons
	
	$PathUpdateTimer.start()

func make_path():
	var path
	$Agent.set_target_position(player.global_position)
	path = $Agent.get_next_path_position()
	var _velocity = global_position.direction_to(path).normalized() * speed
	if $Agent.is_target_reachable():
		$Agent.set_velocity(_velocity)

func _on_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
