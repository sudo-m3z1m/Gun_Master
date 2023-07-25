extends CanvasLayer

@onready var wave_counter: Label = $VBoxContainer/WaveCounter
@onready var time_counter: Label = $VBoxContainer/Time

func update_count(time_left: int, _wave_count: int):
	time_counter.text = str(time_left)
	wave_counter.text = "Wave " + str(_wave_count)

func set_enable(_is_enabled: bool) -> void:
	visible = _is_enabled
