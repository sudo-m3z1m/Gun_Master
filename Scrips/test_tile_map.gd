extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#spawn_enemy($EnemySpawnPos.global_position)

func spawn_enemy(spawn_position: Vector2):
	var enemy = preload("res://Prefabs/Entity/Ancient_mob.tscn").instantiate()
	enemy.spawn(spawn_position, self)
	enemy.set_scale(Vector2(0.5, 0.5))
