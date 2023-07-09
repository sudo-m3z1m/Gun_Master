extends Node


@export var disabled: bool = false:
	set(_disabled):
		disabled = _disabled
		disable_sounds(_disabled)

var sound_volume: float = 80:
	set(_new_volume):
		update_sound_volume(_new_volume - sound_volume)
		sound_volume = _new_volume

var music_volume: float = 80:
	set(_new_volume):
		update_music_volume(_new_volume - music_volume)
		music_volume = _new_volume

@onready var sounds: Node = $Sounds
@onready var music: Node = $Music
@onready var main_player: AudioStreamPlayer2D = $Music/Main
@onready var shop_player: AudioStreamPlayer2D = $Music/Shop
@onready var steps_player: AudioStreamPlayer2D = $Sounds/Steps
@onready var coins_player: AudioStreamPlayer2D = $Sounds/Coins

#func change_main_music(same_enums): maybe enums will be in one class
#	pass

func disable_sounds(disable: bool) -> void:
	if disable:
		self.process_mode = Node.PROCESS_MODE_DISABLED
		return
	self.process_mode = Node.PROCESS_MODE_INHERIT

func update_sound_volume(_delta: float) -> void:
	for sound_player in sounds.get_children():
		sound_player.volume_db += _delta

func update_music_volume(_delta: float) -> void:
	for music_player in music.get_children():
		music_player.volume_db += _delta
