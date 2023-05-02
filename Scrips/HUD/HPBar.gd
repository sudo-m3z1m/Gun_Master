extends Node2D

func _check_value(hp):
	$BarDisplay/TextureProgressBar.value = hp
