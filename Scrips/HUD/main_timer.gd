extends CanvasLayer

func update_count(time_left: int, _wave_count: int):
	$TimerScore.text = str(time_left)
	$WaveCounter.text = "Wave " + str(_wave_count)

func set_enable(_is_enabled: bool) -> void:
	visible = _is_enabled
