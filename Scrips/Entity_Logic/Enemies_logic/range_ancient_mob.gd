extends Mob_class

@export var bullet_scene: PackedScene

@onready var shot_timer: Timer = $ShotTimer

func _ready():
	state_machine.change_state("Moving")

func attack(target):
	weapon.attack(target.global_position)

func spawn(position: Vector2, scene):
	super(position, scene)
	weapon_ready()
