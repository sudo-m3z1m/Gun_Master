extends Node2D
class_name Weapon_melee

@export var id: int
@export var damage: float
@export var cooldown: float

@onready var identifier = preload("res://Scrips/Game_Logic/Identifiers.gd")
@onready var _rigid = "Rigid_" + self.get_name()

var _is_picked: bool = false:
	set(picked):
		_is_picked = picked
		pick_status_change(picked)

var damage_velocity: Vector2

func _throwable_weapon_start_pos():
	return $Pivot

func _make_ready(ready_pos):
	$Pivot.position.x = ready_pos
	$CooldownTimer.wait_time = cooldown

func return_identifiers(_just_id, reversed_id):
	if _just_id:
		return identifier.identifiers_for_weapon(id, self.get_name())
	
	if reversed_id:
		return identifier.identifiers_for_rigid(id, _rigid)

func _attack(target_position):
	if $AnimationPlayer.is_playing():
		return
	
	$CooldownTimer.start()
	$AnimationPlayer.play("MeleeAttack")
	$AudioPlayer.play()

func Attacked_subject_check(body):
	if $AnimationPlayer.is_playing() and \
	(body.is_in_group("Player") or body.is_in_group("Mob")):
		var recoil_direction: Vector2 = global_position.\
		direction_to(get_global_mouse_position())
		recoil_direction.limit_length(1)
		
		Damage_MANAGE._give_damage(self, body, recoil_direction)

func pick_status_change(is_picked):
	if get_parent().is_in_group("Player"):
		get_parent()._weapon_is_picked = is_picked
