extends Node2D

class_name SHOP

enum PLACES{LEFT, CENTER, RIGHT}

@onready var places = {
	PLACES.LEFT: $Left/ShopCell3,
	PLACES.CENTER: $Center/ShopCell2,
	PLACES.RIGHT: $Right/ShopCell1
}

func randomise_product_quantity() -> int:
	var quantity: int = randi_range(1, 5)
	return quantity

func restock() -> void:
	#TODO:
	var ammo: PackedScene = load("res://Prefabs/ShopProducts/ammo.tscn")
	var hp: PackedScene = load("res://Prefabs/ShopProducts/health_points.tscn")
	var weapon: PackedScene = define_weapon()
	place_product(ammo, PLACES.LEFT, randomise_product_quantity(), 8)
	place_product(weapon, PLACES.CENTER, 1, 25)
	place_product(hp, PLACES.RIGHT, randomise_product_quantity(), 5)

func place_product(_product: PackedScene, place: int, product_quantity: int, _cost: int) -> void:
	if _product == null:
		return
	var product = _product.instantiate() #: Sprite2D
	places[place].add_product_to_cell(product, product_quantity, _cost)
	
func define_weapon() -> PackedScene:
	var weapon_id: int = randf_range(1, Items.weapons.size())
	return Items.weapons[weapon_id]
