extends WEAPON

class_name WEAPON_MELEE

@export var player_animations: Array[String] #Need to delete this

@onready var hurt_box_area: Area2D = $Pivot/area_for_hurt

var target_global_position: Vector2

func attack(_target_global_position: Vector2) -> void:
	if _check_cooldown():
		return
	cooldown_timer.start(cooldown)
	
	player_animation = player_animations[randi() % player_animations.size()]
	
	hurt_box_area.body_entered.connect(check_body)
	anim_player.play(player_animation)
	anim_sprite.play(attack_animation)

func check_body(_body) -> void:
	if _body.get("health_points"):
		_body.health_points.take_damage(damage)
	hurt_box_area.body_entered.disconnect(check_body)

func check_body_exited(body) -> void:
	pass
