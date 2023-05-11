extends Control

var previous_scene

func _on_back_pressed():
	visible = false
	get_parent().get_node("Show_handler").visible = true
