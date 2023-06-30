extends Node2D

class_name SHOP

enum PLACES{LEFT, CENTER, RIGHT}

func place_product(_product: PackedScene, place: int, product_quantity: int, _cost: int) -> void:
	var product: Sprite2D = _product.instantiate()
	match place:
		PLACES.RIGHT:
			#Animations
			$Right/ShopCell1.add_product_to_cell(product, product_quantity, _cost)
		PLACES.LEFT:
			#Animations
			$Left/ShopCell3.add_product_to_cell(product, product_quantity, _cost)
		PLACES.CENTER:
			#Animations
			$Center/ShopCell2.add_product_to_cell(product, product_quantity, _cost)
