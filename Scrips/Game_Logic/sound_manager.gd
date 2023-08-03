extends Node

@export var disabled: bool = false:
	set(_disabled):
		disabled = _disabled
		disable_sounds(_disabled)

var current_music: AudioStreamPlayer = AudioStreamPlayer.new()

@onready var main_player: AudioStreamPlayer = $Music/Main
@onready var shop_player: AudioStreamPlayer = $Music/Shop
@onready var main_menu_player: AudioStreamPlayer = $Music/MainMenu
@onready var game_over_player: AudioStreamPlayer = $Music/GameOver
@onready var coins_player: AudioStreamPlayer2D = $Sounds/Coins
@onready var steps_player: AudioStreamPlayer2D = $Sounds/Steps

@onready var musics: Dictionary = {
	GlobalScope.MUSICS.WAVES_MUSIC: main_player,
	GlobalScope.MUSICS.SHOP_MUSIC: shop_player,
	GlobalScope.MUSICS.MAIN_MENU_MUSIC: main_menu_player,
	GlobalScope.MUSICS.GAME_OVER_MUSIC: game_over_player
}

func change_main_music(_music: int, _time: float = 0.0) -> void:
	current_music.stop()
	current_music = musics[_music]
	current_music.play(_time)

func disable_sounds(disable: bool) -> void:
	if disable:
		AudioServer.set_bus_mute(0, disable)
		return
	AudioServer.set_bus_mute(0, disable)
