extends Node

class_name IDLE_STATE

func _init(_target):
	_target.get_node("AnimatedSprite2D").play("IDLE")
