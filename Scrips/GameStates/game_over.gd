extends GAME_STATE

class_name GAME_OVER_STATE

func enter_state() -> void:
	HUD.set_enable_hud(GlobalScope.GLOBAL_HUDS.OVER, true)
	SoundManager.change_main_music(GlobalScope.MUSICS.GAME_OVER_MUSIC)

func exit_state() -> void:
	HUD.set_enable_hud(GlobalScope.GLOBAL_HUDS.OVER, false)
