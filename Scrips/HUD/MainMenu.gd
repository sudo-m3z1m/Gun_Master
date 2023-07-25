extends Control

func _ready():
	SoundManager.change_main_music("Main_menu")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Rooms/test_tile_map.tscn")

func _on_settings_button_pressed():
	$Settings.visible = true

func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()
