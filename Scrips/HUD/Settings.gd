extends Control

@onready var music_slider: HSlider = $VBoxContainer/HBoxContainer2/MusicSlider
@onready var sound_slider: HSlider = $VBoxContainer/HBoxContainer3/SoundSlider

enum  BUS_INDEXES{MASTER, SFX}

func _ready():
	music_slider.drag_ended.connect(update_music_volume)
	sound_slider.drag_ended.connect(update_sounds_volume)

func _on_back_pressed():
	visible = false

func update_music_volume(_changed: bool) -> void:
	if !_changed:
		return
	var new_volume: float = get_db_from_percent(music_slider.value)
	SoundManager.music_volume = new_volume
#	AudioServer.set_bus_volume_db(BUS_INDEXES.MASTER, new_volume)
#	print(AudioServer.get_bus_volume_db(BUS_INDEXES.MASTER))

func update_sounds_volume(_changed: bool) -> void:
	if !_changed:
		return
	var new_volume: float = get_db_from_percent(sound_slider.value)
	SoundManager.sound_volume = new_volume
#	AudioServer.set_bus_volume_db(BUS_INDEXES.SFX, new_volume)
#	print(AudioServer.get_bus_volume_db(BUS_INDEXES.SFX))

func _on_check_button_pressed():
	$Video.visible = true
	$Video.play()

func get_db_from_percent(_percentage: float) -> float:
	return (_percentage * 80) / 100
