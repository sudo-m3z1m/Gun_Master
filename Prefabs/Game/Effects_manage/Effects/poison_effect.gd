extends EFFECT

class_name POISON

var speed_down: float = 2
var particle: GPUParticles2D

func _init(_target: PhysicsBody2D, _damage: float = 1.0, _dur: float = 1.0, T: float = 0.1):
	super(_target, _damage, _dur, T)
	particle_path = "res://Prefabs/Game/Effects_manage/EffectsParticles/poison_particle.tscn"
	effect_color = Color.GREEN
	_give_some_effects()

func _give_some_effects() -> void:
	particle = load(particle_path).instantiate()
	VisualEffectsManager.apply_visual_effect(target, effect_color, particle)
	target.max_speed /= speed_down

func _deactivate_some_effects() -> void:
	VisualEffectsManager.delete_visual_effect(target, particle)
	target.max_speed *= speed_down
