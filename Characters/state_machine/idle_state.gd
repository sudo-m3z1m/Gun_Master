extends Node

class_name IDLE_STATE

func _init(_target):
	_target.get_node("Sprite").play("IDLE")
