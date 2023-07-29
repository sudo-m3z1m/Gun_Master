@icon("res://Sprites/Weapons/Bullet.png")
extends RigidBody2D

class_name projectile

@export var projectile_speed: float
@export var damage: float
@export var poison_damage: float
@export var effect_duration: float
@export var T: float

var direction: Vector2

func shot(_target_position) -> void:
	direction = global_position.direction_to(_target_position)
	
	var velocity = direction * projectile_speed
	linear_velocity = velocity
	$DisapearTimer.start()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("Mob"):
		DAMAGE_MANAGER._give_damage(self, body, direction * 10, 0.1)
		EffectsManager.give_effect(GlobalScope.EFFECTS.POISON, body, poison_damage, effect_duration, T)
		queue_free()
	if body.is_class("TileMap"):
		queue_free()

func disapear():
	call_deferred("queue_free")
