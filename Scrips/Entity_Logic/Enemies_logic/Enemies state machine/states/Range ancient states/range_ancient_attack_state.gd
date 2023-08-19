extends EnemyAttackState

var player: character
#var cooldown_timer: Timer
#var cooldown_time: float

func enter_state() -> void:
	player = enemy.player
#	cooldown_timer = enemy.cooldown_timer
#	cooldown_timer.start(cooldown_time)
	
	shot()

func update(delta) -> void:
	pass

func exit_state() -> void:
	pass

func shot() -> void:
	enemy.attack(player)
	change_state_to("Moving")
