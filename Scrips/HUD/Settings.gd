extends Control

@onready var music_slider: HSlider = $VBoxContainer/HBoxContainer2/MusicSlider
@onready var sound_slider: HSlider = $VBoxContainer/HBoxContainer3/SoundSlider

func _ready():
	music_slider.drag_ended.connect(update_music_volume)
	sound_slider.drag_ended.connect(update_sounds_volume)

func _on_back_pressed():
	visible = false

func update_music_volume(_changed: bool) -> void:
	if !_changed:
		return
	SoundManager.music_volume = music_slider.value

func update_sounds_volume(_changed: bool) -> void:
	if !_changed:
		return
	SoundManager.sound_volume = sound_slider.value

func _on_check_button_pressed():
	$Video.visible = true
	$Video.play()
