extends Timer

@export_category("Time")
@export var wave_time: float
@export var mob_time: float
@export_dir var enemy_path
@export_dir var player_path

var wave_count: int = 0

const SHOP_PATH: String = "res://Prefabs/Buildings/shop.tscn"
const SHOP_TIME: float = 15
const PLAYER_SCALE: Vector2 = Vector2(0.6, 0.6)
const MAX_MOB_COUNT: int = 15

func _ready():
	self.timeout.connect(timer_timeout)
	$MobSpawnTimer.timeout.connect(spawn_enemy)

func _process(delta):
	update_timer_hud()

func start_game() -> void:
	reset_game()
	var _player = instantiate_player()
	spawn_player(_player)
	start_wave()

func stop_game() -> void:
	#HUD
	reset_game()

func reset_game():
	$MobSpawnTimer.stop()
	stop()
	wave_count = 0
	wave_time = 6
	rm_mobs()

func start_wave() -> void:
	update_wave_count()
	self.start(wave_time)
	$MobSpawnTimer.start(mob_time)

func finish_wave() -> void:
	$MobSpawnTimer.stop()
	rm_mobs()
	show_shop()
	call_deferred("set_coin_mag_targ")

func instantiate_player() -> PhysicsBody2D:
	return load(player_path).instantiate()

func spawn_player(_player: PhysicsBody2D) -> void:
	_player.set_scale(PLAYER_SCALE)
	_player.global_position = get_node("/root/TestRoom/PlayerSpawnPos")\
	.global_position
	get_node("/root/TestRoom").add_child(_player)

func spawn_enemy() -> void:
	var enemy: CharacterBody2D = load(enemy_path).instantiate()
	var mob_spawn_location: PathFollow2D = get_node("/root/TestRoom/MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	enemy.spawn(mob_spawn_location.position, get_node("/root/TestRoom"))
	enemy.set_scale(Vector2(0.5, 0.5))
	
func rm_mobs() -> void:
	for mob in get_tree().get_nodes_in_group("Mob"):
		REWARD_MANAGER.set_reward(mob, 1)
	get_tree().call_group("Mob", "kill")

func set_coin_mag_targ() -> void:
	get_tree().call_group("Coin", "set_player", get_tree().get_first_node_in_group("Player"))

func show_shop() -> void:
	var shop: Node2D = load(SHOP_PATH).instantiate()
	get_node("/root/TestRoom").add_child(shop)
	start(SHOP_TIME)
	restock(shop)

func hide_shop() -> void:
	get_node("/root/TestRoom/Shop").queue_free()
	start_wave()

func restock(_shop) -> void:
	_shop.restock()

func update_timer_hud() -> void:
	if is_stopped():
		return get_node("/root/MainInterface").update_main_score(0, wave_count)
	var _time: int = time_left / 1
	get_node("/root/MainInterface").update_main_score(_time, wave_count)

func timer_timeout() -> void:
	if wait_time == wave_time:
		finish_wave()
	elif wait_time == SHOP_TIME:
		hide_shop()

func update_wave_count():
	wave_count += 1
	if wave_time >= 30:
		return
	wave_time += 6
