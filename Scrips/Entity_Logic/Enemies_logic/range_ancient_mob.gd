extends Mob_class

@export var bullet_scene: PackedScene
@export var poison_damage: float

@onready var shot_timer: Timer = $ShotTimer

func _ready():
	state_machine.change_state("Moving")

func attack(target):
	weapon.attack(target.global_position)
