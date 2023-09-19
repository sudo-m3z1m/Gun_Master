extends CanvasLayer

func _ready():
	SoundManager.change_main_music(GlobalScope.MUSICS.MAIN_MENU_MUSIC)

func set_enable(_is_enable: bool):
	visible = _is_enable
	get_tree().paused = _is_enable

func _on_start_button_pressed():
	fill_items_base()
	activate_user_hud()
	GameManager.start_game()
	set_enable(false)
	HUD.change_current_menu(HUD.pause_hud)

func _on_settings_button_pressed():
	get_parent().set_enable_hud(GlobalScope.GLOBAL_HUDS.SETTINGS, true)

func _on_exit_button_pressed():
	get_tree().quit()

func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()

func activate_user_hud() -> void:
	HUD.set_enable_hud(GlobalScope.GLOBAL_HUDS.AMMO, true)
	HUD.set_enable_hud(GlobalScope.GLOBAL_HUDS.COIN, true)
	HUD.set_enable_hud(GlobalScope.GLOBAL_HUDS.HP, true)
	HUD.set_enable_hud(GlobalScope.GLOBAL_HUDS.MAIN, true)

func fill_items_base() -> void:
	Items.fill_items_dict()
	Items.fill_weapons_dict()
	Items.fill_weapons_dict("res://Weapons/Laser/")
	Items.fill_weapons_dict("res://Weapons/Melee/")
