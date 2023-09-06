extends Label

func update_count(new_count):
	text = str(new_count)

func set_enable(_is_enabled: bool) -> void:
	visible = _is_enabled
