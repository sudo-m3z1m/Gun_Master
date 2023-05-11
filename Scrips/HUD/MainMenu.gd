extends Control

#var settings_scene:PackedScene = preload("res://HUD/Settings.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Rooms/test_tile_map.tscn")

func _on_settings_button_pressed():
	pass
