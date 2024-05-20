extends Control


@export var main_menu = load("res://Game/User Interface/StartMenu.tscn")
@onready var button_audio = $ButtonAudio
@onready var music = $Music
@onready var replay_button = %ReplayButton


func _ready() -> void:
	replay_button.grab_focus()


func _on_replay_button_pressed():
	button_audio.play()
	replay_button.disabled = true
	SceneManager.load_new_scene(main_menu.resource_path)
