extends Projectile

@onready var laser: Line2D = $LaserTexture

func shot(_damage: float, _target_pos: Vector2, speed: float = 500.0) -> void:
	damage = _damage
	laser.add_point(get_parent()._shot_pos.global_position)
	laser.add_point(to_local(_target_pos))
	hitbox.global_position = _target_pos
