extends Node

class_name VisualEffectsManager

static func apply_visual_effect(_target: PhysicsBody2D, _color: Color, _particle: GPUParticles2D) -> void:
	_target.modulate = _color
	_target.add_child(_particle)

static func delete_visual_effect(_target: PhysicsBody2D, _particle: GPUParticles2D) -> void:
	_target.modulate = Color.WHITE
	_particle.queue_free()
