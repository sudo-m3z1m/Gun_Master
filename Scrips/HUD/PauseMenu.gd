extends Node2D

func _enable(enable = true):
	if enable:
		$Display.show()
		$Display/ContinueButton.disabled = false
		$Display/SettingsButton.disabled = false
		$Display/SaveButton.disabled = false
		$Display/ExitButton.disabled = false
		$Display/LoadButton.disabled = false
	else:
		$Display.hide()
		$Display/ContinueButton.disabled = true
		$Display/SettingsButton.disabled = true
		$Display/SaveButton.disabled = true
		$Display/LoadButton.disabled = true
		$Display/ExitButton.disabled = true

func _on_ContinueButton_pressed():
	get_tree().paused = false
	_enable(false)

func _on_settings_button_button_down():
	$Display/Settings.visible = true

func _on_SaveButton_pressed():
	var _scene: Node2D = get_tree().current_scene
	SaveHandler.pack_and_save_scene(_scene)

func _on_LoadButton_pressed():
	SaveHandler.load_saved_scene()
	get_tree().paused = false
	_enable(false)

func _on_ExitButton_pressed():
	get_tree().quit()
