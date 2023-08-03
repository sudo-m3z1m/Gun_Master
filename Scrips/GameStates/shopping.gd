extends GAME_STATE

class_name SHOPPING_STATE

var cntdown_timer: Timer

const SHOP_TITLE: String = "shop"
const SHOPPING_TIME: float = 15.0

func enter_state() -> void:
	cntdown_timer = GameManager.countdown_timer
	cntdown_timer.timeout.connect(change_state_to_opposite)
	cntdown_timer.start(SHOPPING_TIME)
	GameManager.instantiate_shop()
	
	SoundManager.change_main_music(GlobalScope.MUSICS.SHOP_MUSIC, 0.5)

func update() -> void:
	var time: int = cntdown_timer.time_left / 1
	HUD.main_hud.update_count(time, SHOP_TITLE)

func exit_state() -> void:
	cntdown_timer.timeout.disconnect(change_state_to_opposite)
	GameManager.rm_entities_in_group("Shop")

func change_state_to_opposite() -> void:
	GameManager.state_machine.change_state(WAVES_STATE)
