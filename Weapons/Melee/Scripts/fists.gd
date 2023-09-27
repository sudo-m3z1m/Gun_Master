extends WEAPON_MELEE

@export var player_animations: Array[String]

func attack(_target_global_position: Vector2) -> void:
	var animation_id: int
	animation_id = randi() % player_animations.size()
	player_animation = player_animations[animation_id]
	super(target_global_position)

func change_state() -> void:
	if _is_active == true:
		pivot.position.x = length_from_player
		hitbox.set_deferred("disabled", true)
		self.visible = true
		$CostyleShit.visible = false
		return
	else:
		pivot.position.x = 0
		self.visible = false
		return
