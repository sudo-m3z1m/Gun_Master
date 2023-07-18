extends Node2D

class_name SAVE_HANDLER

func pack_and_save_scene(_root):
	var scene = PackedScene.new()
	scene.pack(_root)
	ResourceSaver.save(scene, GlobalScope.SAVE_FILE_DIRECTORY)
	scene = scene.instantiate()

func load_saved_scene():
	var scene = ResourceLoader.load(GlobalScope.SAVE_FILE_DIRECTORY)
	get_tree().change_scene_to_packed(scene)
