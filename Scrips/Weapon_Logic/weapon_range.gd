@icon("res://Sprites/Weapons/Gun.png")
extends WEAPON

class_name WEAPON_RANGE

@export_category("Range properties")
@export_dir var bullet_path
@export var shake_strength: float
@export var ammo: int:
	set(_ammo):
		ammo = _ammo
		update_ammo(_ammo)
const shake_time: float = 0.1

func attack(_target_global_position: Vector2):
	if $Cooldown_Timer.is_stopped() == false or ammo <= 0:
		return
	
	ammo -= 1
	$Cooldown_Timer.start(cooldown)
	bullet_instantiate($Pivot/ShotPosition.global_position, _target_global_position)
	
	make_some_stuff()
	shake_camera()

func shake_camera() -> void:
	var camera: Camera2D = get_parent().get_node("Camera")
	camera.make_shake(shake_time, shake_strength)

func bullet_instantiate(instantiate_pos: Vector2, target_global_pos: Vector2) -> void:
	var bullet = load(bullet_path).instantiate()
	bullet.global_position = instantiate_pos
	get_tree().current_scene.add_child(bullet)
	bullet.shot(target_global_pos)
	bullet.damage = damage

func make_some_stuff() -> void:
	$AudioPlayer.play()
	$AnimationPlayer.play("Attack_recoil")
	$Pivot/AnimatedSprite2D.play(animation)

func update_ammo(new_ammo):
	if get_parent():
		get_parent().update_ammo(new_ammo)
	
