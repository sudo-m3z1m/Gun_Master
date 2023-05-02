extends Control

func _ready():
	pass


func _process(delta):
	pass


func _on_exit_button_pressed():
	get_tree().quit()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Rooms/test_tile_map.tscn")
