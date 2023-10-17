extends CharacterBody2D
class_name character

@export var max_speed: float
@export var start_hp: int
@export var money: int:
	set(mon):
		HUD.update_user_hud(mon, GlobalScope.GLOBAL_HUDS.COIN)
		money = mon
@export var invincible_state_duration: float	#Remade this into the hp states
@export var blink_t: float	#Remade this into the hp states

@onready var scene = get_tree().current_scene
@onready var blink_timer: Timer = $BlinkTimer #Remade this into the hp states
@onready var weapon_handler = $WeaponHandler
@onready var health_points: HealthPoints = HealthPoints.new(self, start_hp)

var friction: float = 45
var acceleration: float = 90
var direction: Vector2

#func _ready():
#	EffectsManager.try_apply_effect(GlobalScope.EFFECTS.POISON, self, 1, 1, 0.1)

func _physics_process(delta):
	set_character_velocity()
	move_and_slide()

func set_direction(_direction):
	flip_handler(_direction)
	direction = _direction

func flip_handler(_new_dir: Vector2):
	if _new_dir.x < 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func set_character_velocity() -> void:
	if direction.length() != 0:
		velocity = velocity.move_toward(direction.normalized() * max_speed, acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)

func _collision_checker(area):
	if !area.is_in_group("PickableItem"):
		return
	PlayerInventory.add_item(area)

func bodies_collision_checker(body):
	weapon_handler.take_throwed_weapon(body)

func set_damage_effect() -> void:	#Remade this into the hp states
#	var invincible_timer: SceneTreeTimer
	var new_hp_amount: int = health_points.health_points
#	invincible_timer = get_tree().create_timer(invincible_state_duration)
#	invincible_timer.timeout.connect(finish_blinking)
#	blink_timer.wait_time = blink_t
#	blink_timer.timeout.connect(blink_after_damage_take)
#	blink_timer.start()

#	health_points.damage_k = 0
	HUD.update_user_hud(new_hp_amount, GlobalScope.GLOBAL_HUDS.HP)

func set_heal_effect() -> void:
	var new_hp_amount: int = health_points.health_points
	HUD.update_user_hud(new_hp_amount, GlobalScope.GLOBAL_HUDS.HP)

func kill():
	GameManager.stop_game()
	call_deferred("queue_free")

func blink_after_damage_take() -> void:	#Remade this into the hp states
	$Sprite.visible = !$Sprite.visible

func finish_blinking() -> void:	#Remade this into the hp states
	blink_timer.stop()
	blink_timer.timeout.disconnect(blink_after_damage_take)
	$Sprite.visible = true
	health_points.damage_k = 1

func change_modulate(_modulate: Color):
	self.set_modulate(_modulate)
