extends CanvasLayer

func _ready():
	$VBoxContainer/PlayButton.pressed.connect(play_pressed)
	$VBoxContainer/ExitButton.pressed.connect(exit_pressed)

func play_pressed():
	GameManager.reset_game()
	GameManager.start_game()
	set_enable(false)

func exit_pressed():
	get_tree().quit()

func set_enable(_is_enable: bool) -> void:
	for button in get_children():
		if button is Button:
			button.disabled = _is_enable
	visible = _is_enable
