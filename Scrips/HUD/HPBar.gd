extends TextureProgressBar

func update_count(hp):
	value = hp

func set_enable(_is_enabled: bool) -> void:
	visible = _is_enabled
