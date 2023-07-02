extends Node2D

func _ready():
	#spawn_enemy($EnemySpawnPos.global_position)
#	get_node("/root/GameManager").start_wave()
	GameManager.start_game()
	

func spawn_enemy(spawn_global_position: Vector2):
	var enemy = preload("res://Prefabs/Entity/Ancient_mob.tscn").instantiate()
	enemy.spawn(spawn_global_position, self)
	enemy.set_scale(Vector2(0.5, 0.5))
	enemy.player = get_node("Jacket_Man")
