extends Node2D

func update_score(new_score):
	$MoneyHUD/Score.text = str(new_score)
