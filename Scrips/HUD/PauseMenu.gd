extends CanvasLayer

func set_enable(enable = true):
	if enable:
		get_tree().paused = enable
		show()
		for node in get_children():
			if node is Button:
				node.disabled = false
	else:
		hide()
		for node in get_children():
			if node is Button:
				node.disabled = true

func _on_ContinueButton_pressed():
	set_enable(false)
	get_tree().paused = false

func _on_settings_button_button_down():
	set_enable(false)
	get_parent().set_enable_hud(GlobalScope.GLOBAL_HUDS.SETTINGS, true)

func _on_SaveButton_pressed():
	var _scene: Node2D = get_tree().current_scene
	SaveHandler.pack_and_save_scene(_scene)

func _on_LoadButton_pressed():
	SaveHandler.load_saved_scene()
	get_tree().paused = false
	set_enable(false)

func _on_ExitButton_pressed():
	get_tree().quit()
