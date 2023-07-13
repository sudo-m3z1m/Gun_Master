extends Sprite2D

@export_category("Product properties")
@export var cost: int
@export var quantity: int:
	set(_quant):
		quantity = _quant
		_update_quant(_quant)
@export var content: int
@export var is_ammo: bool
@export var is_hp: bool
@export var item_id: int 

const BLINK_TIME: float = 0.1

func _ready():
	$cost.text = str(cost)
	$quantity.text = str(quantity)

func _update_quant(_quant) -> void:
	$quantity.text = str(_quant)
