extends Node2D

func _enable(enable = true):
	if enable:
		$Display.show()
		$Display/ContinueButton.disabled = false
		$Display/SettingsButton.disabled = false
		$Display/ExitButton.disabled = false
	
	else:
		$Display.hide()
		$Display/ContinueButton.disabled = true
		$Display/SettingsButton.disabled = true
		$Display/ExitButton.disabled = true


func _on_ContinueButton_pressed():
	get_tree().paused = false
	_enable(false)


func _on_SettingsButton_pressed():
	pass


func _on_ExitButton_pressed():
	get_tree().quit()
