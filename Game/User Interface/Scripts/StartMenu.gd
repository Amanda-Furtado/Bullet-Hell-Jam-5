extends Control


@export var first_level: PackedScene
@export var settings_scene: PackedScene

@onready var start_button = %StartButton
@onready var exit_button = %ExitButton
@onready var config_button = %ConfigButton

@onready var button_audio = $ButtonAudio


func _ready() -> void:
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	button_audio.play()
	start_button.disabled = true
	SceneManager.load_new_scene(first_level.resource_path)


func _on_config_button_pressed():
	SceneManager.load_new_scene(settings_scene.resource_path)


func _on_exit_button_pressed() -> void:
	get_tree().quit()


