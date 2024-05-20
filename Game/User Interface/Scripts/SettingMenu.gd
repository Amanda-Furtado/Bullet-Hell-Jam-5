extends Control


@export var main_menu = load("res://Game/User Interface/StartMenu.tscn")
@onready var button_audio = $ButtonAudio
@onready var music = $Music


func _on_return_button_pressed():
	SceneManager.load_new_scene(main_menu.resource_path)


func _on_sfx_audio_slider_drag_ended(value_changed):
	button_audio.play()