extends Node

class_name MOVE_STATE

var animated_sprite: AnimatedSprite2D

func _init(_target):
	animated_sprite = _target.get_node("AnimatedSprite2D")
	animated_sprite.frame_changed.connect(_update_frame)
	_target.get_node("AnimatedSprite2D").play("MOVE")

func _update_frame():
	var _frame = animated_sprite.frame
	var pitch = randf_range(1, 1.5)
	if _frame == 2 or _frame == 5:
		SoundManager.steps_player.pitch_scale = pitch
		SoundManager.steps_player.play()
