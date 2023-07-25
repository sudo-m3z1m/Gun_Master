extends Control

@onready var music_slider: HSlider = $VBoxContainer/HBoxContainer2/MusicSlider
@onready var sound_slider: HSlider = $VBoxContainer/HBoxContainer3/SoundSlider
@onready var min_db_volume: float = -40

enum  BUS_INDEXES{MASTER, SFX, MUSIC}

func _ready():
	music_slider.drag_ended.connect(update_music_volume)
	sound_slider.drag_ended.connect(update_sounds_volume)

func _on_back_pressed():
	set_enable(false)
	get_parent().current_menu.set_enable(true)

func set_enable(_is_enabled: bool) -> void:
	visible = _is_enabled

func update_music_volume(_changed: bool) -> void:
	if !_changed:
		return
	var new_volume: float = get_db_from_percent(music_slider.value)
	AudioServer.set_bus_volume_db(BUS_INDEXES.MUSIC, new_volume)

func update_sounds_volume(_changed: bool) -> void:
	if !_changed:
		return
	var new_volume: float = get_db_from_percent(sound_slider.value)
	AudioServer.set_bus_volume_db(BUS_INDEXES.SFX, new_volume)

func _on_check_button_pressed():
	$Video.visible = true
	$Video.play()
	
func _on_video_finished():
	$Video.visible = false

func get_db_from_percent(percentage: float) -> float:
	var delta_volume: float = (percentage * -min_db_volume) / 100
	var new_volume: float = min_db_volume + delta_volume
	return new_volume
