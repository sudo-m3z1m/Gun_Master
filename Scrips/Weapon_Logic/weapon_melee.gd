extends WEAPON

class_name WEAPON_MELEE

var target_global_position: Vector2

var ammo: int = 0 #КОСТЫЛЬ

func attack(_target_global_position: Vector2) -> void:
	if $Cooldown_Timer.is_stopped() == false:
		return
	$AnimationPlayer.play(animation)
#	$Pivot/AnimatedSprite2D.animation = "" Later
	$Cooldown_Timer.start(cooldown)

func give_damage(body) -> void:
	if $AnimationPlayer.is_playing() == false:
		return
	var damage_velocity: Vector2 = global_position.direction_to(target_global_position)
	for group in ENEMY_GROUP:
		if body.is_in_group(group):
			DAMAGE_MANAGER._give_damage(self, body, damage_velocity)
