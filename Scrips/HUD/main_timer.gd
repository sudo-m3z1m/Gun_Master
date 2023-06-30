extends Node2D

func update_main_score(time_left, _wave_count):
	$MainHUD/TimerScore.text = str(time_left)
	$MainHUD/WaveCounter.text = "Wave " + str(_wave_count)
