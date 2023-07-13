extends Node2D

class_name SHOP

enum PLACES{LEFT, CENTER, RIGHT}
enum PRODUCT_IDS{AMMO = 3, HP}

@onready var places = {
	PLACES.LEFT: $Left/ShopCellLeft,
	PLACES.CENTER: $Center/ShopCellCenter,
	PLACES.RIGHT: $Right/ShopCellRight
}

func randomise_product_quantity() -> int:
	var quantity: int = randi_range(1, 5)
	return quantity

func restock() -> void:
	var ammo: PackedScene = Items.items[PRODUCT_IDS.AMMO]
	var hp: PackedScene = Items.items[PRODUCT_IDS.HP]
	var weapon: PackedScene = define_weapon()
	place_product(ammo, PLACES.LEFT, randomise_product_quantity(), 8)
	place_product(weapon, PLACES.CENTER, 1, 25)
	place_product(hp, PLACES.RIGHT, randomise_product_quantity(), 5)

func place_product(_product: PackedScene, place: int, product_quantity: int, _cost: int) -> void:
	if _product == null:
		return
	places[place].append_product_to_cell(_product, product_quantity, _cost)
	
func define_weapon() -> PackedScene:
	var weapon_id: int = randi_range(1, Items.weapons.size())
	return Items.weapons[weapon_id]
