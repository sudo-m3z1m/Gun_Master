extends Node2D

func update_ammo_score(ammo_left):
	$AmmoHUD/Score.text = str(ammo_left)
