extends Control

@onready var start_button = %StartButton
@onready var exit_button = %ExitButton
@export var first_level: PackedScene

func _ready() -> void:
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
