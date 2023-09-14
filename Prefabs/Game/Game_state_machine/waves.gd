extends GAME_STATE

class_name WAVES_STATE

var spawn_timer: Timer
var cntdown_timer: Timer
var spawn_time: float
var wave_time: float
var current_wave: int

const DELTA_WAVE_TIME: float = 6.0

func enter_state() -> void:
	spawn_timer = GameManager.mob_timer
	cntdown_timer = GameManager.countdown_timer
	spawn_time = GameManager.current_mob_time
	wave_time = GameManager.current_wave_time
	current_wave = GameManager.current_wave_count
	
	SoundManager.change_main_music(GlobalScope.MUSICS.WAVES_MUSIC, 1.5)
	connect_timers()
	start_timers()

func exit_state() -> void:
	disconnect_timers()
	GameManager.current_wave_count += 1
	GameManager.current_wave_time = GameManager.current_wave_count * DELTA_WAVE_TIME
	GameManager.kill_mobs()	#Maybe delete mob must shop and delete shop must wave state
	GameManager.call_deferred("magnetize_coins")

func update() -> void:
	var time: int = cntdown_timer.time_left / 1
	HUD.main_hud.update_count(time, current_wave)

func change_state_to_opposite() -> void:
	GameManager.state_machine.change_state(SHOPPING_STATE)

func connect_timers() -> void:
	spawn_timer.timeout.connect(GameManager.locate_mob)
	cntdown_timer.timeout.connect(change_state_to_opposite)

func disconnect_timers() -> void:
	spawn_timer.timeout.disconnect(GameManager.locate_mob)
	cntdown_timer.timeout.disconnect(change_state_to_opposite)

func start_timers() -> void:
	spawn_timer.start(spawn_time)
	cntdown_timer.start(wave_time)
