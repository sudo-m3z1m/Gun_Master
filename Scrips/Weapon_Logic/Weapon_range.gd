@icon("res://Sprites/Weapons/Gun.png")
extends WEAPON

class_name WEAPON_RANGE

@export_category("Range properties")
@export_dir var bullet_path

func _attack(_target_global_position: Vector2):
	if _ready_to_shot == false:
		return
	var bullet = load(bullet_path).instantiate()
	bullet.global_position = pivot.global_position
	get_tree().current_scene.add_child(bullet)
	bullet.shot(_target_global_position)
	bullet.damage = damage
	
	_ready_to_shot = false
	$Cooldown_Timer.start(cooldown)
	
	$AnimationPlayer.play("Attack_recoil")
	$Pivot/AnimatedSprite2D.play("SCREAM")
