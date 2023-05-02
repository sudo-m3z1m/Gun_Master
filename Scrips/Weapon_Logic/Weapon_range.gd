@icon("res://Sprites/Weapons/Gun.png")
extends Node2D
class_name Weapon_range

@export var id: int
@export var cooldown: float
@export_dir var bullet_path

@onready var identifier = preload("res://Scrips/Game_Logic/Identifiers.gd")
@onready var _rigid = "Rigid_" + self.get_name()

var _is_picked: bool = false:
	set(picked):
		_is_picked = picked
		pick_status_change(picked)

func _throwable_weapon_start_pos():
	return $Pivot

func _make_ready(ready_pos):
	$Pivot.position.x = ready_pos
	$CoolDown_timer.wait_time = cooldown

func return_identifiers(id_from):
	if id_from == "Weapon":
		return identifier.identifiers_for_weapon(id, self.get_name())
	
	if id_from == "Rigid":
		return identifier.identifiers_for_rigid(id, _rigid)

func _attack(target_position):
	if $AnimationPlayer.is_playing() or $CoolDown_timer\
	.time_left >= 0.13:
		return

	var bullet = load(bullet_path).instantiate()
	$AnimationPlayer.play("WeaponsAttack")
	$Pivot/AnimatedSprite2D.play("Shot")
	$AudioPlayer.play()
	
	$Pivot/ShotLight.enabled = true
	$LightTime.start()
	
	bullet.global_position = $Pivot/ShotPosition.global_position
	get_tree().current_scene.add_child(bullet)
	bullet.shot(target_position)
	$CoolDown_timer.start()

func _on_LightTime_timeout():
	$Pivot/ShotLight.set_enabled(false)
	
func set_hand_scale(k = Vector2(0.0, 0.0)):
	if k == Vector2(0.0, 0.0):
		return
	
	var _scale = get_scale() * k
	return _scale

func _on_animated_sprite_2d_animation_finished():
	if $Pivot/AnimatedSprite2D.animation == "Shot":
		$Pivot/AnimatedSprite2D.play("IDLE")

func pick_status_change(is_picked):
	if get_parent().is_in_group("Player"):
		get_parent()._weapon_is_picked = is_picked
