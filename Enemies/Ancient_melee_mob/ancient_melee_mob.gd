extends Mob_class

class_name AncientMeleeMob

@export var damage: float
@export var dash_speed_min: float
@export var dash_speed_max: float
@export var dash_time_min: float
@export var dash_time_max: float

@onready var area_for_dashes: Area2D = $AreaForDashes
@onready var area_for_attack: Area2D = $AttackArea
@onready var general_timer: Timer = $GeneralTimer

func _ready():
	state_machine.change_state("Moving")
