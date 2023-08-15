extends Node2D

class_name WEAPON_HANDLER

var current_weapon: WEAPON = null# WEAPON.new()

@onready var invent: INVENTORY = PlayerInventory
@onready var player: PhysicsBody2D = get_parent()

func _physics_process(delta):
	rotate_weapon()

func take_weapon(_weapon: Area2D):
	var weapon_parent = _weapon.get_parent()
	if weapon_parent == player:
		return
	invent.weapons.append(_weapon)
	_weapon.position = Vector2()
	weapon_parent.remove_child(_weapon)
	player.call_deferred("add_child", _weapon)
	change_weapon_from_array(-1)

func take_throwed_weapon(_weapon):
	var _weapon_name: String = _weapon.get_name()
	var weapon: Area2D = check_throwed_weapon(_weapon_name)
	if weapon:
		_weapon.queue_free()
		change_weapon_from_array(invent.weapons.find(weapon))

func check_throwed_weapon(_weapon_name: String) -> Area2D:
	for weapon in invent.weapons:
		if weapon.get_name() == _weapon_name:
			return weapon
	
	return null

func rotate_weapon() -> void:
	if !current_weapon:
		return
	var _mouse_pos: Vector2 = get_global_mouse_position()
	var angle_to_target = player.get_angle_to(_mouse_pos)
	current_weapon.rotate_to_target(angle_to_target)

func throw() -> void:
	var target_global_pos: Vector2 = get_global_mouse_position()
	current_weapon.throw_self(target_global_pos)

func attack() -> void:
	var target_global_pos: Vector2 = get_global_mouse_position()
	current_weapon.attack(target_global_pos)

func scroll_weapon(delta_index: int) -> void:
	change_weapon_from_array(invent.weapons.find(current_weapon) + delta_index)

func change_weapon_from_array(next_gun_index: int) -> void: # IDLT
	next_gun_index %= invent.weapons.size()
	for buff_weapon in invent.weapons:
		if buff_weapon == null:
			return
		buff_weapon._is_active = false
	
	current_weapon = invent.weapons[next_gun_index]
	invent.weapons[next_gun_index]._is_active = true
