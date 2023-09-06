extends Node2D

class_name SHOP

enum PLACES{LEFT, CENTER, RIGHT}
enum PRODUCT_IDS{AMMO = 4, HP = 6}

var shop_pool: Array = Items.weapons.keys()

@onready var places = {
	PLACES.LEFT: $Left/ShopCellLeft,
	PLACES.CENTER: $Center/ShopCellCenter,
	PLACES.RIGHT: $Right/ShopCellRight
}

func randomise_product_quantity() -> int:
	var quantity: int = randi_range(1, 5)
	return quantity

func restock() -> void:
	update_weapons_pool()
	var ammo: PackedScene = Items.items[randi_range(4, 5)]
	var hp: PackedScene = Items.items[PRODUCT_IDS.HP]
	var weapon: PackedScene = define_weapon()
	place_product(ammo, PLACES.LEFT, 1, 8)
	place_product(weapon, PLACES.CENTER, 1, 25)
	place_product(hp, PLACES.RIGHT, randomise_product_quantity(), 5)

func place_product(_product: PackedScene, place: int, product_quantity: int, _cost: int) -> void:
	if _product == null:
		return
	places[place].append_product_to_cell(_product, product_quantity, _cost)

func define_weapon() -> PackedScene:
	if shop_pool.is_empty():
		return Items.items[randi_range(4, 6)]
	var random_weapon_id_index: int = randi() % shop_pool.size()
	var weapon_id: int = shop_pool[random_weapon_id_index]
	
	return Items.weapons[weapon_id]

func update_weapons_pool() -> void:
	for weapon in PlayerInventory.weapons:
		var same_weapon_index: int = shop_pool.find(weapon.ID)
		if same_weapon_index == -1:
			return
		shop_pool.remove_at(same_weapon_index)
