extends Node2D

func _enable(enable = true):
	if enable:
		$Display.show()
		$Display/ContinueButton.disabled = false
		$Display/SaveButton.disabled = false
		$Display/ExitButton.disabled = false
		$Display/LoadButton.disabled = false
	else:
		$Display.hide()
		$Display/ContinueButton.disabled = true
		$Display/SaveButton.disabled = true
		$Display/LoadButton.disabled = true
		$Display/ExitButton.disabled = true


func _on_ContinueButton_pressed():
	get_tree().paused = false
	_enable(false)

func _on_SaveButton_pressed():
	var save = get_parent().get_parent().get_parent().get_node("Save_handler")
	save.save_game()

func _on_LoadButton_pressed():
	var save = get_parent().get_parent().get_parent().get_node("Save_handler")
	save.load_game()
	get_tree().paused = false
	_enable(false)

func _on_ExitButton_pressed():
	get_tree().quit()
