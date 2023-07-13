@icon("res://Sprites/Other/ShopCell.png")
extends Area2D

class_name SHOP_CELL

const BLINK_TIME: float = 0.1

@export_category("Shop Things")
@export var product: Area2D
@export var product_quantity: int:
	set(_new_quant):
		product_quantity = _new_quant
		check_product_quantity(_new_quant)
@export var product_cost: int

func append_product_to_cell(_product: PackedScene, _quantity: int, _cost: int) -> void:
	if product:
		printerr("cell isn't empty")
		return
	product = add_product(_product)
	product_cost = _cost
	product_quantity = _quantity
	update_cell_hud()

func add_product(_product: PackedScene) -> Area2D:
	var _prod: Area2D = _product.instantiate()
	body_entered.connect(player_check)
	
	$NothingSprite.visible = false
	add_child(_prod)
	return _prod

func player_check(_body) -> void:
	if !_body.is_in_group("Player"):
		return
	buy(_body, _body.money)

func buy(player: CharacterBody2D, players_money: int) -> void:
	if players_money - product_cost < 0 or product_quantity <= 0:
		return
	give_product(player)
	start_blink()
	player.money -= product_cost
	product_quantity -= 1

func give_product(player):
	PlayerInventory.add_item(product)

func check_product_quantity(new_quantity: int) -> void:
	if new_quantity == 0:
		body_entered.disconnect(player_check)
		product.queue_free()
		product = null
		product_cost = 0
		$NothingSprite.visible = true
	update_cell_hud()

func update_cell_hud():
	$Cost.text = str(product_cost)
	$Quant.text = str(product_quantity)
	
func start_blink() -> void:
	var blink_timer: Timer = Timer.new()
	add_child(blink_timer)
	product.visible = false
	blink_timer.one_shot = true
	blink_timer.timeout.connect(blink)
	blink_timer.start(BLINK_TIME)

func blink():
	if !product:
		return
	product.visible = true
