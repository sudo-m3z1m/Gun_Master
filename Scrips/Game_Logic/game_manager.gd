extends Timer

@export_category("Time")
@export var wave_time: float
@export var mob_time: float
@export_category("Paths")
@export_dir var enemy_path
@export_dir var player_path

@onready var scene = get_tree().current_scene
@onready var mob_timer: Timer = $MobSpawnTimer
@onready var mob_spawn_location: PathFollow2D = scene\
.get_node("MobPath/MobSpawnLocation")

enum GAME_STATES{WAVE, SHOPPING, OVER}

const SHOP_PATH: String = "res://Prefabs/Buildings/shop.tscn"
const START_WAVE: int = 1
const START_WAVE_TIME: float = 6.0
const REWARD_AFTER_WAVE: int = 1
const DELTA_WAVE_TIME: float = 6.0

var shop: SHOP
var wave_count: int
var items = ITEMS.new()
var HUDS = GlobalScope.GLOBAL_HUDS
var player_huds: Array[int] = [HUDS.AMMO, HUDS.HP, HUDS.COIN, HUDS.MAIN]
var game_state: int:
	set(new_state):
		game_state = change_state(new_state)

func _ready():
	timeout.connect(timer_timeout)
	mob_timer.timeout.connect(spawn_enemy)

func _process(delta):
	update_timer_hud()

func change_music(_music: String, _time: float = 0.0):
	SoundManager.change_main_music(_music, _time)

func change_state(_state: int) -> int:
	match _state:
		GAME_STATES.WAVE:
			start_wave()
		GAME_STATES.SHOPPING:
			finish_wave()
			start_shopping()
		GAME_STATES.OVER:
			stop_game()
	return _state

func start_game() -> void:
	reset_game()
	var _player = instantiate_player()
	spawn_player(_player)
	set_visible_players_hud(true)
	game_state = GAME_STATES.WAVE

func stop_game() -> void:
	HUD.set_enable_hud(HUDS.OVER, true)
	change_music("Game_over")
	mob_timer.stop()
	stop()

func start_shopping() -> void:
	instantiate_and_spawn_shop()
	change_music("Shop", 0.45)
	start(GlobalScope.SHOP_TIME)

func start_wave() -> void:
	change_music("Main", 1.5)
	start(wave_time)
	rm_entities_in_group("Shop")
	mob_timer.start(mob_time)

func reset_game() -> void:
	wave_count = START_WAVE
	wave_time = START_WAVE_TIME

func finish_wave() -> void:
	mob_timer.stop()
	kill_mobs()
	update_wave_count()
	call_deferred("magnetize_coins")


func update_timer_hud() -> void:
	if is_stopped():
		return HUD.main_hud.update_count(0, wave_count)
	var _time: int = time_left / 1
	HUD.main_hud.update_count(_time, wave_count)

func update_wave_count():
	wave_count += 1
	if wave_time >= 30:
		return
	wave_time = wave_count * DELTA_WAVE_TIME


func timer_timeout() -> void:
	match game_state:
		GAME_STATES.SHOPPING:
			game_state = GAME_STATES.WAVE
		GAME_STATES.WAVE:
			game_state = GAME_STATES.SHOPPING

func instantiate_player() -> PhysicsBody2D:
	return load(player_path).instantiate()

func spawn_player(_player: PhysicsBody2D) -> void:
	_player.global_position = get_node("/root/TestRoom/PlayerSpawnPos")\
	.global_position
	scene.add_child(_player)
	
func spawn_enemy() -> void:
	if get_tree().get_nodes_in_group("Mob").size() >= GlobalScope.MAX_ENEMYS_NUMBER:
		return
	var enemy: CharacterBody2D = load(enemy_path).instantiate()
	mob_spawn_location.progress_ratio = randf()

	enemy.spawn(mob_spawn_location.position, scene)

func instantiate_and_spawn_shop() -> void:
	shop = load(SHOP_PATH).instantiate()
	get_node("/root/TestRoom").add_child(shop)
	shop.restock()


func set_visible_players_hud(_is_visible: bool) -> void:
	for hud in player_huds:
		HUD.set_enable_hud(hud, _is_visible)

func kill_mobs() -> void:
	for mob in get_tree().get_nodes_in_group("Mob"):
		REWARD_MANAGER.set_reward(mob, REWARD_AFTER_WAVE)
	get_tree().call_group("Mob", "kill") #Need to make signal

func rm_entities_in_group(_group: StringName) -> void:
	get_tree().call_group(_group, "queue_free")

func magnetize_coins() -> void:
	get_tree().call_group("Coin", "set_magnetize_target") #Need to make signal too
