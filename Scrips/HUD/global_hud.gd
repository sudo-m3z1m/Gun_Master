extends CanvasLayer

var HUDS = GlobalScope.GLOBAL_HUDS
var current_menu

@onready var pause_hud = $PauseHUD
@onready var main_hud = $MainHUD
@onready var hp_hud = $HpProgressBar
@onready var coin_hud = $CoinCounter
@onready var ammo_hud = $AmmoCounter
@onready var settings_hud = $Settings

@onready var hud_dict: Dictionary = {
	HUDS.MAIN: main_hud,
	HUDS.SETTINGS: settings_hud,
	HUDS.PAUSE: pause_hud,
	HUDS.HP: hp_hud,
	HUDS.COIN: coin_hud,
	HUDS.AMMO: ammo_hud,
}

func set_enable_hud(hud: int, _is_enabled: bool) -> void:
	hud_dict[hud].set_enable(_is_enabled)

func update_user_hud(new_value: int, hud: int):
	hud_dict[hud].update_count(new_value)
