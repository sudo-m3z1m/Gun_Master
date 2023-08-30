extends Area2D

class_name ITEM

@export var ID: int

func activate(_player: PhysicsBody2D) -> void:
	PlayerInventory.items.append(self)
