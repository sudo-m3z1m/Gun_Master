extends EnemyAttackState

var player: character
var cooldown_timer: Timer
var raycast: RayCast2D
var cooldown_time: float

func enter_state() -> void:
	player = enemy.player
	cooldown_timer = enemy.cooldown_timer
	raycast = enemy.raycast
	cooldown_time = enemy.cooldown_time
	
	shot()

func update(delta) -> void:
	pass

func exit_state() -> void:
	pass

func shot() -> void:
	cooldown_timer.start(cooldown_time)
	if raycast.get_collider() is TileMap:
		change_state_to("Moving")
		return
	change_state_to("Moving")
	enemy.attack(player)
