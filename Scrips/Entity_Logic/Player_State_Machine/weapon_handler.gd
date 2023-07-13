extends Node2D

class_name WEAPON_HANDLER

var current_weapon: Area2D

@onready var invent: INVENTORY = PlayerInventory
@onready var player: PhysicsBody2D = get_parent()

func _physics_process(delta):
	rotate_weapon()

func take_weapon(_weapon: Area2D):
	var weapon_parent = _weapon.get_parent()
#	print(_weapon)
	invent.weapons.append(_weapon)
#	print(invent.weapons)
	_weapon.global_position = Vector2.ZERO
	weapon_parent.remove_child(_weapon)
	player.add_child(_weapon)
	change_weapon_from_array(-1)
#	print(PlayerInventory.weapons)

func take_throwed_weapon(_weapon):
	for weapon in invent.weapons:
		if weapon._is_throwed == true\
		and weapon.get_name() == _weapon.get_name():	# IDLT
			_weapon.queue_free()
			weapon._is_throwed = false
			change_weapon_from_array(invent.weapons.find(weapon))

func rotate_weapon() -> void:
	if !current_weapon:
		return
	var _mouse_pos: Vector2 = get_global_mouse_position()
	var angle_to_target = player.get_angle_to(_mouse_pos)
	current_weapon.rotate_to_target(angle_to_target)

func throw() -> void:
	var target_global_pos: Vector2 = get_global_mouse_position()	# IDLT
	current_weapon.throw_self(target_global_pos)

func attack() -> void:
	if !current_weapon:
		return
	var target_global_pos: Vector2 = get_global_mouse_position()	# IDLT
	current_weapon.attack(target_global_pos)
	player.get_node("Camera").make_shake(0.5, 30)

func scroll_weapon(delta_index: int) -> void:
	print(invent.weapons)
	change_weapon_from_array(invent.weapons.find(current_weapon) + delta_index)

func change_weapon_from_array(next_gun_index: int) -> void: # IDLT
	next_gun_index %= invent.weapons.size()
	for buff_weapon in invent.weapons:
		if buff_weapon == null:
			return
		buff_weapon._is_active = false

	current_weapon = invent.weapons[next_gun_index]
	invent.weapons[next_gun_index]._is_active = true
