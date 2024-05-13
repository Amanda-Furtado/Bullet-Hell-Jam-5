extends Control

@onready var start_button = %StartButton
@onready var exit_button = %ExitButton


func _ready() -> void:
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
