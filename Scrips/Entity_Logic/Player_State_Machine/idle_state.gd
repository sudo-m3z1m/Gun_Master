extends Node

static func start(target):
	target.get_node("AnimatedSprite2D").play("IDLE")
