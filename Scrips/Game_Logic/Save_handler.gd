extends Node2D

class_name SAVE_HANDLER

const SAVE_FILE_DIRECTORY = "res://Saves/saves.tscn"
@onready var root = get_tree().get_root()

func pack_and_save_scene(_root):
	var scene = PackedScene.new()
	scene.pack(_root)
	ResourceSaver.save(scene, SAVE_FILE_DIRECTORY)
	scene = scene.instantiate()

func load_saved_scene():
	var scene = ResourceLoader.load(SAVE_FILE_DIRECTORY)
	get_tree().change_scene_to_packed(scene)
