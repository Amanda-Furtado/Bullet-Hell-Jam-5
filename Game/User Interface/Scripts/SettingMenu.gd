extends Control


@export var main_menu = load("res://Game/User Interface/StartMenu.tscn")
@onready var button_audio = $ButtonAudio
@onready var music = $Music

@onready var master_audio_slider = $MarginContainer/HBoxContainer/AudioContainer/MasterAudioSlider
@onready var full_screen_check_button = $MarginContainer/HBoxContainer/AudioContainer/FullScreenCheckButton


func _ready() -> void:
	master_audio_slider.grab_focus()

func _on_return_button_pressed():
	SceneManager.load_new_scene(main_menu.resource_path)


func _on_sfx_audio_slider_drag_ended(value_changed):
	button_audio.play()


func _on_full_screen_check_button_toggled(toggled_on):
	if toggled_on != true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
