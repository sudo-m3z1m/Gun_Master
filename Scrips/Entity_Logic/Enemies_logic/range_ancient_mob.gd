extends Mob_class

@onready var shot_timer: Timer = $ShotTimer

func _ready():
	weapon_ready()
	state_machine.change_state("Moving")

func attack(target):
	weapon.attack(target.global_position)

func spawn(position: Vector2, scene):
	super(position, scene)
