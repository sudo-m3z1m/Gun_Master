extends Mob_class

class_name AncientMeleeMob

@export var cooldown_time: float
@export var idle_time: float
@export var max_prepare_time: float
@export var dash_time: float

@onready var area_for_dashes: Area2D = $AreaForDashes
@onready var area_for_attack: Area2D = $AttackArea
@onready var general_timer: Timer = $GeneralTimer

var stunning_time: float
var dash_strength: float = 1000
#var can_attack: bool = true

func _ready():
	state_machine.change_state("Moving")
