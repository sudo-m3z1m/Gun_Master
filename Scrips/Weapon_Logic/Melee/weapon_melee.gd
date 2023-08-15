extends WEAPON

class_name WEAPON_MELEE

var target_global_position: Vector2

func attack(_target_global_position: Vector2) -> void:
	pass
#	if $Cooldown_Timer.is_stopped() == false:
#		return
#	$AnimationPlayer.play(animation)
##	$Pivot/AnimatedSprite2D.animation = "" Later
#	$Cooldown_Timer.start(cooldown)

func check_body(body) -> void:
#	_give_damage(body)
	pass
	
func check_body_exited(body) -> void:
#	_give_damage(body)
	pass

func _give_damage(_body) -> void:
	pass
#	if $AnimationPlayer.is_playing() == false:
#		return
#	var damage_velocity: Vector2 = global_position.direction_to(target_global_position)
#	for group in ENEMY_GROUP:
#		if _body.is_in_group(group):
#			DAMAGE_MANAGER._give_damage(self, _body, damage_velocity, 2)
