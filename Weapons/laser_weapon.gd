extends WEAPON

@onready var shot_pos: Marker2D = $ShotPosition
@onready var raycast: RayCast2D = $RayCast
@onready var laser: Line2D = $Laser

var tween: Tween

func attack(_global_target_pos: Vector2):
	if ammo <= 0 or _check_cooldown():
		return
	ammo -= 1
	cooldown_timer.start(cooldown)
	
	set_laser()
	set_animation()
	damage_target()
#	shake_camera()

func set_laser() -> void:
	var first_laser_pos: Vector2
	var last_laser_pos: Vector2
	tween = create_tween()
	
	first_laser_pos = shot_pos.position
	last_laser_pos = to_local(raycast.get_collision_point())
	
	laser.scale = Vector2(1, 0.1)
	laser.clear_points()
	laser.add_point(first_laser_pos)
	laser.add_point(last_laser_pos)
	
	tween.tween_property(laser, "scale", Vector2(1, 1), 0.05)
	tween.tween_property(laser, "scale", Vector2(1, 0.1), 0.05)
	tween.finished.connect(finish_tween)

func damage_target() -> void:
	var target = raycast.get_collider()
	if target.get("health_points"):
		target.health_points.take_damage(damage)
		return

func finish_tween() -> void:
	tween.stop()
	laser.clear_points()

func set_animation() -> void:
	anim_player.play(player_animation)
	anim_sprite.play(attack_animation)
	audio.play()
