@icon("res://Sprites/Weapons/Gun.png")
extends WEAPON

class_name WEAPON_RANGE

@export_category("Range properties")
@export var bullet_scene: PackedScene
@export var bullet_speed: float
@export var bullet_effect_duration: float
@export var bullet_effect_t: float

@onready var _shot_pos: Marker2D = $Pivot/ShotPosition
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var anim_sprite: AnimatedSprite2D = $Pivot/AnimatedSprite2D
@onready var audio: AudioStreamPlayer = $AudioPlayer

func attack(_target_global_position: Vector2):
	if ammo <= 0 or _check_cooldown():
		return
	ammo -= 1
	cooldown_timer.start(cooldown)

	var _weapon_dir = get_weapon_direction()
#	Shoot to weapon direction
	bullet_instantiate(_shot_pos.global_position, _shot_pos.global_position + _weapon_dir)

	make_some_stuff()

func get_weapon_direction() -> Vector2:
	return Vector2.RIGHT.rotated(global_rotation)

func bullet_instantiate(instantiate_pos: Vector2, target_global_pos: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	
	add_child(bullet)
	bullet.global_position = instantiate_pos
	bullet.shot(damage, target_global_pos, bullet_speed, bullet_effect_duration, bullet_effect_t)

func make_some_stuff() -> void:
	anim_player.animation_finished.connect(update_animation)
	anim_player.play(player_animation)
	anim_sprite.play(attack_animation)
	audio.play()

func update_animation(_anim_name: StringName):
	if _anim_name == player_animation:
		anim_sprite.play(main_animation)
	anim_player.animation_finished.disconnect(update_animation)
