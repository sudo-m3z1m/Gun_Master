extends Node

signal kill_mob
signal magnetize

@export var start_wave_time: float
@export var start_mob_time: float
@export var start_wave_count: int
@export var player_scene: PackedScene
@export var shop_scene: PackedScene

@onready var countdown_timer: Timer = $CountdownTimer
@onready var mob_timer: Timer = $MobTimer
@onready var state_machine: GAME_STATE_MACHINE = $GameStateMachine
@onready var scene = get_tree().current_scene
@onready var mob_spawn_location: PathFollow2D = scene\
.get_node("MobPath/MobSpawnLocation")
@onready var current_wave_count: int = start_wave_count
@onready var current_wave_time: float = start_wave_time
@onready var current_mob_time: float = start_mob_time

var player: character
var mob_paths: Array[PackedScene] = [
#	preload("res://Prefabs/Entity/Ancient_mob.tscn"),
	preload("res://Prefabs/Entity/ancient_range_mob.tscn")
]

func _process(delta):
	state_machine.real_state.update()

func start_game() -> void:
	reset_game()
	instantiate_player()
	spawn_player()
	GameManager.rm_entities_in_group("Mob")

func reset_game() -> void:
	current_wave_time = start_wave_time
	current_wave_count = start_wave_count
	state_machine.change_state(WAVES_STATE)

func stop_game() -> void:
	state_machine.change_state(GAME_OVER_STATE)
	GameManager.rm_entities_in_group("Mob")
	GameManager.rm_entities_in_group("Coin")

func spawn_mob():
	if get_tree().get_nodes_in_group("Mob").size() >= 1: #GlobalScope.MAX_ENEMYS_NUMBER:
		return
	var mob = randomize_mobs().instantiate()
	mob_spawn_location.progress_ratio = randf()

	mob.spawn(mob_spawn_location.position, scene)

func instantiate_player() -> character:
	player = player_scene.instantiate()
	PlayerInventory.player = player
	return player

func spawn_player() -> void:
	player.global_position = get_node("/root/TestRoom/PlayerSpawnPos")\
	.global_position
	scene.add_child(player)

func instantiate_shop() -> void:
#	print("Shop instantiated")
	var shop: SHOP = shop_scene.instantiate()
	scene.add_child(shop)
	shop.restock()

func randomize_mobs() -> PackedScene:
	var mob_path_index: int
	mob_path_index = randi() % mob_paths.size()
	return mob_paths[mob_path_index]

func rm_entities_in_group(_group: StringName) -> void:
	get_tree().call_group(_group, "queue_free")

func kill_mobs() -> void:
	for mob in get_tree().get_nodes_in_group("Mob"):
		REWARD_MANAGER.set_reward(mob, 1)
	get_tree().call_group("Mob", "kill")

func magnetize_coins() -> void:
	emit_signal("magnetize")
