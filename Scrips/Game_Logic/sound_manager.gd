extends Node

@export var disabled: bool = false:
	set(_disabled):
		disabled = _disabled
		disable_sounds(_disabled)

var current_music: AudioStreamPlayer

@onready var main_player: AudioStreamPlayer = $Music/Main
@onready var shop_player: AudioStreamPlayer = $Music/Shop
@onready var main_menu_player: AudioStreamPlayer = $Music/MainMenu
@onready var coins_player: AudioStreamPlayer2D = $Sounds/Coins
@onready var steps_player: AudioStreamPlayer2D = $Sounds/Steps

@onready var musics: Dictionary = {
	"Main": main_player,
	"Shop": shop_player,
	"Main_menu": main_menu_player
}

func change_main_music(music_player: String):
	current_music = musics[music_player]
	current_music.play()

func disable_sounds(disable: bool) -> void:
	if disable:
		AudioServer.set_bus_mute(0, disable)
		return
	AudioServer.set_bus_mute(0, disable)
