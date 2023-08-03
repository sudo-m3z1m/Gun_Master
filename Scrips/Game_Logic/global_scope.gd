extends Node

class_name GLOBAL_SCOPE

const MAX_ENEMYS_NUMBER: int = 15
const START_MONEY: int = 0
const START_WAVE_TIME: int = 6
const SHOP_TIME: float = 15
const GAME_SPEED: float = 1 # It's for future maybe
const SAVE_FILE_DIRECTORY: String = "res://Saves/saves.tscn"

enum GLOBAL_HUDS{MAIN, MAIN_MENU, SETTINGS, PAUSE, HP, COIN, AMMO, OVER}
enum EFFECTS{POISON}
enum MUSICS{MAIN_MENU_MUSIC, GAME_OVER_MUSIC, SHOP_MUSIC, WAVES_MUSIC}
