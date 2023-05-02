extends RigidBody2D

@export var id: int

func _ready():
	pass

func _hit_mob_by_throwing(body):
	if body.is_in_group("Player"):
		return

	if body.is_in_group("Mob"):
		body.queue_free()
		set_sleeping(true)
