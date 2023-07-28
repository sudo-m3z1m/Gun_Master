extends CanvasLayer

func _ready():
	SoundManager.change_main_music("Main_menu")

func set_enable(_is_enable: bool):
	visible = _is_enable
	get_tree().paused = _is_enable

func _on_start_button_pressed():
	GameManager.start_game()
	set_enable(false)
	HUD.change_current_menu(HUD.pause_hud)

func _on_settings_button_pressed():
	get_parent().set_enable_hud(GlobalScope.GLOBAL_HUDS.SETTINGS, true)

func _on_exit_button_pressed():
	get_tree().quit()

func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()
