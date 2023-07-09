extends Sprite2D

class_name SHOP_CELL

@export_category("Shop Things")
var product#: Sprite2D
@export var product_quantity: int

func _ready():
	$Area2D.body_entered.connect(_body_entered)

func add_product_to_cell(_product, _quantity, _cost):
	if product:
		printerr("cell isn't empty")
		return
	product = _product
	product.cost = _cost
	product.quantity = _quantity
	product_quantity = _quantity
	self.add_child(_product)
	self.region_enabled = true

func _body_entered(body):
	if !body.is_in_group("Player") or !product:
		return
	buy(body, body.money)

func buy(player: CharacterBody2D, players_money: int) -> void:
	if players_money - product.cost < 0 or product_quantity <= 0:
		return
	give_product(player, product)
	player.money -= product.cost
	update_products()

func give_product(player, product):
	if product.is_ammo:
		player.current_weapon.ammo += product.content
	if product.is_hp:
		player.health_points += product.content

func update_products():
	if product_quantity <= 1:
		product_quantity -= 1
		product.queue_free()
		product = null
		self.region_enabled = false
	else:
		product_quantity -= 1
		product.quantity = product_quantity
		product.start_blink()
