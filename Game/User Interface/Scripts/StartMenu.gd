extends Control

@onready var start_button = %StartButton
@onready var exit_button = %ExitButton
@export var first_level: PackedScene
@onready var loading_screen = preload("res://Game/User Interface/LoadingScreen.tscn")

func _ready() -> void:
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	SceneManager.load_new_scene(first_level.resource_path)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
