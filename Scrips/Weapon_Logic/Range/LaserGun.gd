extends WEAPON_RANGE

class_name LaserGun

@onready var line: Line2D = $Pivot/ShotPosition/Line2D
@onready var raycast: RayCast2D = $RayCast2D

#func _physics_process(delta):
#	print(raycast.get_collision_point())

func bullet_instantiate(instantiate_pos: Vector2, target_global_pos: Vector2) -> void:
	line.add_point(line.position)
	line.add_point(to_local(raycast.get_collision_point()))
	DAMAGE_MANAGER._give_damage(self, raycast.get_collider(), rotation * 10, 0.1)
#	var bullet = bullet_scene.instantiate()
#	var target_position: Vector2 = raycast.get_collision_point()
#
#	add_child(bullet)
#	bullet.global_position = instantiate_pos
#	bullet.shot(damage, target_position, bullet_speed)
